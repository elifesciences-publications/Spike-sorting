function get_contin_trial_epochs_part2(expdate,session,SignalType);
% Get segments of the LFP or the nVAR signals
%
% The idea of this function ("part2") is to load the segments generated in
% part1 and generate the data cuts

switch SignalType
    case    'nvar'
        DO_LFP = 0;
        DO_nVAR = 1;
    case 'lfp'
        DO_LFP = 1;
        DO_nVAR = 0;
end

global GLBL_WHICH_PC;
DELETE_STIMULATION_SPIKES = 1;
switch GLBL_WHICH_PC
    case 'LAPTOP'
        basepath = 'C:\DATA\';
    otherwise
        basepath = 'c:\';
end


% Construct the session string
sstring = ['(' expdate '-s' num2str(session) ')'];

% 
% block_dirs = dir(datadir)
% k = 1;
% for i = 1:length(block_dirs)
%     if findstr('Block',block_dirs(i).name)
%         block_Dirs{k} = block_dirs(i).name;
%         k = k + 1;
%     end
% end


if DO_LFP
    LFP_infname  = [basepath 'CutData\CUTINFO_cutdata_TrialEpochs_' sstring '_LFP'];
    load(LFP_infname)
    LFP_outfname  = [basepath 'CutData\cutdata_TrialEpochs_' sstring '_LFP'];
end
if DO_nVAR
    nVAR_infname = [basepath 'CutData\CUTINFO_cutdata_TrialEpochs_' sstring '_nVAR'];
    load(nVAR_infname)    
    nVAR_outfname = [basepath 'CutData\cutdata_TrialEpochs_' sstring '_nVAR'];    
end


datadir = [basepath 'continuous_data' filesep expdate filesep 'mat' filesep];



if DO_LFP
    LFP_Sb = round(Tb * LFP_SR)
    LFP_Sa = round(Ta * LFP_SR)

    for bi = 1:length(blocks)
        LFP_files = dir([datadir 'Block-' num2str(blocks(bi)) filesep '*LFPs*']);

        for elci = 1:length(LFP_files)
            [tmp tmp_name ] = fileparts(LFP_files(elci).name);
            LFP_names{elci} = tmp_name;
            last_us = max(findstr('_',tmp_name));
            chan_nums(elci) = str2num(tmp_name(last_us+1:end));
        end
        [chans sortind] = sort(chan_nums);
        LFP_names = LFP_names(sortind);

        for ei = 1:length(LFP_names)
            varname = ['LFPs_' num2str(chans(ei))];
            D = load([datadir 'Block-' num2str(blocks(bi)) filesep LFP_names{ei} ],varname);
            eval(['D = D.' varname ';']);

            % Make all stimulation samples to zero
            rel_inds = find(S1_b == blocks(bi));
            rel_S1_b = S1_b(rel_inds);
            rel_S1_S = floor(S1_t(rel_inds) * LFP_SR - STIM_MARGIN*LFP_SR) ;
            rel_S1off_S = ceil(S1off_t(rel_inds) * LFP_SR);
            for rIi = 1:length(rel_inds)
                D([rel_S1_S(rIi):rel_S1off_S(rIi)]) = inf;
            end

            rel_inds = find(S2_b == blocks(bi));
            rel_S2_b = S2_b(rel_inds);
            rel_S2_S = floor(S2_t(rel_inds) * LFP_SR - STIM_MARGIN*LFP_SR) ;
            rel_S2off_S = ceil(S2off_t(rel_inds) * LFP_SR);
            for rIi = 1:length(rel_inds)
                D([rel_S2_S(rIi):rel_S2off_S(rIi)]) = inf;
            end

            rel_inds = find(Cs1_b == blocks(bi));
            rel_Cs1_b = Cs1_b(rel_inds);
            rel_Cs1_S = floor(Cs1_t(rel_inds) * LFP_SR - STIM_MARGIN*LFP_SR) ;
            rel_Cs1off_S = ceil(Cs1off_t(rel_inds) * LFP_SR);
            for rIi = 1:length(rel_inds)
                D([rel_Cs1_S(rIi):rel_Cs1off_S(rIi)]) = inf;
            end

            rel_inds = find(Cs2_b == blocks(bi));
            rel_Cs2_b = Cs2_b(rel_inds);
            rel_Cs2_S = floor(Cs2_t(rel_inds) * LFP_SR - STIM_MARGIN*LFP_SR) ;
            rel_Cs2off_S = ceil(Cs2off_t(rel_inds) * LFP_SR);
            for rIi = 1:length(rel_inds)
                D([rel_Cs2_S(rIi):rel_Cs2off_S(rIi)]) = inf;
            end
            %%%%%%%%%%%%%%% finished setting to zero stimulation times

            for ci = 1:length(cut_strings)
                % This is the critical time saving line, it is here that we
                % select all events of this type that are within this
                % block, this saves a lot of loading time
                eval(['these_inds =  find(' cut_strings{ci} '_b == blocks(bi));']);
                eval(['these_times  =  ' cut_strings{ci} '_t(these_inds);']);
                these_samps = round(these_times*LFP_SR);
                for ti = 1:length(these_inds)
                    cut_inds = [these_samps(ti)-LFP_Sb:these_samps(ti)+LFP_Sa];
                    good_inds = find(cut_inds > 0  & cut_inds < length(D));
                    DS = zeros(1,length(cut_inds));
                    DS(good_inds) = D(cut_inds(good_inds));
                    LFP{ci}{these_inds(ti)}(ei,:) = DS;
                end % over events in this block
            end % over cuts
        end % over channels (within a block)
    end % over blocks
end % of nVAR condition

% used for debugging
%blocks = 2:13;
%rel = strcmp('Estrus Urine_1e2F_1ul',odor_names);
%S1_b = S1_b(rel);
%S1_t = S1_t(rel);
%S1off_b = S1off_b(rel);
%S1off_t = S1off_t(rel);
%odor_names = odor_names(rel);


if DO_nVAR

    ELEC_Sb = round(Tb * ELEC_SR)
    ELEC_Sa = round(Ta * ELEC_SR)

    for bi = 1:length(blocks)
        ELEC_files = dir([datadir 'Block-' num2str(blocks(bi)) filesep '*Elec*']);

        for elci = 1:length(ELEC_files)
            [tmp tmp_name ] = fileparts(ELEC_files(elci).name);
            ELEC_names{elci} = tmp_name;
            last_us = max(findstr('_',tmp_name));
            chan_nums(elci) = str2num(tmp_name(last_us+1:end));
        end
        [chans sortind] = sort(chan_nums);
        ELEC_names = ELEC_names(sortind);

        for ei = 1:length(ELEC_names)
            varname = ['Elec_' num2str(chans(ei))];
            D = load([datadir 'Block-' num2str(blocks(bi)) filesep ELEC_names{ei} ],varname);
            eval(['D = D.' varname ';']);

            % Make all stimulation samples to zero
            rel_inds = find(S1_b == blocks(bi));
            rel_S1_b = S1_b(rel_inds);
            rel_S1_S = floor(S1_t(rel_inds) * ELEC_SR - STIM_MARGIN*ELEC_SR) ;
            rel_S1off_S = ceil(S1off_t(rel_inds) * ELEC_SR);
            for rIi = 1:length(rel_inds)
                D([rel_S1_S(rIi):rel_S1off_S(rIi)]) = inf;
            end

            rel_inds = find(S2_b == blocks(bi));
            rel_S2_b = S2_b(rel_inds);
            rel_S2_S = floor(S2_t(rel_inds) * ELEC_SR - STIM_MARGIN*ELEC_SR) ;
            rel_S2off_S = ceil(S2off_t(rel_inds) * ELEC_SR);
            for rIi = 1:length(rel_inds)
                D([rel_S2_S(rIi):rel_S2off_S(rIi)]) = inf;
            end

            rel_inds = find(Cs1_b == blocks(bi));
            rel_Cs1_b = Cs1_b(rel_inds);
            rel_Cs1_S = floor(Cs1_t(rel_inds) * ELEC_SR - STIM_MARGIN*ELEC_SR) ;
            rel_Cs1off_S = ceil(Cs1off_t(rel_inds) * ELEC_SR);
            for rIi = 1:length(rel_inds)
                D([rel_Cs1_S(rIi):rel_Cs1off_S(rIi)]) = inf;
            end

            rel_inds = find(Cs2_b == blocks(bi));
            rel_Cs2_b = Cs2_b(rel_inds);
            rel_Cs2_S = floor(Cs2_t(rel_inds) * ELEC_SR - STIM_MARGIN*ELEC_SR) ;
            rel_Cs2off_S = ceil(Cs2off_t(rel_inds) * ELEC_SR);
            for rIi = 1:length(rel_inds)
                D([rel_Cs2_S(rIi):rel_Cs2off_S(rIi)]) = inf;
            end
            %%%%%%%%%%%%%%% finished setting to zero stimulation times

            for ci = 1:length(cut_strings)
                % This is the critical time saving line, it is here that we
                % select all events of this type that are within this
                % block, this saves a lot of loading time
                eval(['these_inds =  find(' cut_strings{ci} '_b == blocks(bi));']);
                eval(['these_times  =  ' cut_strings{ci} '_t(these_inds);']);
                these_samps = round(these_times*ELEC_SR);
                for ti = 1:length(these_inds)
                    cut_inds = [these_samps(ti)-ELEC_Sb:these_samps(ti)+ELEC_Sa];
                    good_inds = find(cut_inds > 0  & cut_inds < length(D));
                    DS = zeros(1,length(cut_inds));
                    DS(good_inds) = D(cut_inds(good_inds));

                    info_str = ['chan ' num2str(ei) ' block ' num2str(blocks(bi)) ' odor ' odor_names{these_inds(ti)} ' ' cut_strings{ci}];

                    [R BinTimes] = get_running_var(DS,nVAR_StepSize,nVAR_BinSize,ELEC_SR,info_str);

                    R = smooth_responses(R,nVAR_W);

                    nVAR{ci}{these_inds(ti)}(ei,:) = R;
                end % over events in this block
            end % over cuts
        end % over channels (within a block)
    end % over blocks
end % of nVAR condition

if DO_nVAR
    save(nVAR_outfname,'nVAR_BinSize','nVAR_StepSize','nVAR_SmoothBin','BinTimes','nVAR','odor_names','cut_names','E_b','E_t','S1_b','S1_t','S2_b','S2_t','C_b','C_t','Cs1_b','Cs1_t','Cs2_b','Cs2_t','Tb','Ta','chans')
end

if DO_LFP
    save(LFP_outfname,'LFP','odor_names','cut_names','E_b','E_t','S1_b','S1_t','S2_b','S2_t','C_b','C_t','Cs1_b','Cs1_t','Cs2_b','Cs2_t','Tb','Ta','chans')
end

return



