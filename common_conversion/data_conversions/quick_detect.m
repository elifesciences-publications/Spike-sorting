function OK = quick_detect(datadir,combined_datadir,SR,groups,do_groups,blocks,DT,DTmethod,Tb,Ta,SHOW_DETECT_RES,maxSN);

% maxspikevalinSDs - maximum values magnbitude of spikes in SDs relative to
% background signals

% data,thr,DT,Tb,Ta,SR,'takeLN',SHOW_DETECT_RES,maxspikeval

% The functions does not return arguments except the OK flag, but rather
% saves the following files:
% For each group in each block
%   1. A spikes time file
%   2. An initial cluster file, which is required along with the spike time file
%   to view detected spikes in neurscope - all spikes are assigned to the
%   same cluster in this file.
% The file Nspikes.mat which contains the number of spikes detected for
% each channel and each block. This is saved in the combined_directory.

%elecvarname = 'PDec'; 
elecvarname = 'Elec';



OK = 0;
thr = zeros(32); % This is as large as I will ever need probably - some values will remain null
                 % I need 32 because there may be probes with this number
                 % of channels in distinct groups

% First determine threshold
for group_ind = 1:length(do_groups)
    disp([' Detecting spikes in group' num2str(do_groups(group_ind))])
    for block_ind = 1:length(blocks)    % Loop over each of the blocks within a certain day
        % Load the file that contains the stimulation time info - there
        % is only one channel in this file always
        disp(['  block ' num2str(block_ind)])
        stim_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_stim_chan_1.mat'];
        if exist(stim_file_name,'file')
            load(stim_file_name);  
            disp(['will clean stims given in file ' stim_file_name])
        else
            stim_1 = [];
            disp(['no stims to clean (no such file: ' stim_file_name ')'])
        end        
        AllTimes = [];   TotSpikes = 0;
        % loop over channel groups within a block
        % (neuroscope channel numbers start with 0, whereas TDT names start with 1)
        channels = groups(do_groups(group_ind)).chans;
        for channel_ind = 1:length(channels) % loop over channels within a group within a block
            disp(['   channel ' num2str(channel_ind) ] )
            %%%%%%%%% DETECT SPIKES
            %Load data file and assign variables
            relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_' elecvarname '_chan_' num2str(channels(channel_ind)) '.mat'];
   
            varname = [elecvarname '_' num2str(channels(channel_ind))];
            eval(['load (''' relfile ''',''' varname ''');'  'data =' varname ';' 'clear '  varname ';']);           
            
            % Clean data from artifacts - not !!!!
% %             if ~isempty(stim_1)
% %                 data = clean_stim_arts(data,stim_1,SR,maxSN);
% %             end
            
            % Calculate the threshold only if this is the first block
            if ~thr(do_groups(group_ind),channel_ind)
                thr(do_groups(group_ind),channel_ind) = threshold(data);
            end
            
            maxspikeval = std(data) * maxSN;
            [SpikeInds SpikeD{channel_ind}] = return_detected_spike_inds(data,thr(do_groups(group_ind),channel_ind),DT,Tb,Ta,SR,'takeLN',SHOW_DETECT_RES,maxspikeval);
            TotSpikes = TotSpikes + length(SpikeInds);

            % Save the spike times in a special directory - the idea here is to plot the spike times at a veyr fast first pass of the data
            % prior to clustering and disregarding any group related data
            varname = ['spiketimes_b' num2str(blocks(block_ind)) '_c' num2str(channels(channel_ind))];
            eval([varname ' = SpikeInds/SR;']);            
            spiketime_fname =  [combined_datadir 'per_channel_detections.mat']
            if ~(exist(spiketime_fname) == 2)
                eval(['save (''' spiketime_fname ''',''' varname ''')'])
            else
                eval( ['save (''' spiketime_fname ''',''' varname  ''',''-APPEND'')' ])
            end
            eval(['clear ' varname]);
            
            % No deadtime calculated across channels
            AllTimes = union(AllTimes, SpikeInds);
            clear SpikeInds;
        end % of channels within a group
        Nspikes(do_groups(group_ind),block_ind) = length(AllTimes);

        % designate all spikes as one cluster, this is for Neuroscope for
        % optional initial examining of detected spikes.
%         cluster_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.clu.' groups(do_groups(group_ind)).name];
%         fid = fopen(cluster_file_name,'w');
%         fprintf(fid,'%2.0f \n',1);
%         for i = 1:length(AllTimes)
%             fprintf(fid,'%2.0f \n',1);
%         end
%         fclose(fid);

%         % Spike time file, for Neuroscope
%         spiketime_file_name = [datadir  'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.res.' groups(do_groups(group_ind)).name];
%         fid = fopen(spiketime_file_name,'wt+');
%         for i = 1:length(AllTimes)
%             fprintf(fid,'%2.0f \n',AllTimes(i));
%         end
%         fclose(fid);
    end % over blocks
end % over groups

% save the Nspikes info in the combined data directory
% eval(['save ' combined_datadir 'Nspikes Nspikes thr' ]);

OK = 1;

return
