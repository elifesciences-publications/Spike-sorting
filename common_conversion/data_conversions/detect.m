function detect(datadir,combined_datadir,SR,groups,do_groups,blocks,DT,Tb,Ta,ThreshFact,acDT,ArtRatio);
% maxspikevalinSDs - maximum values magnbitude of spikes in SDs relative to
% background signals
%
% For each group in each block
%   1. A spikes time file
%   this was commented out, since I do not use NeuroScope really anymore (12/06)
%   2. An initial cluster file, which is required along with the spike time file
%   to view detected spikes in neurscope - all spikes are assigned to the
%   same cluster in this file.
% The file Nspikes.mat which contains the number of spikes detected for
% each channel and each block. This is saved in the combined_directory.
% and the file FileDurations saved in the same directory, which contains
% the total file durations.
% Cleaned on 21/12/06 YBS (I decided not to remove stimulus artifacts at this stage, but only later during spike sorting, simplicity, you know ...)


% Should be temporary, only for figurting out the right artifact rejection
% value
DEBUG_ART_RATIO = 0;

% Relevant for applying dead time across channels
Si = 1/(SR/1000); % sampling interval (ms)

% initialize
Allthr = zeros(32);

% Run over groups
for group_ind = 1:length(do_groups)
    disp([' Detecting spikes in group' num2str(do_groups(group_ind))])
     channels = groups(do_groups(group_ind)).chans;
     
     %%JFB changes to move the XML file over to the newly created data
     %%folder
     current_directory=[combined_datadir 'group' num2str(do_groups(group_ind)) filesep];
     if ~(exist(current_directory) == 7)
         mkdir(current_directory);
         [copy_success, message_out,messageID_out]=copyfile('/home/pogo/Joe/Matlab scripts/Spike sorting/common_conversion/Data_defaults/combined1.xml',[current_directory,'combined',num2str(group_ind),'.xml'],'f');
         if ~copy_success; disp(['Creation of ',current_directory,'combined',num2str(group_ind),'.xml FAILED']);
         else; disp(['Creation of ',current_directory,'combined',num2str(group_ind),'.xml Complete']); end;
     end
    
    % Run over blocks
    
    % To calcualte the upper boundary of spike events from the first block
    % (without stimulations)
    MaxAmps = zeros(1,length(channels));
    
    for block_ind = 1:length(blocks)
        disp(['   block ' num2str(block_ind) ] )
        AllTimes = [];
        TotSpikes = 0;
        AllSourceChans = [];
        AllPeakData    = [];
        AllSpikeAmps  =  [];
        uniqueAllSourceChans = [];
        source_channels_mat  = [];
        % loop over channel groups within a block
        % (neuroscope channel numbers start with 0, whereas TDT names start with 1)
       
        % Run over channels within each block
        for channel_ind = 1:length(channels) % loop over channels within a group within a block

            disp(['    channel ' num2str(channel_ind) ] )

            %%%%%%%%% DETECT SPIKES
            %Load data file and assign variables
            relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_Elec_chan_' num2str(channels(channel_ind)) '.mat'];
            varname = ['Elec_' num2str(channels(channel_ind))];
            eval(['load ' relfile ' ' varname ';' 'data =' varname ';' 'clear '  varname ';']);

            % File duration in seconds (all columns here should have the same values)
            AllFileDurations(block_ind,group_ind) = length(data);

            % Calculate the threshold only if this is the first block
            if ~Allthr(do_groups(group_ind),channel_ind)
                Allthr(do_groups(group_ind),channel_ind) = threshold(ThreshFact * data);
            end

            % Changed from takeLn on 1/1/7
            [SpikeInds SpikeAmps PeakData] = return_detected_spike_inds_cleaned(data,Allthr(do_groups(group_ind),channel_ind),DT,Tb,Ta,SR);
                    
            
            if ~MaxAmps(channel_ind) % Estimate the mean and Sd of the real spikes
                
                if isempty(SpikeInds) % This is a rare occasion ,and if it happens, it does not really matter what the size
                    MaxAmps(channel_ind)  = 0;
                else
                    MaxAmps(channel_ind)  = mean(SpikeAmps) + ArtRatio*std(SpikeAmps)
                end

                if DEBUG_ART_RATIO
                    figure; hist(double(SpikeAmps),100);
                    [ylims] = get(gca,'ylim');
                    hold on
                    line([MaxAmps(channel_ind) MaxAmps(channel_ind)],[ylims],'color','r')
                    title(['block ' num2str(block_ind) 'channel ' num2str(channel_ind)])
                end

            else

                if DEBUG_ART_RATIO
                    figure; hist(double(SpikeAmps),100);
                    [ylims] = get(gca,'ylim');
                    hold on
                    line([MaxAmps(channel_ind) MaxAmps(channel_ind)],[ylims],'color','r')
                    title(['block ' num2str(block_ind) 'channel ' num2str(channel_ind)])
                end

                StartN = length(SpikeAmps);
                NotTooBig = find(SpikeAmps <= MaxAmps(channel_ind));
                SpikeInds = SpikeInds(NotTooBig);
                SpikeAmps = SpikeAmps(NotTooBig);
                PeakData  = PeakData(NotTooBig);
                Ndel = StartN - length(SpikeAmps);
                
                disp(['Deleted ' num2str(Ndel) ' waveforms of ' num2str(StartN)  ' in block ' num2str(block_ind) ' channel ' num2str(channel_ind)])
                
            end
            
            % collected for tracking source detection channel(s)
            SourceChans = int8(channel_ind * ones(size(SpikeInds)));
            % Counter for number of spikes
            TotSpikes = TotSpikes + length(SpikeInds);
            % This is a quick way to get at spike times without doing spike sorting.
            varname = ['spiketimes_b' num2str(blocks(block_ind)) '_c' num2str(channels(channel_ind))];
            eval([varname ' = SpikeInds/SR;']);
            spiketime_fname =  [combined_datadir 'per_channel_detections.mat'];
            if  exist(spiketime_fname) == 2
                eval(['save ' spiketime_fname ' ' varname  ' -APPEND'])
            else
                eval(['save ' spiketime_fname ' ' varname])
            end
            eval(['clear ' varname]);

            % Collect spike times and sources across channels -
            % Note detection dead time is not calculated across channels !!!!
            AllPeakData         = [AllPeakData PeakData];
            AllTimes            = [AllTimes SpikeInds];
            AllSourceChans      = [AllSourceChans SourceChans];
            AllSpikeAmps        = [AllSpikeAmps SpikeAmps];            
            [AllTimes sortinds] = sort(AllTimes);
            AllSourceChans      = AllSourceChans(sortinds);
            AllPeakData         = AllPeakData(sortinds);
            AllSpikeAmps        = AllSpikeAmps(sortinds);

        end % of channels within a group
       
        
        % Apply dead time criterion - across channels
        %[AllTimes Kept_Spikes] = apply_dead_time2(AllTimes,'takeLN',acDT,Si,AllPeakData);
        % This is when using the spike amps as criteria
        [AllTimes Kept_Spikes] = apply_dead_time2(AllTimes,'takeLP',acDT,Si,AllSpikeAmps);
        AllPeakData    = AllPeakData(Kept_Spikes);
        AllSourceChans = AllSourceChans(Kept_Spikes);
        AllSpikeAmps   = AllSpikeAmps(Kept_Spikes);

        % treat spikes detected across multiple channels
        % disp(['cleaning double spikes for group ' num2str(do_groups(group_ind))])
        uniqueAllTimes = unique(AllTimes);
        nonuniques = length(AllTimes) - length(uniqueAllTimes);
        % Retain the source chanels of each spike - this can be used later for feature analysis
        
        % This is kind of redundant as times in AllTimes are by definition
        % unique since they were cleaned for overlaps - but I wish not to
        % touch it here further.
        source_channels_mat = zeros(length(uniqueAllTimes),length(channels));
        for i = 1:length(uniqueAllTimes)
            these = find(AllTimes == uniqueAllTimes(i));
            source_channels_mat(i,AllSourceChans(these)) = 1;
        end
        AllUniqueSourceChansMat{do_groups(group_ind),block_ind} = logical(source_channels_mat);
        AllNspikes(do_groups(group_ind),block_ind) = length(uniqueAllTimes);
                                     
        % Next block includes Neuroscope related files, which I do not
        % really use, so to reduce file production I commented these out.
        % Designate all spikes as one cluster, this is for Neuroscope for
        % optional initial examining of detected spikes.
        %         cluster_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.clu.' groups(do_groups(group_ind)).name];
        %         fid = fopen(cluster_file_name,'w');
        %         fprintf(fid,'%2.0f \n',1);
        %         for i = 1:length(AllTimes)
        %             fprintf(fid,'%2.0f \n',1);
        %         end
        %         fclose(fid);

        % Spike time file, Neuroscope format but also for the subsequent
        % extraction
        spiketime_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_group' num2str(do_groups(group_ind)) '.res.1'];
        %spiketime_file_name = [datadir  'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.res.' groups(do_groups(group_ind)).name];
        fid = fopen(spiketime_file_name,'wt+');
        for i = 1:length(uniqueAllTimes)
            % fprintf(fid,'%2.0f \n',AllTimes(i));
            fprintf(fid,'%2.0f \n',uniqueAllTimes(i));
        end
        fclose(fid);

    end % over blocks
    thr       = Allthr(do_groups(group_ind),:);
    Nspikes   = AllNspikes(do_groups(group_ind),:);
    FileDurations =  AllFileDurations(:,group_ind);
    UniqueSourceChansMat = AllUniqueSourceChansMat(do_groups(group_ind),:);
    % Added on 24/05/07 to make processing across groups independent 
    eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'Nspikes' groups(do_groups(group_ind)).name ' Nspikes thr' ]);
    eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'FileDurations' groups(do_groups(group_ind)).name ' FileDurations' ]);
    eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'SourceChans' groups(do_groups(group_ind)).name ' UniqueSourceChansMat' ]);

      
end % over groups

% save the Nspikes info in the combined data directory
eval(['save ' combined_datadir 'AllNspikes AllNspikes Allthr' ]);
eval(['save ' combined_datadir 'AllFileDurations AllFileDurations' ]);
eval(['save ' combined_datadir 'AllSourceChans AllUniqueSourceChansMat' ]);

return
