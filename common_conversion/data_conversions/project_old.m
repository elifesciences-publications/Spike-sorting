function OK = project(combined_datadir,groups,do_groups,blocks,Npcs);

OK = 0;
% introducing the next part which is projection on the PCs - here, files
% are combined across blocks for the sorting.

eval(['load ' combined_datadir 'pcdata']);
eval(['load ' combined_datadir 'Nspikes']);
eval(['load ' combined_datadir 'SpikeLen']);


for group_ind = 1:length(do_groups)
    Nchans  = length(groups(group_ind).chans);
    % Get the PCs for current channel group
    for chan = 1:Nchans
        thesePCs{chan} = pcs{group_ind}{chan}(:,1:Npcs);
    end
    disp([' projecting group ' num2str(group_ind)] )
    Allprojections = [];
    for block_ind = 1:length(blocks)
        disp([' block ' num2str(block_ind)] )
        % Load spike file
        spike_file_name = [datadir filesep 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.spk.' groups(do_groups(group_ind)).name];
        AllSpikes = read_spikes_from_file(Nspikes(group_ind,block_ind),SpikeLen,Nchans,spike_file_name);
        % Calculate projections
        projections = calc_projs(AllSpikes,SpikeLen,Nchans,thesePCs);
         
%         % Read the spike time indices from rpeviously written files
%         spiketime_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.res.' groups(do_groups(group_ind)).name];
%         fid = fopen(spiketime_file_name,'rt');
%         SpikeTimes = fscanf(fid,'%f');
%         fclose(fid);

%         % Two distinct files have to be made for klustaKwik and for
%         % Klusters, since the KlustaKwik should not contain time and the
%         % Klusters file should - or maybe I should use time for klustaKwik
%         % too ? This is something that has to be tested.
%         % (linux:/usr/local/klustakwik/KlustaKwik)
%         feature_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Klusters_Block-' num2str(blocks(block_ind)) '.fet.' groups(do_groups(group_ind)).name];
%         fid = fopen(feature_file_name,'w');
%         nfeats = Npcs * Nchans + 1;
%         fprintf(fid,'%2.0f\n',nfeats); % Number of faetures in file (excluding time)
%         for i = 1:Nspikes(group_ind,block_ind)
%             for j = 1:(nfeats-1)
%                 fprintf(fid,'%2.0f ',round(projections(i,j)));
%             end
%             fprintf(fid,'%2.0f\n', SpikeTimes(i));
%         end
%         fclose(fid);
        Allprojections = [Allprojections ; projections];
    end % over blocks for this group

    
    % We add 1 for the time parameter
    nfeats = size(Allprojections,2) + 1;
   
    
    % I now experiment with making a single cluster file for bothg klusters and klustakwik, and hence using
    % also the time information for clustering - this may prove to be a bad
    % choice, so I do not erase the option here.
%     % Create the combined feature file for KlustaKwik
%     feature_file_name = [combined_datadir 'combined.fet.' groups(do_groups(group_ind)).name];
%     % export PATH=/usr/local/klustakwik/KlustaKwik:$PATH
%     % (linux:/usr/local/klustakwik/KlustaKwik)
%     fid = fopen(feature_file_name,'w');
%     nfeats = Npcs * Nchans;
%     fprintf(fid,'%2.0f\n',nfeats); % Number of features in file (excluding time)
%     for i = 1:length(Allprojections)
%         for j = 1:(nfeats)
%             fprintf(fid,'%2.0f ',round(Allprojections(i,j)));
%         end
%         fprintf(fid,'\n');
%     end
%     fclose(fid);

    % Read the combined spike time file - which is required forthe Klusters
    % feature file
    spiketime_file_name = [combined_datadir 'combined.res.' groups(do_groups(group_ind)).name];
    fid = fopen(spiketime_file_name,'rt');
    AllSpikeTimes = fscanf(fid,'%f');
    fclose(fid);

    % Create the combined Klusters feature file - which also contains the
    % time
    feature_file_name = [combined_datadir 'combined.fet.' groups(do_groups(group_ind)).name];
    fid = fopen(feature_file_name,'w');
    %nfeats = Npcs * Nchans + 1;
    fprintf(fid,'%2.0f\n',nfeats); % Number of features in file (excluding time)
    for i = 1:length(Allprojections)
        for j = 1:(nfeats-1)
            fprintf(fid,'%2.0f ',round(Allprojections(i,j)));
        end
        fprintf(fid,'%2.0f\n', AllSpikeTimes(i));
    end
    fclose(fid);
end

OK = 1;
