function OK =  check_data_completeness(datadir,combined_datadir,groups,do_groups,blocks);
% Check that all elec dta from the same block has the same number of
% sample. If not, it is probably because a data saving error in TDT. The
% solution should be to zero pad the missing parts. The user is notified
% and must confoirm before continuing.

OK = 1;

% make a list of all channels:
all_chans = [];
for group_ind = 1:length(do_groups)
    channels = groups(do_groups(group_ind)).chans;
    all_chans = [all_chans channels];
end

for block_ind = 1:length(blocks)
    nsamples = zeros(length(all_chans),1);
    disp(['checking for data in block ' num2str(blocks(block_ind))]);
    for channel_ind = 1:length(all_chans)
        relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_Elec_chan_' num2str(all_chans(channel_ind)) '.mat'];
        varname = ['Elec_' num2str(all_chans(channel_ind))];
        eval(['load ' relfile ' ' varname ';' ]);
        eval(['data =' varname ';'])
        nsamples(channel_ind) = length(data);
        eval(['clear '  varname ';'])
        clear data;
    end
    un_lengths = unique(nsamples);
    disp(blocks(block_ind));
    for i = 1:length(nsamples)
        disp([all_chans(i) nsamples(i)]);
    end
    
    if length(un_lengths) > 1
        OK = 0;
        eh = warndlg(['problem in block ' num2str(blocks(block_ind)) ],'pre processing','modal');
        % Now there is a need to fix it
        maxN = max(nsamples);
        for channel_ind = 1:length(all_chans)
            relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_Elec_chan_' num2str(all_chans(channel_ind)) '.mat'];
            varname = ['Elec_' num2str(all_chans(channel_ind))];
            eval(['load ' relfile ' ' varname ';' ]);
            eval(['data =' varname ';']);
            nsamples = length(data);
            if nsamples ~= maxN
                orig_varname = ['Elec_' num2str(all_chans(channel_ind)) '_old'];
                eval([orig_varname  ' = data;']);
                data = [data zeros(1,maxN-nsamples)];
                eval([varname ' = data;']);
                eval(['save ' relfile ' ' varname ' -append']);
                eval(['save ' relfile ' ' orig_varname ' -append']);
                eval(['clear '  varname ' ' orig_varname ';'])
                clear data;
            end
        end
    end
end

    return