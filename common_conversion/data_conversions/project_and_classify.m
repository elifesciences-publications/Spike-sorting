function OK = project_and_classify(combined_datadir,groups,do_groups,blocks,Npcs);
% An experimentla version that starts a clasification based on the identity
% of the channels with the first and second largest peaks.

OK = 0;
% introducing the next part which is projection on the PCs - here, files
% are combined across blocks for the sorting.

eval(['load ' combined_datadir 'pcdata']);
eval(['load ' combined_datadir 'Nspikes']);
eval(['load ' combined_datadir 'SpikeLen']);
eval(['load ' combined_datadir 'SourceChans' ]); % to load  AllUniqueSourceChansMat

% These are the summed spikes over all blocks in the site
sNspikes = sum(Nspikes,2)

for group_ind = 1:length(do_groups)

    chans = groups(do_groups(group_ind)).chans;
    Nchans = length(chans);
    
     % Indicates the number of expected spikes in this channel
    eval(['load ' combined_datadir 'group_' groups(do_groups(group_ind)).name '_block_inds' ]);
    
    Projections = zeros(SpikeIndEnd(end),Nchans);
                    
    for channel_ind = 1:Nchans
        this_chan = chans(channel_ind);

        % Get the PCs for current channel group
        thesePCs = pcs{this_chan}(:,1:Npcs);
        disp([' projecting group ' num2str(do_groups(group_ind)) ' channel ' num2str(this_chan)] )

        % Get the spikes for this channel
        spike_file_name = [combined_datadir 'group_' groups(do_groups(group_ind)).name '_chan_' num2str(this_chan)  '_spk.1'];
        fid = fopen(spike_file_name,'rb');
        Spikes = fread(fid,'integer*2');
        fclose(fid);
        % Reshape it into a matrx where each spike is one row
        Spikes = reshape(Spikes,SpikeLen,SpikeIndEnd(end))';

        % Get the projections
        Projections(:,[(channel_ind)*2-1,(channel_ind)*2]) = Spikes*(thesePCs);

        %Projections(:,channel_ind) = 
        Mins = min(Spikes');
        Maxs = max(Spikes');
        Amps(:,channel_ind) = Maxs - Mins;
    end % of running over channels
          
    [tmp sortAMPinds ] = sort(Amps,2);
    firstsecondpeaks = [sortAMPinds(:,Nchans) sortAMPinds(:,Nchans-1,:)];
    % These are the new clusters
    [uniquePeakords I sortAMPcodes] = unique(firstsecondpeaks,'rows');
    
    Projections = Projections * 1000;
       
    % Read the combined spike time file
    spiketime_file_name = [combined_datadir 'combined' groups(do_groups(group_ind)).name  '.res.1'];
    fid = fopen(spiketime_file_name,'rt');
    AllSpikeTimes = fscanf(fid,'%f');
    fclose(fid);
      
    
    % Cluster file based on the sortcodes  - which is the first and second
    % largest amplitudes
    cluster_file_name = [combined_datadir 'combined' groups(do_groups(group_ind)).name '.clu.1'];
    fid = fopen(cluster_file_name,'w');
    fprintf(fid,'%2.0f \n',length(uniquePeakords));
    fprintf(fid,'%2.0f \n',sortAMPcodes);
    %for i = 1:length(sortAMPcodes)
    %    fprintf(fid,'%2.0f \n',1);
    %end
    fclose(fid);    
    
    
    % Feature file tobe used for clustering, containing amplitudes only 
    feature_file_name = [combined_datadir 'klustakwik_combined'  groups(do_groups(group_ind)).name '.fet.1'];
    fid = fopen(feature_file_name,'w');
    nfeats = size(Amps,2);
    fprintf(fid,'%2.0f\n',nfeats); % Number of features in file (excluding time)
    for i = 1:length(Amps)
        for j = 1:(nfeats-1)
            fprintf(fid,'%2.0f ',round(Amps(i,j)));
        end
         fprintf(fid,'%2.0f\n',round(Amps(i,nfeats)));
         %fprintf(fid,'%2.0f\n', AllSpikeTimes(i));      
    end
    fclose(fid);
    
    
    % Feature file for klusters - i.e. for viewing, containing the PC
    % projections amd time
    Klusters_feature_file_name = [combined_datadir 'klusters_combined'  groups(do_groups(group_ind)).name '.fet.1'];
    fid = fopen(Klusters_feature_file_name,'w');
    nfeats = size(Projections,2);
    fprintf(fid,'%2.0f\n',nfeats+1); % Number of features in file (excluding time)
    for i = 1:length(Projections)
        for j = 1:(nfeats)
            fprintf(fid,'%2.0f ',round(Projections(i,j)));
        end
        fprintf(fid,'%2.0f\n', AllSpikeTimes(i));
    end
    fclose(fid);
    
    
end

OK = 1;

return
