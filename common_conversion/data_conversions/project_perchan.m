function OK = project(combined_datadir,groups,do_groups,blocks,Npcs,PeakSamp,DO_TIME);
% See project-old for a version that cotained writing feature files
% without the time variable, and also processed block by block.
% NOTE that I played a lot with this function, and tried using various
% features as properties for clustering. After various attempts I still
% think the best approach is to have a short feature file for
% classification and a longer one (tagged with fet_plus) that in addition
% to the first two PCs also contains the aproximaiton error and then the
% positive and negative amplitudes  of each of the channels as well.
% So, for 8 channels there will be:
% 32 (PCs and positive and Negative) + 2 (Time and Error) = 34 features.

% Set this to 1 after classification is complete and you want to get the
% full feaure file. For some reason, it is not possible to make the full
% feature file and load only a subset to Klustakwik, so this has to be done
% in two steps.

if DO_TIME
    FULL_FEATURE_FILE = 1;
    TIME_IN_FEATURE_FILE = 1;
else
    FULL_FEATURE_FILE = 0;
    TIME_IN_FEATURE_FILE = 0;
end

OK = 0;

eval(['load ' combined_datadir 'SpikeLen']);

for group_ind = 1:length(do_groups)
           
    %clear Meds;
    clear Ups;
    clear Downs;
    clear ApproxErr
    
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'pcdata' groups(do_groups(group_ind)).name  ]);    
    eval(['load ' combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'Nspikes' groups(do_groups(group_ind)).name]);

    % These are the summed spikes over all blocks in the site
    sNspikes = sum(Nspikes);   
    
    chans = groups(do_groups(group_ind)).chans;
    Nchans = length(chans);
           
     % Indicates the number of expected spikes in this channel
    eval(['load ' combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_block_inds' ]);
    
    Projections = zeros(SpikeIndEnd(end),Nchans*Npcs);
                    
    for channel_ind = 1:Nchans
        this_chan = chans(channel_ind);

        % Get the PCs for current channel group
        % thesePCs = pcs{this_chan}(:,1:Npcs);
        thesePCs = pcs{channel_ind}(:,1:Npcs);
        disp([' projecting group ' num2str(do_groups(group_ind)) ' channel ' num2str(this_chan)] )

        % Get the spikes for this channel
        spike_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'group_' groups(do_groups(group_ind)).name '_chan_' num2str(this_chan)  '_spk.1'];
        fid = fopen(spike_file_name,'rb');
        Spikes = fread(fid,'integer*2');
        fclose(fid);
        % Reshape it into a matrix where each spike is one row
        Spikes = reshape(Spikes,SpikeLen,SpikeIndEnd(end))';

        % Get the projections
        Projections(:,[(channel_ind)*Npcs-Npcs+1:(channel_ind)*Npcs]) = Spikes*(thesePCs);
        
        if FULL_FEATURE_FILE
            Ups(:,channel_ind)       = max(Spikes')';
            Downs(:,channel_ind)     = min(Spikes')';
            %Calculate the reconstruction error
            Rspikes = Projections(:,[(channel_ind)*Npcs-Npcs+1:(channel_ind)*Npcs])*thesePCs';
            ApproxErr(:,channel_ind) = sum((Rspikes' - Spikes').^2)./sum((Spikes').^2);
        end
    end % of running over channels   
    
    if FULL_FEATURE_FILE
        MinErr = min(ApproxErr') ;
        BestFit =  100*(1-MinErr);
        Ups =  Ups * 100;
        Downs = Downs * 100;
    end
    
    
    % To prevent loss of resolution for viewing
    Projections = Projections * 100;  
                     
    % Read the combined spike time file
    spiketime_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name  '.res.1'];
    fid = fopen(spiketime_file_name,'rt');
    AllSpikeTimes = fscanf(fid,'%f');
    fclose(fid);
               
    
    
    if ~FULL_FEATURE_FILE
        % The feature file to be used for clustering by KlustaKwik.
        % I only include the projections here without the spike times
        % Values are multiplied so as not to lose resolution.
        feature_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'combined'  groups(do_groups(group_ind)).name '.fet.1'];
        fid = fopen(feature_file_name,'w');
        nfeats1 = size(Projections,2)

        if ~TIME_IN_FEATURE_FILE
            fprintf(fid,'%2.0f\n',nfeats1);
        else
            fprintf(fid,'%2.0f\n',nfeats1+1); % Number of features in file (including time)
        end

        for i = 1:length(Projections)
            for j = 1:(nfeats1)
                fprintf(fid,'%2.0f ',round(Projections(i,j)));
            end
            % This line required is we cannot make a full feature file for
            % this shank (because it will be too large)
            
            if ~TIME_IN_FEATURE_FILE
                fprintf(fid,'\n');
            else
                fprintf(fid,'%2.0f\n ', AllSpikeTimes(i));
            end
            
        end
        fclose(fid);
    else
        feature_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'combined'  groups(do_groups(group_ind)).name '.fet.1'];
        fid = fopen(feature_file_name,'w');
        nfeats1 = size(Projections,2)
        nfeats2 =  size(Ups,2);
        nfeats3 =  size(Downs,2);
        nfeats4 = 1; % For the best fit
        fprintf(fid,'%2.0f\n',nfeats1+nfeats2+nfeats3+nfeats4+1); % Number of features in file (including time)
        for i = 1:length(Projections)
            for j = 1:(nfeats1)
                fprintf(fid,'%2.0f ',round(Projections(i,j)));
            end
            for j = 1:(nfeats2)
                fprintf(fid,'%2.0f ',round(Ups(i,j)));
                fprintf(fid,'%2.0f ',round(Downs(i,j)));
            end
            fprintf(fid,'%2.0f ',round(BestFit(i)));
            fprintf(fid,'%2.0f\n ', AllSpikeTimes(i));
        end
        fclose(fid);
    end

end

OK = 1;

return

        
%         
%         ki = 1;
%         DEBUG_MODE = 1;
%         GO_ON = 1;
%         if DEBUG_MODE
%             while GO_ON
%                 close
%                 figure
%                 for dbi = 1:16
%                     subplot(4,4,dbi);
%                     plot(Spikes(ki,:))
%                     info = ['Err: ' num2str(err(ki)) ' Ups: ' num2str(Ups(ki,channel_ind)) ' Down: ' num2str(Downs(ki,channel_ind))];
%                     title(info)
%                     hold on
%                     scalefact = max(Spikes(ki,:))/max(max(thesePCs));
%                     plot(scalefact*thesePCs(:,1),'r')
%                     plot(scalefact*thesePCs(:,2),'g')
%                     ki = ki + 1;
%                 end
%                 inputchar = input('ciontinue','s');
%                 if strcmp('q',inputchar)
%                     break
%                 end
%             end
%         end

        %extrafeatures = [max_peak',max_trough',max_energy',max_channel'];        
        %%%%%%%%%%%%



