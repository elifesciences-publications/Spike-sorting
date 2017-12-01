function [SpikeInds SpikeAmps SpikePeaks] = return_detected_spike_inds_cleaned(D,Thresh,DT,Tb,Ta,SR);
% Get the (processed) signal and return the indices where spikes are found.
%
% SR is sampling rate in Hz
% DT is dead time in seconds
% Tb and Ta are the times before and after the spike peak to be extracted in ms
%
% NOTE: this is a simplified version, with fat removed. YBS 20/01/06
% For a more complete version with some other algorithms I tried, see the
% function with the same name without the cleaned.

Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after

SpikeInds = [];
SpikeAmps = [];
SpikePeaks = [];

% Find the peaks - which are defined as these points where the slope before and slope after are different sign
Slope_Sign  = sign(diff(D));

% First term is the slope to the second point until the one before last
% Second term is the slope from the second point until the last
Pos_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) <  2   & Slope_Sign(1:end-1) > 0);
Neg_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) > -2   & Slope_Sign(1:end-1) < 0);
Pos_Peaks = Pos_Peaks + 1;
Neg_Peaks = Neg_Peaks + 1;

PosSpikeInds1 = intersect(Pos_Peaks,find(D > Thresh));
NegSpikeInds1 = intersect(Neg_Peaks,find(D < -Thresh));

% % % show_detection_result(D,PosSpikeInds1,NegSpikeInds1,1,200,Si,Sb,Sa);
% % % title('stage 1')

% Take the largest of the positives - I do this to save computation time
% in the loop below
[PosSpikeInds2 Kept_Spikes] = apply_dead_time(PosSpikeInds1,'takeLP',DT,Si,D);

SpikeInds1 = union(PosSpikeInds2,NegSpikeInds1);
% Apply dead time for negative and positive, negatives taking precedence
[SpikeInds2 Kept_Spikes] = apply_dead_time(SpikeInds1,'takeL',DT,Si,D);
%[SpikeInds2 Kept_Spikes] = apply_dead_time(SpikeInds1,'takeLN',DT,Si,D); % That was the original
% Parse them back into negative and positive
NegSpikeInds = SpikeInds2(find(D(SpikeInds2) < -Thresh));
PosSpikeInds = SpikeInds2(find(D(SpikeInds2) >  Thresh));

% Now for each posSpikeInd
NewPosPeaks = [];
l = 1; % Counter for new found negative indices

% cannot use spikes that are too close to the beginning - spikes that are
% too close to the end will be later deleted too.
PosSpikeInds = PosSpikeInds(find(PosSpikeInds > Sb));

% Retain spikes fully contained within the signal
PosSpikeInds = PosSpikeInds(find((PosSpikeInds > Sb*2) & (PosSpikeInds < (length(D) - Sa))));

% For each of the segments we find a minimum and take the minimum with the
% lowest value as the new peak.
for i = 1:length(PosSpikeInds)
    thispeak = PosSpikeInds(i);
    thisseg = D(thispeak - Sb:thispeak);
    this_Slope_Sign  = sign(diff(thisseg));
    this_Neg_Peaks = find( (this_Slope_Sign(1:end-1) + this_Slope_Sign(2:end)) > -2   & this_Slope_Sign(1:end-1) < 0) + 1;
    if ~isempty(this_Neg_Peaks)
        this_Neg_vals  = thisseg(this_Neg_Peaks);
        [tmp tmp2] = min(this_Neg_vals);
        NP = this_Neg_Peaks(tmp2);
        NP = NP + thispeak - Sb - 1;

        % Find the position of the minimum value of the new spike
        %[tmp NewMinInd] = min(D(NP-Sb:NP+Sa));
        % Changing so that it is only the lowest in the first half, this
        % could cause problems too, suree
        [tmp NewMinInd] = min(D(NP-Sb:NP));
                        
        % we make sure that also after shifting the spike peak, this
        % begative peak remains the lowest part of the spike
        if (NewMinInd == Sb + 1)
            NewPosPeaks(l) = NP;
            l = l + 1;
        end
    end
end

% Combine spikes
SpikeInds = union(NegSpikeInds,NewPosPeaks);

% Retain spikes fully contained within the signal
SpikeInds = SpikeInds(find((SpikeInds > Sb) & (SpikeInds < (length(D) - Sa))));

% Apply dead time criterion
% This was how it was before, which means take the lowest negative
% typically
%[SpikeInds Kept_Spikes] = apply_dead_time(SpikeInds,DT_method,DT,Si,D);
% but now, i will take the first one, since they are actually all negative
% now ...
[SpikeInds Kept_Spikes] = apply_dead_time(SpikeInds,'takeF',DT,Si,D);

for i = 1:length(SpikeInds)
    thisSpike =    (D([SpikeInds(i)-Sb:SpikeInds(i)+Sa]));
    SpikeAmps(i) = range(thisSpike);
end
    
SpikePeaks = D(SpikeInds);

return

