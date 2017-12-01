function reorder_by_amplitude(datadir,combined_datadir,groups,do_groups,SpikeLen);
% This function is based on the classify_noise.m function, except that it
% only reorders spikes, no assigment of noise spikes based on channels, and
% also no renaming to more meaningful names. The only purpose of this
% function is to reorder the spike classes in a way that will make it
% easier to identify matches.

%eval(['load ' combined_datadir 'Nspikes']);
%eval(['load ' combined_datadir 'SourceChans' ]); % to load  AllUniqueSourceChansMat

%Spikes_Per_Shank = sum(Nspikes,2);

%SumNSpikes = sum(Nspikes');

for group_ind = 1:length(do_groups)
    
    
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'Nspikes' groups(do_groups(group_ind)).name]);
    %eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'SourceChans' groups(do_groups(group_ind)).name ' UniqueSourceChansMat' ]);
    
    Spikes_Per_Shank = sum(Nspikes,2);
    %SumNSpikes = sum(Nspikes');
    %TheseNSpikes = sum(Nspikes');
    
    clear SpikeE;
    meanSpike = [];
    stdSpike = [];
    
    %TheseNSpikes = SumNSpikes(do_groups(group_ind));
    
    AllSources = [];
    
    disp(['Renaming clusters in group ' num2str(do_groups(group_ind))])
   
               
    % load the cluster file
    cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.clu.1'];
    fid = fopen(cluster_file_name,'r');
    Classification1 = fscanf(fid,'%f');    
    Nclasses = Classification1(1);
    Classification1 = Classification1(2:end);
    fclose(fid);
    
    orig_cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.orig_clu.1'];
    
    eval(['! cp ' cluster_file_name ' ' orig_cluster_file_name ]);
                   
                                      
    %% read the Spike File Name   
    channels = groups(do_groups(group_ind)).chans;    
    nspikes = Spikes_Per_Shank;%(do_groups(group_ind));
    exp_count = SpikeLen * Spikes_Per_Shank; %(do_groups(group_ind));

    % Get all unique classes except the artifacts and noise
    Classes = setdiff(unique(Classification1),[0 1]);
    
    % open all files, get the IDs, and check number of elements
    for channel_ind = 1:length(channels)
        spike_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_chan_' num2str(channels(channel_ind))  '_spk.1'];
        fid = fopen(spike_file_name,'rb');
        [Spikes count] = fread(fid,'int16=>int16');                
        Spikes = reshape(Spikes,SpikeLen,count/SpikeLen)';
      
        % Get the energy of each of the spikes in each channel
        for i = 1:length(Classes)
            these = find(Classification1 == Classes(i));
            %meanSpike{channel_ind,i} = mean(double(Spikes(these,:)));
            %stdSpike{channel_ind,i}  = std(double(Spikes(these,:)));   
            meanSpike = mean(double(Spikes(these,:)));
            SpikeE(channel_ind,i)  = sqrt(sum(meanSpike.*meanSpike));
        end               
    end

    % For each classes, find the maximum channel and the size on that
    % channel (this makes sense if impedances are similar across channels)
    [maxamp maxind] = max(SpikeE);
        
    Classification2 = Classification1;
    k = 2; % We strat with cluster 2, since 0 and 1 are reserved for the noise and artifcats
    for i = 1:length(channels)
        these = find(maxind == i);
        these_classes = Classes(these);
        these_amps  = maxamp(these);
        [tmp these_ord ] = sort(these_amps);
        %these = these(these_ord);
        these_classes = these_classes(these_ord);        
        for j = 1:length(these_ord)
            these_inds = find(Classification1 == these_classes(j));
            Classification2(these_inds) =  k;
            k = k + 1;
        end
    end
        
   %
    
    % For debugging - to see that each classes was transformed into another
    % name
    orig_classes = unique(Classification1);
    disp(['the transformation for group ' num2str(do_groups(group_ind)) ' is: '])
    for i = 1:length(orig_classes)
        inds = find(Classification1 ==orig_classes(i));
        u = unique(Classification2(inds));
        disp([num2str(orig_classes(i)) ' -> ' num2str(u')])
    end
        

          
    %Create combined spike time file
    new_cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.noiseclassified_clu.1'];
    fid = fopen(new_cluster_file_name,'w');
    Classes2 = unique(Classification2);
    Nclasses2 = length(Classes2);
    fprintf(fid,'%2.0f \n',Nclasses2);
    fprintf(fid,'%2.0f \n',Classification2);
    fclose(fid);    
    
    % Now make the revised cluster file into the original cluster file - to
    % correspond with the conventions of Klusters
    eval(['! cp ' new_cluster_file_name ' ' cluster_file_name ]);
    
end % over groups
%eval(['save ' combined_datadir 'SpikeLen SpikeLen']);

return