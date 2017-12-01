function OK = project(combined_datadir,groups,do_groups,blocks,Npcs);

% See project-old for a version that cotained writing feature files
% without the time variable, and also processed block by block.

OK = 0;
% introducing the next part which is projection on the PCs - here, files
% are combined across blocks for the sorting.

eval(['load ' combined_datadir 'pcdata']);
eval(['load ' combined_datadir 'Nspikes']);
eval(['load ' combined_datadir 'SpikeLen']);
%eval(['load ' combined_datadir 'AllUniqueSourceChans' ]);
eval(['load ' combined_datadir 'SourceChans' ]); % to load  AllUniqueSourceChansMat

% These are the summed spikes over all blocks in the site
sNspikes = sum(Nspikes,2)

for group_ind = 1:length(do_groups)
      
    AllSources = [];
    %AllSources2 = [];
    NumChansDec = [];
    DetCode = [];
  
     % Combine the variables across blocks
    for j = 1:size(AllUniqueSourceChansMat,2) % Over all blocks        
            AllSources = [AllSources; AllUniqueSourceChansMat{group_ind,j}];
    end
    AllSources = int8(AllSources);
    NumChansDec = sum(AllSources,2)';
    
    % Get the number of detections and the code for detections (which is only a tag, it does not carry any information)
%     for i = 1:length(AllSources)
%         NumChansDec(i) = length(num2str(AllSources(i)));
%     end
       
%    [tmp1 tmp2 DetCode] = unique(AllSources);
    [tmp1 tmp2 DetCode] = unique(AllSources,'rows');
    DetCode = DetCode';
    
    Nchans  = length(groups(do_groups(group_ind)).chans);
    % Get the PCs for current channel group
    for chan = 1:Nchans
        thesePCs{chan} = pcs{do_groups(group_ind)}{chan}(:,1:Npcs);
    end
    disp([' projecting group ' num2str(do_groups(group_ind))] )

    spike_file_name = [combined_datadir 'combined' groups(do_groups(group_ind)).name '.spk.1'];
    % Note the method, when it is 2, the file is fragmented before
    % rearranging it.
    AllSpikes = read_spikes_from_file2(sNspikes(do_groups(group_ind)),SpikeLen,Nchans,spike_file_name);

    %AllSpikes = read_spikes_from_file(sNspikes(do_groups(group_ind)),SpikeLen,Nchans,spike_file_name,2);
    IgnoreNonDetected = 0;
    [projections extra_features] = calc_projs(AllSpikes,AllSources,SpikeLen,Nchans,thesePCs,IgnoreNonDetected);
    % projections = projections * 10000;  % This is because we subsequently have to round these values, and this will prevent truncation of all 
                                          % values smaller than 1                    
    
    % A more complete set of features, not for the automatic clustering
    % the extra features include: [max_peak',max_trough',max_energy',max_channel'];
    FullProjections = [projections extra_features  NumChansDec' DetCode'];
    % This works better for visulizing features, but also prevents clipping
    % into integer values that may be important for the Klustering quality.
    FullProjections = FullProjections * 1000;
    projections = projections * 1000;
    
    % It seems to me the normalization and clipping steps are unnecessary.
    %     % I normalize all projections to have an SD of 100000
    %     np = size(projections,2) + 3;
    %     sp = std(FullProjections(:,1:np)); % This is the set of variables that should and could be normalized
    %     for s = 1:np
    %           FullProjections(:,s) =  1000000 * FullProjections(:,s)/sp(s);
    %     end                                              
    %     % Clip outliers - values which are more than 100 SDs large
    %      for s = 1:np
    %           meanP = mean(FullProjections(:,s));
    %           toolarge = find(FullProjections(:,s)-meanP > 1000000);
    %           FullProjections(toolarge,s) =  1000000;
    %           toosmall = find(meanP - FullProjections(:,s) > 1000000);
    %           FullProjections(toosmall,s) =  -1000000;          
    %     end     
    % 
    %     
    
    % Read the combined spike time file
    spiketime_file_name = [combined_datadir 'combined' groups(do_groups(group_ind)).name  '.res.1'];
    fid = fopen(spiketime_file_name,'rt');
    AllSpikeTimes = fscanf(fid,'%f');
    fclose(fid);
           
    
     % The feature file to be used for clustering by KlustaKwik.
     % I only include the projections here without the spike times.
    feature_file_name = [combined_datadir 'combined'  groups(do_groups(group_ind)).name '.fet.1'];
    fid = fopen(feature_file_name,'w');
    nfeats = size(projections,2);
    fprintf(fid,'%2.0f\n',nfeats); % Number of features in file (excluding time)
    for i = 1:length(projections)
        for j = 1:(nfeats-1)
            fprintf(fid,'%2.0f ',round(projections(i,j)));
        end
         fprintf(fid,'%2.0f\n',round(projections(i,nfeats)));
         %fprintf(fid,'%2.0f\n', AllSpikeTimes(i));      
    end
    fclose(fid);
    
    
    % The feature file which contains the projections used for clustering
    % as well as the time and additional paratemeters which are mostly not
    % approparite for clustering (certainly not all are normally
    % distributed).
    % This file is to be used in Klusters.
    Klusters_feature_file_name = [combined_datadir 'klusters_combined'  groups(do_groups(group_ind)).name '.fet.1'];
    fid = fopen(Klusters_feature_file_name,'w');
    nfeats = size(FullProjections,2);
    fprintf(fid,'%2.0f\n',nfeats+1); % Number of features in file (excluding time)
    for i = 1:length(FullProjections)
        for j = 1:(nfeats)
            fprintf(fid,'%2.0f ',round(FullProjections(i,j)));
        end
        fprintf(fid,'%2.0f\n', AllSpikeTimes(i));
    end
    fclose(fid);
    
    
end

OK = 1;

return
