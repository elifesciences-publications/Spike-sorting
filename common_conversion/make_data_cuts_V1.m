function [make_cut_success] = make_data_cuts_V1(expdate,session);
% get the spike data and arrange it into cuts defined by events
% Results are saved in an output file: [basepath 'CutData\cutdata_TrialEpochs_' sstring '_unsorted']

global GLBL_WHICH_PC; % Yoram's convention
%%%%%%%%%%%%%%%%%%%%%%  if GLBL_WHICH_PC == joe

global call_process_params % Joe's convention

make_cut_success = 0;
%%%%%%%%%%%%%%%%end
                    
% call_process_params


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition of data cuts duration
% The events on which these durations are based are defined below
% It is a STRONG ASSUMPTION that the second cut is centered on the
% stimulation epoch. This assumption comes into play later on when the
% the cut times are defined. 
% Tbs = [10 10 10 10 10 10 40];
% Tas = [20 40 20 20 20 20 80];
Tbs = [10 10 10 10 10 10 20];
Tas = [20 40 20 20 20 20 60];
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINITIONS RELATED TO BINNING SPIKES
BinSize = 0.2;
% build time vectors around the events defined above
for ci = 1:length(Tas)
    timevecS{ci} = [-Tbs(ci):BinSize:Tas(ci)];
    for j = 1:length(timevecS{ci})-1
        TimeVecCenS{ci}(j) = mean([timevecS{ci}(j) timevecS{ci}(j+1)]);
    end
end
% Parameters for smoothing the binned spike counts
SmoothWinLen = 3; % In seconds
WL = round(SmoothWinLen./BinSize);
if ~mod(WL,2)
    WL = WL + 1;
end
Wdur = BinSize * WL;
W = window(@triang,WL);
W = W/sum(W); % normalize it !
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GET INFORMATION ABOUT THE SESSION (BLOCKS ETC) AND NAME OUTPUT FILE
% Construct the session string
% Get information pertaining to session
% Note the different conventions of YBS and JFB - one uses the
% get_session_info, the other sets the parameters in a calling function
% within the call_process_params structure
if ~isempty(call_process_params)
    Sorted=1;
    fn               = call_process_params.file_num;
    basepath         = call_process_params.basepath;
    datadir          = call_process_params.analysis_datadir;
    combined_datadir = call_process_params.analysis_combined_datadir;
    
    expdate=call_process_params.expdate;
    session=call_process_params.site{fn};
    session=str2num(session(5:end));  %%converts the string 'site1' to a number 1    
    blocks=call_process_params.blocks{fn};    
else
    [datadir,combined_datadir,blocks,tmp,tmp,tmp] = get_session_info(expdate,session);
    switch GLBL_WHICH_PC
        case 'LAPTOP'
            basepath = 'C:\DATA\';
        otherwise
            basepath = 'c:\DATA\'; % Modified on Jan09 for restoring data on TDT PC
    end
end
sstring = ['(' expdate '-s' num2str(session) ')'];
% the accurate sampling rate
SR =  2.441406250000000e+004;


% name of output file
cuts_fname = [basepath 'CutData',filesep,'cutdata_TrialEpochs_' sstring '_sorted'];
resps_fname = [basepath 'Responses',filesep,'Responses_' sstring '_sorted'];  %%JFB edit  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% GET EPOCH TIME SCRIPT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% GET NON SPIKE EVENT DATA. THIS IS OBTAINED BY READING THE EXP LOG FILES
% AND THE TDT EVENT FILES
[etimes, enames, etypes, Events] =  get_Event_cuts(expdate,datadir,blocks);
% This funciton is required for a subset of days in the first amygdala
% recordings that had some errors on how events were called. This should
% not be applicable to other days after those
[enames,etypes] = correct_enames(enames,etypes,expdate,session);

% Reformat the event information to store them in one structure
% each index corresponds to one element and the different variables
% are the times, types, event names and blocks - uniquely defining each
% event
all_etimes   = [];
all_enames   = [];
all_etypes   = [];
k = 1;
for bi = 1:length(blocks)
    n = length(enames{bi});
    for j = 1:n
        all_etimes(k) = etimes{bi}(j);
        all_etypes{k} = etypes{bi}{j};
        all_enames{k} = enames{bi}{j};
        all_blocks(k) = blocks(bi);
        k = k + 1;
    end
end

% Correct errors that were introduced during the expertiment by the
% experimenter, or by some failure of the acquisition system.
% This is done using the file handle event exceptions. 
% This is to see the event sequence prior to changes - for debugging purposes
SHOW_SEQUENCE_BEFORE_CORRECTING = 0;
if SHOW_SEQUENCE_BEFORE_CORRECTING
    for i = 1:length(all_enames)
%         disp([num2str(i) ' ' all_enames(i) ' block: ' num2str(all_blocks(i)) ' time: ' num2str(all_etimes(i))]);
        disp([num2str(i) ' ' ' block: ' num2str(all_blocks(i)) ' time: ' num2str(all_etimes(i)) ' ' all_enames{i} ]);
    end
         fprintf(1,'\n\n\n');
end
% This calls the function that applies any "manual" changes, required to correct for errors during the experiment (like misnamed por forgotten events)
% we call the YBS version and then the JFB version
[all_enames,all_etimes,all_etypes,all_blocks] =     handle_event_exceptions(lower(expdate),session,all_enames,all_etimes,all_etypes,all_blocks);
[all_enames,all_etimes,all_etypes,all_blocks] = handle_event_exceptions_JFB(lower(expdate),session,all_enames,all_etimes,all_etypes,all_blocks);



% Ignore all quick clean events which will mess up the order assumed for
% the other events - I do not think we have any of these in our amygdala
% data. But I keep this block for to be extra safe.
ignore = strmatch('quick clean',all_enames);
all_enames(ignore) = [];
all_etimes(ignore) = [];
all_etypes(ignore) = [];
all_blocks(ignore) = [];

% This is to see the event sequence after the changes have been applied
for i = 1:length(all_enames)
    disp([num2str(i) ' ' ' block: ' num2str(all_blocks(i)) ' time: ' num2str(all_etimes(i)) ' ' all_enames{i} ]);
end

% Because we had various types of sessions, each of which is associated with
% a different set of events, and sometimes even different naming schemes in
% the TDT system, these event type definitions are made depending on the
% specific sessions. 


[odor_events,odor_names,event_type]  =   find_odor_events_common(expdate,all_etypes,all_enames);
% if isempty(odor_events)
%     [odor_events,odor_names,event_type]  =   JFB_find_odor_events(expdate,all_etypes,all_enames);
% end
if isempty(odor_events)
    disp('no specification for events types, please neter in the YBS_ or JFB_find_odor_events file')
end
        
        
stimon_events = strmatch('stimulation',all_etypes,'exact');
stimoff_events = strmatch('stimulation off',all_etypes,'exact');
start_clean = strmatch('start clean',all_etypes,'exact');
stop_clean = strmatch('stop clean',all_etypes,'exact');
suction_events = strmatch('one air pulse',all_etypes);

% Now we start building the sequences associated with each trial
for i = 1:length(odor_events)

    oe = odor_events(i);
    % The odor applied events, time and block for the ith trial
    E_t(i) = all_etimes(oe);
    E_b(i) = all_blocks(oe);

    % A typical VNS event, with two cleaning stimulations
    if event_type(i) == 1

        % Finds the following stim
        S1 = stimon_events(min(find(stimon_events > oe)));
        % and check whether it is the next event
        if ~(S1 == oe+1)
            disp(['problems associated with:'])
            msgstr = [num2str(S1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Finds the following end of stim
        S1off = stimoff_events(min(find(stimoff_events > S1)));
        % and check whether it is the next event
        if ~(S1off == S1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(S1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start clean event
        C = start_clean(min(find(start_clean > S1off)));
        % and check whether it is the next event
        if ~(C == S1off+1) % this is where the number of stims applied makes a difference
            disp(['problems associated with:'])
            msgstr = [num2str(C) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim event
        Cs1 = stimon_events(min(find(stimon_events > C)));
        % and check whether it is the next event
        if ~(Cs1 == C+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs1off = stimoff_events(min(find(stimoff_events > Cs1)));
        % and check whether it is the next event
        if ~(Cs1off == Cs1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim
        Cs2 = stimon_events(min(find(stimon_events > Cs1off)));
        % and check whether it is the next event
        if ~(Cs2 == Cs1off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs2) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs2off = stimoff_events(min(find(stimoff_events > Cs2)));
        % and check whether it is the next event
        if ~(Cs2off == Cs2+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs2off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop clean
        Coff = stop_clean(min(find(stop_clean > Cs2off)));
        % and check whether it is the next event
        if ~(Coff == Cs2off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Coff) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        S1_t(i) = all_etimes(S1);
        S1_b(i) = all_blocks(S1);

        S1off_t(i) = all_etimes(S1off);
        S1off_b(i) = all_blocks(S1off);

        C_t(i) = all_etimes(C);
        C_b(i) = all_blocks(C);

        Cs1_t(i) = all_etimes(Cs1);
        Cs1_b(i) = all_blocks(Cs1);

        Cs1off_t(i) = all_etimes(Cs1off);
        Cs1off_b(i) = all_blocks(Cs1off);

        Cs2_t(i) = all_etimes(Cs2);
        Cs2_b(i) = all_blocks(Cs2);

        Cs2off_t(i) = all_etimes(Cs2off);
        Cs2off_b(i) = all_blocks(Cs2off);

        Coff_t(i) = all_etimes(Coff);
        Coff_b(i) = all_blocks(Coff);


         % A VNS event with only one stimulation       
    elseif event_type(i) == 1.5

        % Finds the following stim
        S1 = stimon_events(min(find(stimon_events > oe)));
        % and check whether it is the next event
        if ~(S1 == oe+1)
            disp(['problems associated with:'])
            msgstr = [num2str(S1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Finds the following end of stim
        S1off = stimoff_events(min(find(stimoff_events > S1)));
        % and check whether it is the next event
        if ~(S1off == S1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(S1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end


        % Find the following start clean event
        C = start_clean(min(find(start_clean > S1off)));
        % and check whether it is the next event
        if ~(C == S1off+1) % this is where the number of stims applied makes a difference
            disp(['problems associated with:'])
            msgstr = [num2str(C) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim event
        Cs1 = stimon_events(min(find(stimon_events > C)));
        % and check whether it is the next event
        if ~(Cs1 == C+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs1off = stimoff_events(min(find(stimoff_events > Cs1)));
        % and check whether it is the next event
        if ~(Cs1off == Cs1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end
      
        % Find the following stop clean
        Coff = stop_clean(min(find(stop_clean > Cs1off)));
        % and check whether it is the next event
        if ~(Coff == Cs1off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Coff) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        S1_t(i) = all_etimes(S1);
        S1_b(i) = all_blocks(S1);

        S1off_t(i) = all_etimes(S1off);
        S1off_b(i) = all_blocks(S1off);

        C_t(i) = all_etimes(C);
        C_b(i) = all_blocks(C);

        Cs1_t(i) = all_etimes(Cs1);
        Cs1_b(i) = all_blocks(Cs1);

        Cs1off_t(i) = all_etimes(Cs1off);
        Cs1off_b(i) = all_blocks(Cs1off);

        Cs2_t(i) = nan; %all_etimes(Cs2);
        Cs2_b(i) = nan; %all_blocks(Cs2);
        
        Cs2off_t(i) = nan; %all_etimes(Cs2off);
        Cs2off_b(i) = nan;  %all_blocks(Cs2off);


        Coff_t(i) = all_etimes(Coff);
        Coff_b(i) = all_blocks(Coff);
        
        % If this is an MOS event - in this case there is no stimulation after
        % wards, just the suction event
    elseif event_type(i) == 2

        % Find the following start clean event
        C = start_clean(min(find(start_clean > oe)));
        % and check whether it is the next event
        if ~(C == oe+1) % this is where the number of stims applied makes a difference
            disp(['problems associated with:'])
            msgstr = [num2str(C) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim event
        Cs1 = stimon_events(min(find(stimon_events > C)));
        % and check whether it is the next event
        if ~(Cs1 == C+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs1off = stimoff_events(min(find(stimoff_events > Cs1)));
        % and check whether it is the next event
        if ~(Cs1off == Cs1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim
        Cs2 = stimon_events(min(find(stimon_events > Cs1off)));
        % and check whether it is the next event
        if ~(Cs2 == Cs1off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs2) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs2off = stimoff_events(min(find(stimoff_events > Cs2)));
        % and check whether it is the next event
        if ~(Cs2off == Cs2+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs2off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop clean
        Coff = stop_clean(min(find(stop_clean > Cs2off)));
        % and check whether it is the next event
        if ~(Coff == Cs2off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Coff) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        S1_t(i) = nan;
        S1_b(i) = nan;

        S1off_t(i) = nan;
        S1off_b(i) = nan;

        C_t(i) = all_etimes(C);
        C_b(i) = all_blocks(C);

        Cs1_t(i) = all_etimes(Cs1);
        Cs1_b(i) = all_blocks(Cs1);

        Cs1off_t(i) = all_etimes(Cs1off);
        Cs1off_b(i) = all_blocks(Cs1off);

        Cs2_t(i) = all_etimes(Cs2);
        Cs2_b(i) = all_blocks(Cs2);

        Cs2off_t(i) = all_etimes(Cs2off);
        Cs2off_b(i) = all_blocks(Cs2off);

        Coff_t(i) = all_etimes(Coff);
        Coff_b(i) = all_blocks(Coff);



        % a combined VNS and MOS event in which the inhalation comes on
        % during the stimulation
    elseif event_type(i) == 3
        % Finds the following stim
        S1 = stimon_events(min(find(stimon_events > oe)));
        % and check whether it is the next event
        if ~(S1 == oe+1)
            disp(['problems associated with:'])
            msgstr = [num2str(S1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Finds the following end of stim
        S1off = stimoff_events(min(find(stimoff_events > S1)));
        % and check whether it is the next event
        if ~(S1off == S1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(S1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Finds the following suction event
        Suc = suction_events(min(find(suction_events > S1off)));
        % and check whether it is the next event
        if ~(Suc == S1off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Suc) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end


        % Find the following start clean event
        C = start_clean(min(find(start_clean > Suc)));
        % and check whether it is the next event
        if ~(C == Suc+1) % this is where the number of stims applied makes a difference
            disp(['problems associated with:'])
            msgstr = [num2str(C) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim event
        Cs1 = stimon_events(min(find(stimon_events > C)));
        % and check whether it is the next event
        if ~(Cs1 == C+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs1off = stimoff_events(min(find(stimoff_events > Cs1)));
        % and check whether it is the next event
        if ~(Cs1off == Cs1+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs1off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following start stim
        Cs2 = stimon_events(min(find(stimon_events > Cs1off)));
        % and check whether it is the next event
        if ~(Cs2 == Cs1off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs2) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop stim
        Cs2off = stimoff_events(min(find(stimoff_events > Cs2)));
        % and check whether it is the next event
        if ~(Cs2off == Cs2+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Cs2off) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        % Find the following stop clean
        Coff = stop_clean(min(find(stop_clean > Cs2off)));
        % and check whether it is the next event
        if ~(Coff == Cs2off+1)
            disp(['problems associated with:'])
            msgstr = [num2str(Coff) ' after ' odor_names{i}  ];
            disp(msgstr);
            disp(['please update the handle_event_exceptions file and continue']);
            return
        end

        S1_t(i) = all_etimes(S1);
        S1_b(i) = all_blocks(S1);

        S1off_t(i) = all_etimes(S1off);
        S1off_b(i) = all_blocks(S1off);


        Suc_t(i) = all_etimes(Suc);
        Suc_b(i) = all_blocks(Suc);

        C_t(i) = all_etimes(C);
        C_b(i) = all_blocks(C);

        Cs1_t(i) = all_etimes(Cs1);
        Cs1_b(i) = all_blocks(Cs1);

        Cs1off_t(i) = all_etimes(Cs1off);
        Cs1off_b(i) = all_blocks(Cs1off);

        Cs2_t(i) = all_etimes(Cs2);
        Cs2_b(i) = all_blocks(Cs2);

        Cs2off_t(i) = all_etimes(Cs2off);
        Cs2off_b(i) = all_blocks(Cs2off);


        Coff_t(i) = all_etimes(Coff);
        Coff_b(i) = all_blocks(Coff);

        % an MOS event with inhalation only
    elseif event_type(i) == 4
               
        Inhale_t(i) = all_etimes(oe);
        Inhale_b(i) = all_blocks(oe);

        
%         555
%         
%         S1 = stimon_events(min(find(stimon_events > oe)));
%         S1off = stimoff_events(min(find(stimoff_events > S1)));
%         Suc = suction_events(min(find(suction_events > S1off)));
%         C = start_clean(min(find(start_clean > Suc)));
%         Cs1 = stimon_events(min(find(stimon_events > C)));
%         Cs1off = stimoff_events(min(find(stimoff_events > Cs1)));
%         Cs2 = stimon_events(min(find(stimon_events > Cs1off)));
%         Cs2off = stimoff_events(min(find(stimoff_events > Cs2)));
%         Coff = stop_clean(min(find(stop_clean > Cs2off)));
%         
%         555
        S1_t(i) = nan;
        S1_b(i) = nan;

        S1off_t(i) = nan;
        S1off_b(i) = nan;

        C_t(i) = nan;
        C_b(i) = nan;

        Cs1_t(i) = nan;
        Cs1_b(i) = nan;

        Cs1off_t(i) = nan;
        Cs1off_b(i) = nan;

        Cs2_t(i) = nan;
        Cs2_b(i) = nan;

        Cs2off_t(i) = nan;
        Cs2off_b(i) = nan;

        Coff_t(i) = nan;
        Coff_b(i) = nan;
        
        
    end



end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% GET EPOCH TIME SCRIPT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Get spike time data
[spiketimes spikeclass units] =  read_offline_spike_times_common(expdate,session,SR);


% Ignore the 0 (Artifact) class
units = units(find(units));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parts of this section commented out for the third version of this code, because we
% always use spike sorted data now
% Get stimulation durations and exlcude spikes if required
for i = 1:length(S1_t)    
    S1_stimdur(i) =  S1off_t(i) - S1_t(i);    
end

for i = 1:length(Cs1_t)    
    Cs1_stimdur(i) =  Cs1off_t(i) - Cs1_t(i);
    
end

for i = 1:length(Cs2_t)
    Cs2_stimdur(i) =  Cs2off_t(i) - Cs2_t(i);
end


% Used later for identifying cut identities
cut_names{1} = 'application';
cut_names{2} = 'S1';
cut_names{3} = 'Suction';
cut_names{4} = 'start clean';
cut_names{5} = 'cS1';
cut_names{6} = 'cS2';
cut_names{7} = 'fulltime'; %%JFB

% For each odor application event, make a list of the block, start time and end time
for i = 1:length(odor_names)
    
    % This is for all the large cut which applied to all the events
    % I do not see a reason why not to put it at the start
    rel_seg(i,7) = 1; %%JFB
    SEG_B(i,7) = [E_b(i)]; %%Base VNS full time on the VNS application of the fluid
    SEG_S(i,7) = [E_t(i)-Tbs(7)];
    SEG_E(i,7) = [E_t(i)+Tas(7)];
    
    if event_type(i) == 1 % VNS

        % rel_seg indicates whether the segment in question is relevant for this type of event, being either
        % MOS or VNS related - required for subsquent programs
        rel_seg(i,1) = 1;
        rel_seg(i,2) = 1;
        rel_seg(i,3) = 0;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 1;


        SEG_B(i,1) = [E_b(i)];
        SEG_S(i,1) = [E_t(i)-Tbs(1)];
        SEG_E(i,1) = [E_t(i)+Tas(1)];

        SEG_B(i,2) = [S1_b(i)];
        SEG_S(i,2) = [S1_t(i)-Tbs(2)];
        SEG_E(i,2) = [S1_t(i)+Tas(2)];

        SEG_B(i,3) = nan;
        SEG_S(i,3) = nan;
        SEG_E(i,3) = nan;

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = [Cs2_b(i)];
        SEG_S(i,6) = [Cs2_t(i)-Tbs(6)];
        SEG_E(i,6) = [Cs2_t(i)+Tas(6)];
        
        
        
    elseif event_type(i) == 1.5 % VNS with only one stimulation

        % rel_seg indicates whether the segment in question is relevant for this type of event, being either
        % MOS or VNS related - required for subsquent programs
        rel_seg(i,1) = 1;
        rel_seg(i,2) = 1;
        rel_seg(i,3) = 0;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 0;


        SEG_B(i,1) = [E_b(i)];
        SEG_S(i,1) = [E_t(i)-Tbs(1)];
        SEG_E(i,1) = [E_t(i)+Tas(1)];

        SEG_B(i,2) = [S1_b(i)];
        SEG_S(i,2) = [S1_t(i)-Tbs(2)];
        SEG_E(i,2) = [S1_t(i)+Tas(2)];

        SEG_B(i,3) = nan;
        SEG_S(i,3) = nan;
        SEG_E(i,3) = nan;

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = nan;
        SEG_S(i,6) = nan;
        SEG_E(i,6) = nan;
                
        
        % MOS event
    elseif event_type(i) == 2

        rel_seg(i,1) = 0;
        rel_seg(i,2) = 0;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 1;

        SEG_B(i,1) = nan;
        SEG_S(i,1) = nan;
        SEG_E(i,1) = nan;

        SEG_B(i,2) = nan;
        SEG_S(i,2) = nan;
        SEG_E(i,2) = nan;

        SEG_B(i,3) = [E_b(i)];
        SEG_S(i,3) = [E_t(i)-Tbs(3)];
        SEG_E(i,3) = [E_t(i)+Tas(3)];

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = [Cs2_b(i)];
        SEG_S(i,6) = [Cs2_t(i)-Tbs(6)];
        SEG_E(i,6) = [Cs2_t(i)+Tas(6)];

        
          % MOS event without clean
    elseif event_type(i) == 2.5

        rel_seg(i,1) = 0;
        rel_seg(i,2) = 0;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 0;
        rel_seg(i,5) = 0;
        rel_seg(i,6) = 0;

        SEG_B(i,1) = nan;
        SEG_S(i,1) = nan;
        SEG_E(i,1) = nan;

        SEG_B(i,2) = nan;
        SEG_S(i,2) = nan;
        SEG_E(i,2) = nan;

        SEG_B(i,3) = [E_b(i)];
        SEG_S(i,3) = [E_t(i)-Tbs(3)];
        SEG_E(i,3) = [E_t(i)+Tas(3)];

        SEG_B(i,4) = nan;
        SEG_S(i,4) = nan;
        SEG_E(i,4) = nan;

        SEG_B(i,5) = nan;
        SEG_S(i,5) = nan;
        SEG_E(i,5) = nan;

        SEG_B(i,6) = nan;
        SEG_S(i,6) = nan;
        SEG_E(i,6) = nan;
        
        
    elseif event_type(i) == 3

        rel_seg(i,1) = 1;
        rel_seg(i,2) = 1;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 1;

        SEG_B(i,1) = [E_b(i)];
        SEG_S(i,1) = [E_t(i)-Tbs(1)];
        SEG_E(i,1) = [E_t(i)+Tas(1)];

        SEG_B(i,2) = [S1_b(i)];
        SEG_S(i,2) = [S1_t(i)-Tbs(2)];
        SEG_E(i,2) = [S1_t(i)+Tas(2)];

        SEG_B(i,3) = [Suc_b(i)];
        SEG_S(i,3) = [Suc_t(i)-Tbs(3)];
        SEG_E(i,3) = [Suc_t(i)+Tas(3)];

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = [Cs2_b(i)];
        SEG_S(i,6) = [Cs2_t(i)-Tbs(6)];
        SEG_E(i,6) = [Cs2_t(i)+Tas(6)];

    elseif event_type(i) == 4

        
        rel_seg(i,1) = 0;
        rel_seg(i,2) = 0;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 0;
        rel_seg(i,5) = 0;
        rel_seg(i,6) = 0;


        SEG_B(i,1) = nan;
        SEG_S(i,1) = nan;
        SEG_E(i,1) = nan;

        SEG_B(i,2) = nan;
        SEG_S(i,2) = nan;
        SEG_E(i,2) = nan;

        SEG_B(i,3) = [Inhale_b(i)];
        SEG_S(i,3) = [Inhale_t(i)- Tbs(3)];
        SEG_E(i,3) = [Inhale_t(i)+ Tas(3)];

        SEG_B(i,4) = nan;
        SEG_S(i,4) = nan;
        SEG_E(i,4) = nan;

        SEG_B(i,5) = nan;
        SEG_S(i,5) = nan;
        SEG_E(i,5) = nan;

        SEG_B(i,6) = nan;
        SEG_S(i,6) = nan;
        SEG_E(i,6) = nan;
        
    end
end



% We found the events that define the segments, now we make actual cuts
% with spike times in them
for oi = 1:length(odor_names)     % over all trials
    for u = 1:length(units)  % over all units
        this_unit = units(u);
        for ci = 1:size(SEG_B,2) % Over all cut events

            clear binned_spikes

            S = SEG_S(oi,ci);
            E = SEG_E(oi,ci);
            B = SEG_B(oi,ci);

            if ~isnan(B) % If this is not an empty segment

                thesespiketimes = spiketimes{B}(find(spikeclass{B} == this_unit));
                % get spikes falling within data segments
                inds = find(thesespiketimes >= S & thesespiketimes <= E);
                % Specify spike times relative to segment cut time
                thesespiketimes = (thesespiketimes(inds)-S) -Tbs(ci);

                % the indices here are for, odor, cut, and unit
                spike_times{oi}{ci}{u} = thesespiketimes;
                % bin these spikes
                for bsi = 1:length(timevecS{ci})-1
                    binned_spikes(bsi) = length(find(thesespiketimes >= timevecS{ci}(bsi) & thesespiketimes < timevecS{ci}(bsi+1)));
                end

                binned_spike_times{oi}{ci}{u} = binned_spikes;
                % Make smoothed spike counts
                S_binned_spike_times{oi}{ci}{u} = smooth_responses(binned_spike_times{oi}{ci}{u},W);

            else
                spike_times{oi}{ci}{u} = '';
                binned_spike_times{oi}{ci}{u} = '';
                % Make smoothed spike counts
                S_binned_spike_times{oi}{ci}{u} = '';
            end
        end
    end
end

% Display a summary of odor application events
for i = 1:length(odor_names)
    disp(['block: ' num2str(E_b(i)) ' time: ' num2str(round(E_t(i)*10)/10)]);
    disp([odor_names{i}]);
    disp(['-----------']);
end

% Generates a command line display of which odorants where given at which concentrations
full_odor_names = odor_names;
odor_names = shorten_event_names(full_odor_names);
un = unique(odor_names);
un(:)

% save the data in a file
save(cuts_fname,'rel_seg','spike_times','S_binned_spike_times','Wdur','binned_spike_times','BinSize','TimeVecCenS','odor_names','full_odor_names','cut_names','E_b','E_t','S1_b','S1_t','C_b','C_t','Cs1_b','Cs1_t','Cs2_b','Cs2_t','Tbs','Tas','SEG_B','SEG_S','SEG_E','spikeclass','units','S1_stimdur','Cs1_stimdur','Cs2_stimdur')


% Calculate the duration of stimulations during that session
% I exlcude these that are precisly 1, because they are the ones that I added artificially using the handle_event_exceptions file.

if sum(~isnan(S1_stimdur))

    
    
    % This condition of isfinite was added by JFB. YBS just entered the
    % change into the same variable
    Cs1_stimdur =Cs1_stimdur(find(isfinite(Cs1_stimdur))); %%JFB edits
    S1_stimdur  =S1_stimdur(find(isfinite(S1_stimdur)));  %%JFB edits
       
    Cs1_artvals = find(~(Cs1_stimdur-1.000));    
    S1_artvals = find((S1_stimdur-1.000) == 0);    

    if ~isempty([Cs1_artvals  S1_artvals] )
        disp(['artificial values found in '  expdate  '  session' num2str(session)]);
        Cs1_stimdur(Cs1_artvals) = [];        
        S1_stimdur(S1_artvals) = [];
    end
    
    mns = min([Cs1_stimdur S1_stimdur]);
    mxs = max([Cs1_stimdur S1_stimdur]);
    
    if (mxs - mns) > 0.2 % If it is more than 0.2 there must be two sets of stimulations -
        disp('warning - not all stim durations are the same')
    end
    stim_range = [mns mxs];

else
    stim_range = [0 0];
    mns = 0;
    mxs = 0;
end

% For calcualting the mean responses before and after
for ci = 1:length(TimeVecCenS)
    before(ci) = (max(find(TimeVecCenS{ci} < 0))); % before is actually the last timepoint before the event begins
    
    % NOte that now (July 2010) I only define and  after time after the
    % sitmulation for the sitmulation epoch - assuming that the
    % sitmulation epoch is the second cut
    if ci == 2
        after(ci) = (min(find(TimeVecCenS{ci} > mxs))); % This is the first time point after the end of the sitmulation
    else
        after(ci) = (min(find(TimeVecCenS{ci} > 0))); % This is the first time point after the end of the sitmulation
    end
        
    [tmp stim_start(ci)] = min(abs(TimeVecCenS{ci})); % The point closest to the start of the stim
    % This is an important bug fix (July 2010) - the end time used to be 30 seconds for
    % all - now it is 30 seconds for the sitmulation epoch and the length
    % of the entire segment for all other epochs
    if Tas(ci) == 40
        taketime = 30;
    else
        taketime = Tas(ci);
    end
    [tmp resp_end(ci)] = min(abs(TimeVecCenS{ci} - taketime)); % The point closest to 30 seconds
end

[Sa,Sb,Modulation,Power,PeakRate,MinRate,RespStart,PeakTime,MinTime,FiftyPercentTime,NinetyPercentTime,IsResponse] = get_response_properties_common(S_binned_spike_times,before,stim_start,after,resp_end,BinSize);

save(resps_fname,'rel_seg','Sa','Sb','Modulation','Power','PeakRate','MinRate','RespStart','PeakTime','MinTime','FiftyPercentTime','NinetyPercentTime','IsResponse','cut_names','odor_names','units','stim_range')



make_cut_success = 1;


return




