function get_contin_trial_epochs(expdate,session,SignalType);
% Get segments of the LFP or the nVAR signals

switch SignalType
    case    'nvar'
        DO_LFP = 0;
        DO_nVAR = 1;
    case 'lfp'
        DO_LFP = 1;
        DO_nVAR = 0;
end

STIM_MARGIN = 0.12 ; % Seconds which may be the delay from start of stim time to actual stim
% The issue stems form the delay between the start stim
% time and the correspondig synchronization code - see
% the get_event_cuts for understading the issue.

% Extent to take before and after cut definition
Tb = 10;
Ta = 30;

if DO_nVAR
    % Parameters for the nVAR signal
    nVAR_BinSize   = 0.4;
    nVAR_StepSize  = 0.2;
    nVAR_SmoothBin = 2; % seconds
    nVAR_WL = round(nVAR_SmoothBin/nVAR_BinSize);
    if ~mod(nVAR_WL,2)
        nVAR_WL = nVAR_WL + 1;
    end
    nVAR_W = window(@gausswin,nVAR_WL);
    nVAR_W = nVAR_W/sum(nVAR_W);
end

% if DO_LFP
%     % Parameters for the nVAR signal
%     LFP_BinSize   = 0.4;
%     LFP_StepSize  = 0.2;
%     LFP_SmoothBin = 2; % seconds
%     LFP_WL = round(LFP_SmoothBin/LFP_BinSize);
%     if ~mod(LFP_WL,2)
%         LFP_WL = LFP_WL + 1;
%     end
%     LFP_W = window(@gausswin,LFP_WL);
%     LFP_W = LFP_W/sum(LFP_W);
% end

global GLBL_WHICH_PC;
DELETE_STIMULATION_SPIKES = 1;

% Construct the session string
sstring = ['(' expdate '-s' num2str(session) ')'];

% A flag denoting whetehr to delete all spikes that occur between start of
% stimulation and end of stimulation - this is only possible if that day
% included a stimulation off Event
% purge_spikes_during_stimulation = 1;
% StartStimEvent = 'stimulation';
% EndStimEvent = 'stimulation off';

SR =  2.441406250000000e+004;
% Get information pertaining to session
[datadir,combined_datadir,blocks,PC_block,groups,maxSN] = get_session_info(expdate,session);

% For debugging


switch GLBL_WHICH_PC
    case 'LAPTOP'
        basepath = 'C:\DATA\';
    otherwise
        basepath = 'c:\';
end

% get the epochs boundaries, a lot happnes within this script,
% including some session specific settings.

get_epoch_times_script

if DO_LFP
    LFP_outfname = [basepath 'CutData\cutdata_TrialEpochs_' sstring '_LFP'];
end
if DO_nVAR
    nVAR_outfname = [basepath 'CutData\cutdata_TrialEpochs_' sstring '_nVAR'];
end

datadir = [basepath 'continuous_data' filesep expdate filesep 'mat' filesep];

block_dirs = dir(datadir)
k = 1;
for i = 1:length(block_dirs)
    if findstr('Block',block_dirs(i).name)
        block_Dirs{k} = block_dirs(i).name;
        k = k + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Get sampling rate information %%
% Get the info for the ELec data and the LFP
load([datadir block_Dirs{1} filesep 'info.mat']);
if DO_LFP
    for  i = 1:length(datainfo)
        if strmatch('LFPs',datainfo(i).name)
            LFP_SR = datainfo(i).SR;
            break
        end
    end
end

if DO_nVAR
    for  i = 1:length(datainfo)
        if strmatch('Elec',datainfo(i).name)
            ELEC_SR = datainfo(i).SR;
            break
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%trial_blocks = unique(S1_b)
% Do the LFPs
% This is not the most efficient way to do things, I load files more times
% than neccessary, but it is simpler conceptually and so I will keep to
% this way unless this proves too slow.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cut_names{1} = 'application';
cut_names{2} = 'S1';
cut_names{3} = 'S2';
cut_names{4} = 'start clean';
cut_names{5} = 'cS1';
cut_names{6} = 'cS2';

cut_strings{1} = 'E';
cut_strings{2} = 'S1';
cut_strings{3} = 'S2';
cut_strings{4} = 'C';
cut_strings{5} = 'Cs1';
cut_strings{6} = 'Cs2';

cut_END_strings{1} = '';
cut_END_strings{2} = 'S1_off';
cut_END_strings{3} = 'S2_off';
cut_END_strings{4} = '';
cut_END_strings{5} = 'Cs1_off';
cut_END_strings{6} = 'Cs2_off';




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



