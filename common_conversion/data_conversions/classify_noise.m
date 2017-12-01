function classify_noise(datadir,combined_datadir,groups,do_groups,SpikeLen);
% This program reads the classified data, considers all "noise" spikes, and
% assigns them classes according to the channels in which they were
% detected.
% noise channels will be given class designations strating with 101, and
% continuing until 100 + number of channels.
% 
% The original cluster file will be renamed as orig_....
% The new file will be renamed as noise_classified
% and then copied into the original file name, so that this will be loaded
% into Klusters or Neuroscope.

%eval(['load ' combined_datadir 'Nspikes']);
%eval(['load ' combined_datadir 'SourceChans' ]); % to load  AllUniqueSourceChansMat
%Spikes_Per_Shank = sum(Nspikes,2);
%SumNSpikes = sum(Nspikes');

for group_ind = 1:length(do_groups)
    
    
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'Nspikes' groups(do_groups(group_ind)).name]);
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'SourceChans' groups(do_groups(group_ind)).name ' UniqueSourceChansMat' ]);
    
    Spikes_Per_Shank = sum(Nspikes);
    %SumNSpikes = sum(Nspikes');
    TheseNSpikes = sum(Nspikes');
    
    
    meanSpike = [];
    stdSpike = [];

    
    %TheseNSpikes = SumNSpikes(do_groups(group_ind));
    
    AllSources = [];
    
    disp(['Classifying noise in group ' num2str(do_groups(group_ind))])
   
               
    % load the cluster file
    cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.clu.1'];
    fid = fopen(cluster_file_name,'r');
    Classification1 = fscanf(fid,'%f');    
    Nclasses = Classification1(1);
    Classification1 = Classification1(2:end);
    fclose(fid);
    
    orig_cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.orig_clu.1'];
    
    eval(['! cp ' cluster_file_name ' ' orig_cluster_file_name ]);
    
       
     % Get the source channel for each event
    for j = 1:length(UniqueSourceChansMat) % Over all blocks        
            AllSources = [AllSources; UniqueSourceChansMat{j}];
    end    
    AllSources = int8(AllSources);
    nchans = size(AllSources,2);
    % fine the channels on which the spikes were detected   
    [tmp1 tmp2 DetCode] = unique(fliplr(AllSources),'rows');
    DetCode = DetCode';
    
    if ~TheseNSpikes == length(DetCode) | ~TheseNSpikes == length(Classification1)
        disp(['spike number mismatch in classify_noise group' num2str(do_groups(group_ind))])
        return
    end
    
    % Now make a histogram, for each of the spikes, for each class, show
    % the source channels
    %Classes = unique(Classification1);
    %figure
    %set(gcf,'name',['Source channels for group ' num2str(do_groups(group_ind))])
    %for i =1:length(Classes)
    %    these = find(Classification1 == Classes(i));
    %    theseSources = DetCode(these);
    %    subplot(5,6,i)
    %    hist(theseSources,[1:nchans]);
    %    set(gca,'xlim',[0 nchans+1])
    %    title(['Class ' num2str(Classes(i)) ])
    %end
    
    NoiseInds       = find(Classification1 == 1);
    NoiseSource     = DetCode(NoiseInds);
    % This offset will enable distinction between original and noise
    % originated classes
    NoiseSource = do_groups(group_ind)  * 1000 + NoiseSource * 100;
    Classification2 = Classification1;
    Classification2(NoiseInds) = NoiseSource;
            
     
    %% read the Spike File Name   
    channels = groups(do_groups(group_ind)).chans;    
    %nspikes = Spikes_Per_Shank;
    exp_count = SpikeLen * Spikes_Per_Shank;

    % Get all unique classes except the artifacts - and also not including
    % the artifcat and noise classes
    Classes = setdiff(unique(Classification1),[0 1]);
    % And also not including all the classes which have been previously
    % assigned into noise (i.e. that were results of splitting the )
    Noise_Classes = [];
    for i = 1:length(channels)
        Noise_Classes = [Noise_Classes  do_groups(group_ind)  * 1000 + i * 100];
    end
    Classes = setdiff(Classes,Noise_Classes)
    
    
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
    if exist('SpikeE') % Might be empty if all spikes are noise or artifact spikes
        [maxamp maxind] = max(SpikeE);
        Classification3 = Classification2;
        for i = 1:length(channels)
            these = find(maxind == i);
            these_classes = Classes(these);
            these_amps  = maxamp(these);
            [tmp these_ord ] = sort(these_amps);
            %these = these(these_ord);
            these_classes = these_classes(these_ord);
            for j = 1:length(these_ord)
                these_inds = find(Classification3 == these_classes(j));
                Classification3(these_inds) =  do_groups(group_ind)  * 1000 + i * 100 + j;
            end
        end
    else
        Classification3 = Classification2;
    end
    
    % For debugging - to see that each classes was transformed into another
    % name
    orig_classes = unique(Classification1);
    disp(['the transformation for group ' num2str(do_groups(group_ind)) ' is: '])
    for i = 1:length(orig_classes)
        inds = find(Classification1 ==orig_classes(i));
        u = unique(Classification3(inds));
        disp([num2str(orig_classes(i)) ' -> ' num2str(u')])
    end
        
    % Now use the channel amps to rename the spikes
        
 
%     figure
%     for i = 1:length(Classes)
%         for channel_ind = 1:length(channels)
%             subplot(length(channels),length(Classes),[(channel_ind-1)*length(channels) + i])
%             plot(meanSpike{channel_ind,i});
%         end
%     end
    
    %Create combined spike time file
    new_cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.noiseclassified_clu.1'];
    fid = fopen(new_cluster_file_name,'w');
    Classes3 = unique(Classification3);
    Nclasses3 = length(Classes3);
    fprintf(fid,'%2.0f \n',Nclasses3);
    fprintf(fid,'%2.0f \n',Classification3);
    fclose(fid);    
    
    % Now make the revised cluster file into the original cluster file - to
    % correspond with the conventions of Klusters
    eval(['! cp ' new_cluster_file_name ' ' cluster_file_name ]);
    
end % over groups
%eval(['save ' combined_datadir 'SpikeLen SpikeLen']);

return