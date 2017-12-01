% manage calling various procedures related to spike sorting


% profile on

% Free memory before beginning
clear; % pack

% Define date and session

% basic urine fractions
datestr    = '11sep08'; site = 1;

% need to classify groups 3 and 4 for this day
[datadir,combined_datadir,blocks,PC_block,groups] = get_session_info(datestr,site);


do_groups = 1:4;
% Integer sampling rate. not the true sampling rate which is later applied
% to get the actual time
SR = 24414;


PRE_PROCESS  = 1;      % Everything until and including Klustakwik
POST_PROCESS = 0;      % things that you do after manual clustering
COMBINE_DAT_FILES = 0; % This is for generating combined dat files for Klusters. Since DAT files are usually huge,
                       % I use only the first two blocks for making them -
                       % this is usually enough for monitoring spike
                       % sorting. 
                       
if ([PRE_PROCESS + POST_PROCESS + COMBINE_DAT_FILES ] > 1)
    disp('CALL PROCESS cannot do more than one task category at a time (chosse "pre process" OR "post process" OR "combine dat files")')
    return
end
                       
% Parameters for the program that combines dat files
combine_blocks = [1 2];
combine_group_ind = 4;
combine_nchans = length(groups(combine_group_ind).chans);
                                
% pre process tasks
CHECK    = 0; % Check for data completeness - relevant when TDT messes up
DETECT   = 0 % Detect spike times
    % These paramters are dependens on the specifid data set, so they shold be
    % evaluated by testing the results in Neuroscope and Klusters.
    DT = 3.5; % dead time in ms (for spikes detected in the same channel)
    acDT = 2; % dead time in ms for spikes from different channels.
    Tb = 1.5; % time before peak of spike (ms)
    Ta = 2;   % time after peak of spike  (ms)    
    ThreshFact = 1.0; % This is a factor which increases the stringency of spike detection - a value of 1 takes the default threshold
    % detection, which leads to a lot of false positives.
    % higher values effectively increase threshold
    ArtRatio = 40;    % this is how artifacts are rejected - it means that any value that is more than
    % ArtRatio SDs above the mean of spike amiplitudes in the PC
    % block is rejected in other blocks as noise.
    % There is a big incentive to remove artifacts from
    % processiing as soon as possible, yet not to lose spikes
    % in the process.  
EXTRACT  = 0; % Extract waveforms
PCS      = 0; % Calculate primciple components
PROJECT  = 1; % Find the projections of each signal on the PCs and generate the feature files
    DO_TIME  =  0; % Set to 0 if preprocessing, set to 1 if ready to classify
    Npcs = 2; % number of PCs used for projections
CLASSIFY = 0;

% post process tasks
CLASSIFY_NOISE       = 0; % Classify noisy spikes according to their channels of origin (i.e. largest amplitude)
DIVIDE               = 0;       % Divide the classified spike files, so these can be viewed with Neuroscope.
REORDER_BY_AMPLITUDE = 0;
COMBINE_AND_REFORMAT = 1; % Combine across all groups and save as a single matlab variable
DELETE_SOURCE_FILES  = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


preprocess_tasks =  [CHECK DETECT EXTRACT PCS PROJECT CLASSIFY];
postprocess_tasks = [ CLASSIFY_NOISE REORDER_BY_AMPLITUDE DIVIDE COMBINE_AND_REFORMAT DELETE_SOURCE_FILES];

% Parameters which most likely should not be modified
IBI = 1;  % Inter block itnerval - used for combining files - no need to change from 1 


%%%%%%%%%%%%%%%%%%%%%%%%
% used these values on group 4 of 05july and also forthe 4th electrode of 14mar07, because otherwise files were just
%too large for Klusters to load - it is only for the combined spike files
% disp(['CHEAT CHEAT CHEAT'])
% disp(['CHEAT CHEAT CHEAT'])
% disp(['CHEAT CHEAT CHEAT'])
% disp(['CHEAT CHEAT CHEAT'])
% disp(['CHEAT CHEAT CHEAT'])
% Tb = 1
% Ta = 1.5


if PRE_PROCESS
    pre_process(preprocess_tasks,groups,do_groups,datadir,combined_datadir,blocks,PC_block,DT,Tb,Ta,SR,Npcs,IBI,ThreshFact,acDT,ArtRatio,DO_TIME);
end
if POST_PROCESS
    post_process(postprocess_tasks,groups,do_groups,datadir,combined_datadir,blocks,IBI,SR,Ta,Tb,datestr,site);
end
if COMBINE_DAT_FILES
    combine_dat_files(datadir,combined_datadir,combine_blocks,IBI,SR,combine_nchans,combine_group_ind)
end

% profile off
% profile viewer

return


