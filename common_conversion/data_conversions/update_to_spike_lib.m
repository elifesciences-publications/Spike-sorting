function update_spike_lib(datadir,combined_datadir,groups,do_groups,SpikeLen);
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

% Generate name for output file
fileseps = findstr(filesep,datadir);
thisdate = datadir([fileseps(end-2)+1:fileseps(end-2)+7]);
fileseps = findstr(filesep,combined_datadir);
thissite = combined_datadir([fileseps(end-1)+1:fileseps(end-1)+5]);

spikelib_file_name = [combined_datadir thisdate '_' thissite '_spikelib.mat'];


TO_PLOT = 0;
ci = 0; % COunter over all classes
for group_ind = 1:length(do_groups)

    
    nchans = length(groups(group_ind).chans);

    disp(['Generating spike shape lib for group' num2str(do_groups(group_ind))])

    % load the cluster file
    cluster_file_name = [combined_datadir  'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.clu.1'];
    fid = fopen(cluster_file_name,'r');
    Classification = fscanf(fid,'%f');
    Nclasses = Classification(1);
    Classification = Classification(2:end);
    %    Classification1 = Classification1(2:end);
    fclose(fid);
    Nspikes = length(Classification);

    % Load spike file name, this is the combined file
    spike_file_name = [combined_datadir 'group' groups(do_groups(group_ind)).name filesep 'combined' groups(do_groups(group_ind)).name '.spk.1'];
    fid = fopen(spike_file_name,'rb');
    [Spikes count] = fread(fid,'int16=>int16');

    % Check that the read number of samples makes sense
    if ~count == SpikeLen * nchans * Nspikes
        disp('unexpected number of samples in update_to_spike_lib')
        return
    end

    % A spike length across all channels
    OneSpikeLen = SpikeLen * nchans;
    
    % Each row one spike - multiple channels
    Spikes = reshape(Spikes,OneSpikeLen,Nspikes)';

    % Plot the spike shapes for each of the classes
    SpikeClasses = unique(Classification);

    for sci = 1:length(SpikeClasses)
        
        ci = ci + 1;
%         SpikeClasses(sci)  %%temp to see where this is crapping out
        
        theseinds = find(Classification == SpikeClasses(sci));
        N = length(theseinds);        
        
        % All the reshaping is tough with a large matrices, so I reduce
        % it to 8000 which seems to be fine
             
        if length(theseinds) > 8000
            tmp = unidrnd(length(theseinds),1,8000);
            theseinds = theseinds(tmp);
        end


        if length(theseinds) > 100
            randinds = unidrnd(length(theseinds),1,100);
        else
            randinds = 1:length(theseinds);
        end

        randinds = theseinds(randinds);

        
        clear randspikes;
        for rii = 1:length(randinds)
            thisspike = Spikes(randinds(rii),:);
            randspikes{rii} = reshape(thisspike,nchans,SpikeLen);
        end        
        
        thesespikes = Spikes(theseinds,:);
        thesespikes = double(thesespikes);
        tmpmean   = mean(thesespikes);
        tmpstd    = std(thesespikes);
                        

        if N>1             %%JFB edit to handle the case of a single spike...which I had happen
            Class(ci).mean = reshape(tmpmean,nchans,SpikeLen);
            Class(ci).std  = reshape(tmpstd,nchans,SpikeLen);
            Class(ci).N    = N;
            Class(ci).name = SpikeClasses(sci);
            Class(ci).sample =  randspikes;
        else
            Class(ci).mean = NaN;
            Class(ci).std  = NaN;
            Class(ci).N    = N;
            Class(ci).name = SpikeClasses(sci);
            Class(ci).sample =  NaN;
        end
        
        % Plot the class means and STD
        if TO_PLOT
            figure
            minYlim = inf;
            maxYlim = -inf;
            for i = 1:nchans
                ah(i) = subplot(nchans,1,i);
                ph = plot(Class(ci).mean(i,:),'k');
                set(ph,'linewidth',2);
                hold on
                plot(Class(ci).mean(i,:)+Class(ci).std(i,:),'g');
                plot(Class(ci).mean(i,:)-Class(ci).std(i,:),'g');
                set(gca,'xlim',[1 SpikeLen]);
                thisylim = get(gca,'ylim');
                minYlim = min(thisylim(1),minYlim);
                maxYlim = max(thisylim(2),maxYlim);
                
                if i ==1
                    title(['Spike ' num2str(SpikeClasses(sci))]);
                end
            end
            set(ah,'ylim',[minYlim, maxYlim],'ytick',[]);
            set(gcf,'name',['Spike ' num2str(SpikeClasses(sci))]);
        end
    end
     
    
    clear Spikes

    
end % over groups
eval(['save ' spikelib_file_name  ' Class']);

return