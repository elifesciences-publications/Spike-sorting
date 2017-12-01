function OK = show_pcs(combined_datadir,groups,do_groups)

% Load the Pc files and show the results - this funciton is still
% unfinished

eval(['save ' combined_datadir 'pcdata pcs projs vars']);
for group_ind = 1:length(do_groups)

    %     Nchans = length(groups{group_ind});
    %     spike_file_name = [datadir filesep 'Block-' num2str(blocks(PC_block)) filesep 'Block-' num2str(blocks(PC_block)) '.spk.' groups(do_groups(group_ind)).name];
    %     AllSpikes = read_spikes_from_file(Nspikes(group_ind,PC_block),SpikeLen,Nchans,spike_file_name);
    %
    %     % We have to calculate PCs for each of the channels
    %     for j = 1:Nchans
    %         TheseSpikes = double(AllSpikes(:,inds2(j,:)));
    %         [thesepcs theseprojs thesevars] = princomp((TheseSpikes));
    %         pcs{group_ind}{j}   = thesepcs;
    %         projs{group_ind}{j} = theseprojs;
    %         vars{group_ind}{j}  = thesevars./sum(thesevars);
    %     end

    figure
    for j = 1:Nchans
        subplot(2,2,j)
        plot(pcs{group_ind}{j}(:,1:3));
        title(['chan ' num2str(j)   ' group ' groups(do_groups(group_ind)).name ' ' num2str(cumsum(vars{group_ind}{j}(1:3))')])
        legend('1','2','3')
    end

end
eval(['save ' combined_datadir 'pcdata pcs projs vars']);
