function [SpikeInds SpikeData] = return_detected_spike_inds(D,Thresh,DT,Tb,Ta,SR,DT_method,Polarity);
% Get the (processed) signal and return the indices where spikes are found.
%
% SR is sampling rate in Hz
% DT is dead time in seconds
% Tb and Ta are the times before and after the spike peak to be extracted in ms
%
% NOTE: this is a simplified version, with fat removed. YBS 21/12/06

Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after

SpikeInds = [];

% Find the peaks - which are defined as these points where the slope before and slope after are different sign
Slope_Sign  = sign(diff(D));

% First term is the slope to the second point until the one before last
% Second term is the slope from the second point until the last 

%All_Peaks = find(abs(Slope_Sign(1:end-1) + Slope_Sign(2:end)) < 2); % semi real extreme - see below
%All_Peaks = All_Peaks + 1;

Pos_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) <  2   & Slope_Sign(1:end-1) > 0);
Neg_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) > -2   & Slope_Sign(1:end-1) < 0);
Pos_Peaks = Pos_Peaks + 1;
Neg_Peaks = Neg_Peaks + 1;


% Get the spikes for the absolute detection criterion
% switch Polarity
%     case 'either'
%         SpikeInds = intersect(All_Peaks,find(abs(D) > Thresh));
%     case 'positive'
%         SpikeInds = intersect(All_Peaks,find(D > Thresh));
%     case 'negative'
%         SpikeInds = intersect(All_Peaks,find(D < -Thresh));
% end
PosSpikeInds1 = intersect(Pos_Peaks,find(D > Thresh));
NegSpikeInds1 = intersect(Neg_Peaks,find(D < -Thresh));

% It is criticial to take these spikes


% % % 
% % % show_detection_result(D,PosSpikeInds1,NegSpikeInds1,1,200,Si,Sb,Sa);
% % % title('stage 1')


% Take the largest of the positives
[PosSpikeInds2 Kept_Spikes] = apply_dead_time(PosSpikeInds1,'takeLP',DT,Si,D);


% % % show_detection_result(D,PosSpikeInds2,NegSpikeInds1,1,200,Si,Sb,Sa);
% % % title('stage 2')


SpikeInds1 = union(PosSpikeInds2,NegSpikeInds1);
 
[SpikeInds2 Kept_Spikes] = apply_dead_time(SpikeInds1,'takeLN',DT,Si,D);
NegSpikeInds = SpikeInds2(find(D(SpikeInds2) < -Thresh));
PosSpikeInds = SpikeInds2(find(D(SpikeInds2) >  Thresh));

% % % show_detection_result(D,PosSpikeInds,NegSpikeInds,1,200,Si,Sb,Sa);
% % % title('stage 3')


% % % % % % %relaxedinds = find(D < - 0.25 * Thresh);
% % % % % % relaxedinds = 1:length(D);
% % % % % % RelaxedNegPeaks    = intersect(Neg_Peaks,relaxedinds); % Times of these spikes
% % % % % % %RelaxedNegPeaks    = Neg_Peaks;
% % % % % % RelaxedNegVals     = D(RelaxedNegPeaks); % Vales of these spikes


% Now for each posSpikeInd
% profile on
NewPosPeaks = [];
tic;
%k = 1;
l = 1;
%nf = 0;
%disp('finding negative peaks for positive peaks')
% cannot use spikes that are too close to the beginning - spikes that are
% too close to the end will be later deleted too.
PosSpikeInds = PosSpikeInds(find(PosSpikeInds > Sb));
for i = 1:length(PosSpikeInds)
    thispeak = PosSpikeInds(i);
    thisseg = D(thispeak - Sb:thispeak);  
    %plot(thisseg)   
    this_Slope_Sign  = sign(diff(thisseg));
    this_Neg_Peaks = find( (this_Slope_Sign(1:end-1) + this_Slope_Sign(2:end)) > -2   & this_Slope_Sign(1:end-1) < 0) + 1;
    if ~isempty(this_Neg_Peaks)
        this_Neg_vals  = thisseg(this_Neg_Peaks);
        [tmp tmp2] = min(this_Neg_vals);
        NP = this_Neg_Peaks(tmp2);
        NP = NP + thispeak - Sb - 1;
        NewPosPeaks(l) = NP;
        l = l + 1;
    end
    
%     [tmp NP] = min(thisseg);
%     if NP > 1 % I do not want it to be the first sample, that is, it has to be a real negative peak
%         NP = NP + thispeak - Sb - 1;
%         NewPosPeaks(l) = NP;
%         l = l + 1;
%     end
% 
%     if NP ~= NP1
%         disp('ouch ....')
%     end
    
    % Find the smallest minimum within a dead time to it
% % % % % %     relinds = find((RelaxedNegPeaks < thispeak) & (RelaxedNegPeaks > (thispeak-Sb))); 
    
%     This turned out not to be faster    
%     tmp = RelaxedNegPeaks((RelaxedNegPeaks < thispeak)); 
%     relinds =  find(tmp > (thispeak-Sb));
    
%     if sum(abs(relinds2 - relinds))
%         disp('woa woa woa ..... relinds2 and relinds1 are not the same ....')
%     end
    
% % % % % %     if ~isempty(relinds)
% % % % % %         relvals  = RelaxedNegVals(relinds);
% % % % % %         [tmp minind] = min(relvals);
% % % % % %         NewPosPeaks(k) = RelaxedNegPeaks(relinds(minind));
% % % % % %         %% Next section for debuggin purposes
% % % % % % %         reldiffs = RelaxedNegPeaks(relinds);
% % % % % % %         reldiffs = reldiffs - thispeak;
% % % % % % %         Shifts1(k) = reldiffs(minind);
% % % % % %         k = k + 1;
% % % % % %     else
% % % % % %         nf = nf + 1;
% % % % % %         %disp('no negative peak found for this spike')
% % % % % %     end
% % % % % %     
% % % % % %     if NewPosPeaks2(l-1) ~= NewPosPeaks(k-1)
% % % % % %         plot(D(thispeak - Sb:thispeak));
% % % % % %         hold on
% % % % % %         d1 = NewPosPeaks(l-1) - (thispeak - Sb)+1;
% % % % % %         d2 = NewPosPeaks2(l-1) - (thispeak - Sb)+1;
% % % % % %         tmp = D(thispeak - Sb:thispeak);
% % % % % %         plot(d1,tmp(d1),'r*');
% % % % % %         plot(d2,tmp(d2),'g*');
% % % % % %         hold off
% % % % % %         
% % % % % %        1 
% % % % % %     end
    
end
t2 = toc;
disp(['of : ' num2str(length(PosSpikeInds)) ' found a match for ' num2str(l)])
disp(['done finding negative for positive peaks - time: ' num2str(t2)])
% toc
% profile off
% profile report
SpikeInds = union(NegSpikeInds,NewPosPeaks);

%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%
%%%%%%%%%%%%

% Get the spikes for the absolute detection criterion
% if AbsT
%     SpikeInds = intersect(All_Peaks,find(abs(D) > Thresh));
% elseif PolT
%     % If we have to look separately for negative and positive peaks
%     Pos_SpikeInds = intersect(Pos_Peaks,find(D > Pos_Thresh));
%     Neg_SpikeInds = intersect(Neg_Peaks,find(D < Neg_Thresh));
%     SpikeInds = union(Pos_SpikeInds,Neg_SpikeInds);
% end
%%%%%%%%%%%%%%%%%


% % % show_detection_result(D,NewPosPeaks,NegSpikeInds,1,200,Si,Sb,Sa);
% % % title('stage 4')
        

% Retain spikes fully contained within the signal
SpikeInds = SpikeInds(find((SpikeInds > Sb) & (SpikeInds < (length(D) - Sa))));

% Apply dead time criterion
[SpikeInds Kept_Spikes] = apply_dead_time(SpikeInds,DT_method,DT,Si,D);
SpikeData = D(Kept_Spikes);

return

