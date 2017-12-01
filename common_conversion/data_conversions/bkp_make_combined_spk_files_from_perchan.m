function make_combined_spk_files_from_perchan(datadir,combined_datadir,groups,do_groups,blocks,Tb,Ta,SR,IBI);
% Since in extract_perchan I am only making spike files per channel, here I
% need to combine them for the format recognized by Klusters.

Su = 10000; % maximal number of spikes per segment of file read - this is necessary so as not to use up too much memory
             % which will dramatically slow things down

eval(['load ' combined_datadir 'Nspikes']);
eval(['load ' combined_datadir 'FileDurations' ]);

Spikes_Per_Shank = sum(Nspikes,2);
Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after
SpikeLen = Sb + Sa + 1;



for group_ind = 1:length(do_groups)
    
    fid = [];
    
    disp(['generating spk file for group ' num2str(do_groups(group_ind))]);
    channels = groups(do_groups(group_ind)).chans;
    nspikes = Spikes_Per_Shank(do_groups(group_ind));
    
       
    % Specify and open the output file
    Combined_spike_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.spk.1'];
    Combinedfid = fopen(Combined_spike_file_name,'wb');
        
    % Calctulate number of spikes in each segment
    nspikesS = floor(nspikes/Su);
    spikesSrem = rem(nspikes,Su);
    if ~(nspikes == (nspikesS * Su + spikesSrem))
        disp('error in the spike division indices in read_spikes_from_file')
        return
    end
    count1 = Su * SpikeLen * 2; % Number of bytes for each segment
    Nels1 = count1 / 2; % Number of elements per segment
    count2 = spikesSrem * SpikeLen * 2; % Number of bytes for last segment
    Nels2 = count2/2; % Number of elements in last segment
    %N1 = nspikesS * count1 + count2; % So, total number of bytes
   
    
    spike_file_name = [];
    % open all files, get the IDs, and check number of elements
    for channel_ind = 1:length(channels)
        spike_file_name{channel_ind} = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_chan_' num2str(channels(channel_ind))  '_spk.1'];
        fid(channel_ind) = fopen(spike_file_name{channel_ind},'rb');
        fseek(fid, 0, 'eof');
        n = ftell(fid);
        fseek(fid, 0, 'bof'); % Get back to beginning of file
        exp_n = nspikes * SpikeLen * 2; % The 2 factor is because data is 16 bit (2 bytes)
        % Check
        if ~(exp_n == n)
            disp(['number of elements in file does not match expected number'])
            return
        end
    end
        
    % Read number of spikes in each of the segments 
    for i = 1:nspikesS
        TheseSpikes = zeros(length(channels),SpikeLen * Su);
        for channel_ind = 1:length(channels)
            [TheseSpikes(channel_ind,:) counted] = fread(fid(channel_ind),Nels1,'int16=>int16');
            nextpos = ftell(fid);
            if ~(counted == Nels1)
                disp(['some elements not succesfuly read'])
                return
            end
        end
        TheseSpikes = reshape(TheseSpikes,prod(size(TheseSpikes)),1);  
        fwrite(Combinedfid,TheseSpikes,'integer*2');
    end
    
    % Now you have to read the remainder spikes
    TheseSpikes = zeros(length(channels),SpikeLen * spikesSrem);
    for channel_ind = 1:length(channels)
            [TheseSpikes(channel_ind,:) counted] = fread(fid(channel_ind),Nels2,'int16=>int16');
            nextpos = ftell(fid);
            if ~(counted == Nels2)
                disp(['some elements not succesfuly read'])
                return
            end
    end
    TheseSpikes = reshape(TheseSpikes,prod(size(TheseSpikes)),1);
    fwrite(Combinedfid,TheseSpikes,'integer*2');
       
    % Check that output file has correct number of elements
    stat = fseek(Combinedfid, 0, 'eof');
    n = ftell(Combinedfid);
    exp_n = nspikes * SpikeLen * 2 * length(channels); % The 2 factor is because data is 16 bit (2 bytes)
    if ~(exp_n == n)
        disp(['number of elements in file does not match expected number'])
        return
    end
    
    fclose(Combinedfid)
    
     % Close all files
    for channel_ind = 1:length(channels)
        fclose(fid(channel_ind));
    end

end
      
 
return



