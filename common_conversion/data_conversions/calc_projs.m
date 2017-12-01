function [projections extrafeatures] = calc_projs(AllSpikes,AllSources,SpikeLen,Nchans,thesePCs,IgnoreNonDetected);
% Calcualte projections of spikes on given PCs
% Also appends the maximum amplitude (maximum of min to max over all channels to each of the spikes)
% and the ratio, between positiv and negative peak for that chanel
%
% each row in AllSpikes contains data for one spike.
% the columns are divided into a number of contiguous sections which
% correspond to the number of channels within a group
% Thus, for a group with 4 channels and a spike of 100 samples, columns
% 1:100 will describe the spike as recorded by the first channel, columns
% 101:200 will describe the spikes as recorded by the second channel - etc
%
% 22/12/06 modified featyres and separated projections per-se from other
% features in returning parameters.
% IgnoreNonDetected is a flag that if set to one, makes values of all non
% detected spikes into 0. This is in attempt to eliminate noise associated
% with non neuronal signals.

PLOT_RESULT = 0; % This option is not for routine use, but for debugging.

projections = [];

% Calcualte the projections, and also calculate the peaks and ratios for
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
 
% Now I want to take a look at the result:
if PLOT_RESULT
    figure
    for j = 1:length(projections)

        thismax_energy = max_energy(j);
        thismax_channel = max_channel(j);
        thismax_peak = max_peak(j);
        thismax_trough = max_trough(j);
        genstr = ['N=' num2str(j) ' maxE: ' num2str(thismax_energy) ' maxChan: ' num2str(thismax_channel) ' maxP ' num2str(thismax_peak) ' maxT: ' num2str(thismax_trough)];

        for i = 1:Nchans
            thisSpike = double(AllSpikes(j,(i-1)*SpikeLen + [1:SpikeLen]));
            subplot(4,2,i)
            ph = plot(thisSpike);
            set(gca,'xlim',[0 length(thisSpike)],'xtick',[])
            projvals = [projections(j,i*2-1:i*2)];
            detected = AllSources(j,i);
            if detected
                set(ph,'color','r')
            end
            thispeak = peaks(j,i);
            thistrough = troughs(j,i);

            hold on
            plot(100*thesePCs{i},'k')
            hold off


            if i == 1
                titstr = [genstr  'projs: ' num2str(projvals) ' p: ' num2str(thispeak)  ' t: ' num2str(thistrough) ];
            else
                titstr = [' projs: ' num2str(projvals) ' p: ' num2str(thispeak)  ' t: ' num2str(thistrough) ];
            end
            title(titstr)
        end

        R = input('Continue? q to quit .... ','s')
        if strcmp(R,'q')
            break
        end
    end
end









return