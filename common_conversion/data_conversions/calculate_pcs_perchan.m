function OK = calculate_pcs_perchan(datadir,combined_datadir,groups,do_groups,PC_block,blocks,PeakSamp)
% calcualte PCs from the extracted spikes in the PC_block
% This implies that the PCs are based upon the results in one block only -
% this makes sense computationally and also because the first block should
% not contain any artifacts
%
%
%
% Played with several options on the 29/12/06 - now only calcualte PCs
% based on spikes detcted in that specific channel. Also, I use all spikes
% form all blocks, but I do try to restrict artifcats,by setting a
% threshold. I also tried calculating PCs based on straightened spike (i.e.
% all peaks made positive), but gave this up as it did not yield nicer PCs.

OK = 0;
REALIGN_SPIKES = 0;

% Threshold for maximum allowed spike magnitude, relative to largest peak
% in Pc block which does not include stimulation
aT = 5;         % Artifact threshold - anything that is this times as large or more than the maximum value in the PC block is not regarded
% as a spike and will not be used ofr calcualting PCs

% Load number of spikes and spike length information
%%%eval(['load ' combined_datadir 'Nspikes']);
eval(['load ' combined_datadir 'SpikeLen']);
%%%eval(['load ' combined_datadir 'SourceChans' ]); % to load  AllUniqueSourceChansMat

% Collect all Spikes
for group_ind = 1:length(do_groups)

    %eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'Nspikes' groups(do_groups(group_ind)).name ' Nspikes thr' ]);
    %eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'FileDurations' groups(do_groups(group_ind)).name ' FileDurations' ]);
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'SourceChans' groups(do_groups(group_ind)).name ' UniqueSourceChansMat' ]);

    % Get the source channels
    AllSources = [];
    %     for block_ind = 1:length(blocks)
    %         Sources = AllUniqueSourceChansMat{do_groups(group_ind),block_ind};
    %         AllSources = [AllSources; Sources];
    %     end
    for block_ind = 1:length(blocks)
        Sources = UniqueSourceChansMat{block_ind};
        AllSources = [AllSources; Sources];
    end


    disp(['group ' groups(do_groups(group_ind)).name])
    fh1 = figure;
    fh2 = figure;
    eval(['load ' combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_block_inds' ]);

    channels = groups(do_groups(group_ind)).chans;
    % get spikes
    for channel_ind = 1:length(channels) % loop over channels within a group within a block

        clear Spikes
        clear SpikePeaks

        this_chan = channels(channel_ind);
        disp([' channel ' num2str(this_chan)])

        spike_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_chan_' num2str(this_chan)  '_spk.1'];
        fid = fopen(spike_file_name,'rb');
        Spikes = fread(fid,'integer*2');
        fclose(fid);

        % Reshape it into a matrx where each spike is one row
        Spikes = reshape(Spikes,SpikeLen,SpikeIndEnd(end))';

        % Get the maximum PC block peak
        pcbi = find(blocks == PC_block);
        inds = [SpikeIndStart(pcbi) : SpikeIndEnd(pcbi)];
        Max_PC_block_Peak = max(abs(Spikes(inds,PeakSamp)));

        % for pc calcualtion, leave only those spikes that were detected by
        % this channel
        realinds = find(AllSources(:,channel_ind));
        Spikes  = Spikes(realinds,:);

        % Delete large spikes which are likely artifacts, as well as
        % peaks that are larger than zero

        SpikePeaks = Spikes(:,PeakSamp);
        goodones =  find((abs(SpikePeaks) <= aT*Max_PC_block_Peak) & SpikePeaks < 0) ;
        Spikes = Spikes(goodones,:);

        % Delete spikes where the detected sample is not the lowest segment
        % of the spike - these are those that were detected on their
        % positive peak (and the peaksmple was taken as a preceeding negative peak)
        % The minimum, which is the negative peak for these spikes is
        % less than the threshold
        SpikePeaks = Spikes(:,PeakSamp);
        SpikeMins  = min(Spikes');
        goodones = find(SpikePeaks' == SpikeMins);
        Spikes = Spikes(goodones,:);

        % This block is an experimental part in which I tried to
        % To see whether realigning spikes helps a lot = well,it does not,
        % and it is very costly in time dfoing it (plus, how do you align multiple channels - which channel will dominate ?)
        % so, overall, I do nto delete the option, but conclude it is not cost effective.
        if REALIGN_SPIKES
            clear interpspikes;
            UpSampFact = 4;
            NewSpikeLen = SpikeLen * UpSampFact;
            for i = 1:size(Spikes,1);
                %interpspikes(i,:) = interp(Spikes(i,[PeakSamp-UpSampFact:PeakSamp+UpSampFact]),UpSampFact);
                interpspikes(i,:) = interp(Spikes(i,:),UpSampFact);
            end
            SegPeakSamp = UpSampFact + 1; % The loaction of the peak in the segment taken for calcualtion
            newPeakSamp = ((PeakSamp-1) * UpSampFact) + 1;
            [F1 ind] = min(interpspikes');

            % Discard those where the min samp is mroe than 4 samples away from
            % the original peak
            mindiffs = ind - newPeakSamp;
            goods = (abs(mindiffs) <= UpSampFact);
            interpspikes = interpspikes(goods,:);
            ind = ind(goods);

            shifts = ind - newPeakSamp;
            shifts = UpSampFact - shifts;

            AllignedSpikes = zeros(size(interpspikes,1),size(interpspikes,2)+2*(UpSampFact-1));
            for i = 1:size(interpspikes,1)
                AllignedSpikes(i,shifts(i):shifts(i)+NewSpikeLen-1) = interpspikes(i,:);
            end
            % For checking [F2 ind2] = min(AllignedSpikes');
            % For checking ninds = [fliplr([124:-4:1]) 128:4:size(interpspikes,2)]
            % Now ake every nth samp[le
            NewSpikes = AllignedSpikes(:,[UpSampFact:UpSampFact:NewSpikeLen]);
            % for checking [F3 ind3] = min(NewSpikes');
        end

        % Calculate PCS
        % Note that I am calling the ybs_princomp function which onlt
        % differs in that it does not subtract the column centers from X

        [thesepcs theseprojs thesevars] = ybs_princomp(zscore(Spikes')');

        
        %[thesepcs theseprojs thesevars] = princomp(zscore(Spikes')');
        
        % Commented out on 24 may 07, and replaced by the block below 
        % This allows for better group independency in processing
        %         pcs{this_chan}    = thesepcs;
        %         projs{this_chan}  = theseprojs;
        %         vars{this_chan}   = thesevars./sum(thesevars);
        pcs{channel_ind}    = thesepcs;
        projs{channel_ind}  = theseprojs;
        vars{channel_ind}   = thesevars./sum(thesevars);

        clear thesepcs theseprojs thesevars

        % Plot the result
        Npcs = 2;
        figure(fh1);
        subplot(length(channels),1,channel_ind)
        plot(pcs{channel_ind}(:,1:Npcs));
        set(gca,'xlim',[1 SpikeLen])
        title(['group: ' num2str(group_ind) '  chan: ' num2str(this_chan)])

        figure(fh2);
        subplot(length(channels),1,channel_ind)
        bar(vars{channel_ind}(1:3));%./sum(vars{channel_ind}));
        set(gca,'xlim',[0 4],'ylim',[0 1],'ytick',[0:0.1:1])
        title(['group: ' num2str(group_ind) '  chan: ' num2str(this_chan)])
    end

    eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'pcdata' groups(do_groups(group_ind)).name ' pcs vars' ]);

    %eval(['save ' combined_datadir  'pcdata pcs vars']);
end

%eval(['save ' combined_datadir  'pcdata pcs vars']);

OK = 1;


return