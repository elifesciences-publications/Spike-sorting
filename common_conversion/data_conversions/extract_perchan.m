function extract_perchan(datadir,combined_datadir,groups,do_groups,blocks,Tb,Ta,SR,IBI);
% based on extract, but i do not keep the data for all channels and do not
% write the combined spike file. This will be performed by a different
% function. The reason for doing this is that the AllSpikes matrix can be
% too large (~3GB).



% Select spikes from
% This function does not return results, except the OK flag.
% It writes the data in the following files:
% For each block and each group
% A spike (spk) file
% In the combined directory
%   1. A spike time file - one for each of the groups, containing information
%   for all blocks. Note that since blocks are not contunuous, and the actual time is not that critical, I employ
%   an interblock interval (IBI) in seconds to seperate subsqeuent files.
%   2. A cluster file
%   3. A spike shape file
% The SpikeLength (SpikeLen) - the number of samples in a spike is saved in
% the combined diretory in a mat file of the same name.

% This program assumes the existence of the spikes time files which are
% generated by the detect function


Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after
SpikeLen = Sb + Sa + 1;


% eval(['load ' combined_datadir 'AllNspikes']);
% eval(['load ' combined_datadir 'AllFileDurations' ]);
% 
for group_ind = 1:length(do_groups)
    disp(['Extracting spikes from group ' num2str(do_groups(group_ind))])

    %eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'Nspikes' groups(do_groups(group_ind)).name ' Nspikes thr' ]);
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'FileDurations' groups(do_groups(group_ind)).name ' FileDurations' ]);
    %eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'SourceChans' groups(do_groups(group_ind)).name ' UniqueSourceChansMat' ]);
          
    channels = groups(do_groups(group_ind)).chans;

    clear Times
    AllTimes = [];
    clear AllSpikes
    clear Spikes
    clear Nspikes
    LastTime = 0;

    for block_ind = 1:length(blocks)
        %%      disp([' block ' num2str(blocks(block_ind))])
        % Read the spike time indices from rpeviously written files
        spiketime_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_group' num2str(do_groups(group_ind)) '.res.1'];
        %spiketime_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.res.' groups(do_groups(group_ind)).name];
        fid = fopen(spiketime_file_name,'rt');
        Times{block_ind} = fscanf(fid,'%f');
        Nspikes(block_ind) = length(Times{block_ind});
        fclose(fid);
        AllTimes = [AllTimes; Times{block_ind} + LastTime]; % Accumulating over all blocks for this group
        %LastTime = LastTime + FileDurations(block_ind,group_ind) + (IBI*SR);
        LastTime = LastTime + FileDurations(block_ind) + (IBI*SR);
    end

    % Get the start and end segments for each block
    AllSpikes = zeros(length(AllTimes),SpikeLen);
    SpikeIndEnd = cumsum(Nspikes);
    SpikeIndStart = [0 SpikeIndEnd(1:end-1)]+1;

    % get spikes
    for channel_ind = 1:length(channels) % loop over channels within a group within a block

        disp(['  channel ' num2str(channel_ind)])
        for block_ind = 1:length(blocks)

            Spikes = [];

            disp([' block ' num2str(blocks(block_ind))])
            % Load data file and assign variables
            relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_Elec_chan_' num2str(channels(channel_ind)) '.mat'];
            varname = ['Elec_' num2str(channels(channel_ind))];
            eval(['load ' relfile ' ' varname ';' ]);
            eval(['data =' varname ';'])
            eval(['clear '  varname ';'])

            if ~isempty(Times{block_ind})
                [Spikes] = extract_spikes(data,Times{block_ind},Tb,Ta,SR);                                                
                %SpikeLen = size(Spikes{channel_ind},2);
            end
            % but these AllSpikes are per channel not for entire shank
            AllSpikes(SpikeIndStart(block_ind):SpikeIndEnd(block_ind),:) = Spikes;
        end % of channels within a group

        %  Generate the spike file for this channel, for all blocks !
        spike_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_chan_' num2str(channels(channel_ind))  '_spk.1'];
        fid = fopen(spike_file_name,'wb');                
        SpikeLen = length(AllSpikes(1,:));
        fwrite(fid,reshape(AllSpikes',1,prod(size(AllSpikes))),'integer*2');
        fclose(fid);
                      
    end % over blocks

    % Creating fake combined cluster file - for Klusters - I name it
    % fake_clu because I am not sure if it ever gets really used
    cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.fake_clu.1'];
    fid = fopen(cluster_file_name,'w');
    fprintf(fid,'%2.0f \n',1);
    for i = 1:length(AllTimes)
        fprintf(fid,'%2.0f \n',1);
    end
    fclose(fid);

    % Create combined spike time file
    spiketime_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined'  groups(do_groups(group_ind)).name '.res.1'];
    fid = fopen(spiketime_file_name,'w');
    for i = 1:length(AllTimes)
        fprintf(fid,'%2.0f \n',AllTimes(i));
    end
    fclose(fid);
    pack

    eval(['save ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_block_inds SpikeIndEnd  SpikeIndStart' ]);

end % over groups
eval(['save ' combined_datadir 'SpikeLen SpikeLen']);


return