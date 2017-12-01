function OK = calculate_pcs(datadir,combined_datadir,groups,do_groups,PC_block,blocks,PeakSamp)
% calcualte PCs from the extracted spikes in the PC_block
% This implies that the PCs are based upon the results in one block only -
% this makes sense computationally and also because the first block should
% not contain any artifacts
%
%
%
% Played with several options on the 29/12/06 - now only calcualte PCs
% based on spikes detcted in that specific channel. Also, I use all spikes
% form all blocks, but I do try to restrict artifcats,by setting a
% threshold. I also tried calculating PCs based on straightened spike (i.e.
% all peaks made positive), but gave this up as it did not yield nicer PCs.

profile on

OK = 0;

% Threshold for maximum allowed spike magnitude, relative to largest peak
% in Pc block which does not include stimulation
aT = 5;         % Artifact threshold - anything that is this times as large or more than the maximum value in the PC block is not regarded
                % as a spike and will not be used ofr calcualting PCs

% Load number of spikes and spike length information
eval(['load ' combined_datadir 'Nspikes']);
eval(['load ' combined_datadir 'SpikeLen']);
eval(['load ' combined_datadir 'SourceChans' ]); % to load  AllUniqueSourceChansMat   

% Collect all Spikes
for group_ind = 1:length(do_groups)
    pack
    AllSources{group_ind} = [];
    AllSpikes{group_ind}  = [];
    Nchans = length(groups(do_groups(group_ind)).chans);
    for block_ind = 1:length(blocks)
        disp([' Calculating PCs for group ' num2str(do_groups(group_ind)) ' block ' num2str(block_ind)])
        spike_file_name = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '.spk.' groups(do_groups(group_ind)).name];
       % tic
        Spikes = read_spikes_from_file2(Nspikes(do_groups(group_ind),blocks(block_ind)),SpikeLen,Nchans,spike_file_name);
       % toc
       % tic
       % Spikes1 = read_spikes_from_file(Nspikes(do_groups(group_ind),blocks(block_ind)),SpikeLen,Nchans,spike_file_name,2);
       % toc
        
        Sources = AllUniqueSourceChansMat{group_ind,block_ind};                
        
        if blocks(block_ind) == PC_block
            PC_block_inds{group_ind} = [size(AllSpikes{group_ind},1)+1 size(Spikes,1)];
        end
        
        AllSpikes{group_ind}  = [AllSpikes{group_ind}; Spikes];
        AllSources{group_ind} = [AllSources{group_ind}; Sources];
    end
end
clear Spikes;   % We will use the same variable name for a different variable
        
% make sets of straigtened spikes and only real spikes, this workds per channel per group
for group_ind = 1:length(do_groups)
      
    % Calculate PCs for each channel
    Nchans = length(groups(do_groups(group_ind)).chans);
    for j = 1:Nchans
        inds = (j-1)*SpikeLen + [1:SpikeLen];
        disp(['  channel ' num2str(j)])
        % Only spikes detected by this channel
        TheseSpikes = AllSpikes{group_ind}(:,inds);
        TheseRealSpikes = AllSpikes{group_ind}(find(AllSources{group_ind}(:,j)),inds);   
        Spikes{group_ind,j} = TheseSpikes;
        RealSpikes{group_ind,j} = TheseRealSpikes;
    end
end
            
% Get the maximum peaks for the PC block - to exlcude noise in the
% subsequent stage
for group_ind = 1:length(do_groups)
    Nchans = length(groups(do_groups(group_ind)).chans);
    for j = 1:Nchans
        inds = [PC_block_inds{group_ind}(1):PC_block_inds{group_ind}(2)];        
        Max_PC_block_Peak(group_ind,j) = max(abs(Spikes{group_ind,j}(inds,PeakSamp)));       
    end
end
clear Spikes
        
% make sets of straigtened spikes and only real spikes, this workds per channel per group
for group_ind = 1:length(do_groups)
    % Calculate PCs for each channel
    Nchans = length(groups(do_groups(group_ind)).chans);
    for j = 1:Nchans   
        RealPeaks = RealSpikes{group_ind,j}(:,PeakSamp);
        goodones =  abs(RealPeaks) <= aT*Max_PC_block_Peak(group_ind,j);
        GoodRealSpikes{group_ind,j} = RealSpikes{group_ind,j}(goodones,:);            
    end
end

%This takes a lot of memory - 
% for group_ind = 1:length(do_groups)
%     for j = 1:Nchans
%         figure        
%         plot(RealSpikes{group_ind,j}','k')
%         hold on
%         plot(GoodRealSpikes{group_ind,j}','r')
%     end
% end
            
% This takes a lot of memory - 
% for group_ind = 1:length(do_groups)
%     for j = 1:Nchans
%         figure        
%         plot(Spikes{group_ind,j}','k')
%         hold on
%         tmp = Spikes{group_ind,j};
%         tmp2 = tmp(PC_block_inds{group_ind}(1):PC_block_inds{group_ind}(2),:);
%         plot(tmp2','r')
%     end
% end
            


% Calculate the PCs
for group_ind = 1:length(do_groups)
    
    pack
    
    Nchans = length(groups(do_groups(group_ind)).chans);
    for j = 1:Nchans
        [thesepcs theseprojs thesevars] = princomp((double(GoodRealSpikes{group_ind,j})));
        pcs{do_groups(group_ind)}{j}    = thesepcs;
        projs{do_groups(group_ind)}{j}  = theseprojs;
        vars{do_groups(group_ind)}{j}   = thesevars./sum(thesevars);
    end
end


% Plot the result
Npcs = 2;
for group_ind = 1:length(do_groups)
    figure
    Nchans = length(groups(do_groups(group_ind)).chans);
    for chan = 1:Nchans
        subplot(2,4,chan)
        plot(pcs{do_groups(group_ind)}{chan}(:,1:Npcs));
        title(['group: ' num2str(group_ind) '  chan: ' num2str(chan) ' real spikes'])
    end
end
for group_ind = 1:length(do_groups)
    figure
    Nchans = length(groups(do_groups(group_ind)).chans);
    for chan = 1:Nchans
        subplot(2,4,chan)
        bar(vars{do_groups(group_ind)}{chan}(1:3)./sum(vars{do_groups(group_ind)}{chan}));
        set(gca,'xlim',[0 4],'ytick',[0:0.1:1])
        title(['group: ' num2str(group_ind) '  chan: ' num2str(chan) ' real spikes'])
    end
end

eval(['save ' combined_datadir 'pcdata pcs vars']);
%eval(['save ' combined_datadir 'pcdata pcs projs vars']);

OK = 1;

profile off
profile report

return