function [projections extrafeatures] = calc_projs_perchan(Spikes,thesePCs);
% Calcualte projections of spikes on given PCs
% This version only projects one channel at a time
% Another difference is that I do not have the extra features that I have
% with the version that projects on all shanks at the same time. It is both
% because it makes things easier and faster (no need to load evrything at
% once), but also because these features proved not to be helpful during
% spike sorting.
%
% each row in AllSpikes contains data for one spike - the indexing required in the full shank version are much  
% easier here.
%

PLOT_RESULT = 0; % This option is not for routine use, but for debugging.

projections = [];

% Calculate the projections, and also calculate the peaks and ratios for
% each of the channels
for i = 1:Nchans
    theseSpikes = double(AllSpikes(:,(i-1)*SpikeLen + [1:SpikeLen]));
    theseProjections = theseSpikes*(thesePCs{i});
    
    % make prjections for all non detected spikes to 0.
    if IgnoreNonDetected
        detected = AllSources(:,i);
        D2 = repmat(detected,1,size(theseProjections,2));
        theseProjections = theseProjections .* double(D2);
    end
    
    projections = [projections theseProjections];         
    energy(:,i) = sum(theseSpikes'.*theseSpikes');
    maxs(:,i)   = max(theseSpikes');
    mins(:,i)   = min(theseSpikes');
    amps(:,i)    = maxs(:,i) - mins(:,i);
    means = mean(theseSpikes');    
    peaks(:,i)     = maxs(:,i)  - means(:,i);
    troughs(:,i)   = abs(means(:,i) - mins(:,i));
    %rats(:,i)   = (maxs - means)./(means - mins);
end

[max_energy,max_channel] = max(energy');
[max_peak,tmp] = max(peaks');
[max_trough,tmp] = max(troughs');

extrafeatures = [max_peak',max_trough',max_energy',max_channel'];
 
% % Now I want to take a look at the result:
% if PLOT_RESULT
%     figure
%     for j = 1:length(projections)
% 
%         thismax_energy = max_energy(j);
%         thismax_channel = max_channel(j);
%         thismax_peak = max_peak(j);
%         thismax_trough = max_trough(j);
%         genstr = ['N=' num2str(j) ' maxE: ' num2str(thismax_energy) ' maxChan: ' num2str(thismax_channel) ' maxP ' num2str(thismax_peak) ' maxT: ' num2str(thismax_trough)];
% 
%         for i = 1:Nchans
%             thisSpike = double(AllSpikes(j,(i-1)*SpikeLen + [1:SpikeLen]));
%             subplot(4,2,i)
%             ph = plot(thisSpike);
%             set(gca,'xlim',[0 length(thisSpike)],'xtick',[])
%             projvals = [projections(j,i*2-1:i*2)];
%             detected = AllSources(j,i);
%             if detected
%                 set(ph,'color','r')
%             end
%             thispeak = peaks(j,i);
%             thistrough = troughs(j,i);
% 
%             hold on
%             plot(100*thesePCs{i},'k')
%             hold off
% 
% 
%             if i == 1
%                 titstr = [genstr  'projs: ' num2str(projvals) ' p: ' num2str(thispeak)  ' t: ' num2str(thistrough) ];
%             else
%                 titstr = [' projs: ' num2str(projvals) ' p: ' num2str(thispeak)  ' t: ' num2str(thistrough) ];
%             end
%             title(titstr)
%         end
% 
%         R = input('Continue? q to quit .... ','s')
%         if strcmp(R,'q')
%             break
%         end
%     end
% end

return