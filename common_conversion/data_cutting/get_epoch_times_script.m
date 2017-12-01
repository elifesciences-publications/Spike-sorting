% Get the times of the application, stimulations and cleaning events for each trial - i.e. for each odor application



% Some days have 3 stim events and therefore there should be a gap after
% the second stim end and the clean and the second stim and the clean end
% I did not include this information in the database since this function is accessed once for each session in principle
Nstims = 2;
EXTRASTIMEVENTS = 2 * (Nstims-2); % each extra stim adds two events, stim on and sitm off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% get Event data
[etimes, enames, etypes, Events] =  get_Event_cuts(expdate,datadir,blocks);
%[stimodor, stimnum] = get_event_description(etypes,enames,etimes);

% Reformat this information to have them in one structure
all_etimes   = [];
all_enames = [];
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


% This is to see the event sequence prior to changes - for debugging purposes
SHOW_SEQUENCE_BEFORE_CORRECTING = 0;
if SHOW_SEQUENCE_BEFORE_CORRECTING
    for i = 1:length(all_enames)
        disp([num2str(i) ' ' all_enames(i) ' block: ' num2str(all_blocks(i)) ' time: ' num2str(all_etimes(i))]);
    end
end

% This calls the function that applies any "manual" changes, required to correct for errors during the experiment (like misnamed por forgotten events)
[all_enames,all_etimes,all_etypes,all_blocks] = handle_event_exceptions(expdate,session,all_enames,all_etimes,all_etypes,all_blocks);

% Ignore all quick clean events which will mess up the order assumed for the other events
ignore = strmatch('quick clean',all_enames);
all_enames(ignore) = [];
all_etimes(ignore) = [];
all_etypes(ignore) = [];
all_blocks(ignore) = [];

% This is to see the event sequence after the changes have been applied
for i = 1:length(all_enames)
    disp([num2str(i) ' ' ' block: ' num2str(all_blocks(i)) ' time: ' num2str(all_etimes(i)) ' ' all_enames{i} ]);
end



% Now we start building the sequences ...

% Get times of all event types
odor_events = strmatch('odor applied',all_etypes,'exact');
odor_names = all_enames(odor_events);

stimon_events = strmatch('stimulation',all_etypes,'exact');
stimoff_events = strmatch('stimulation off',all_etypes,'exact');
start_clean = strmatch('start clean',all_etypes,'exact');
stop_clean = strmatch('stop clean',all_etypes,'exact');


% NOw we start building the sequences associated with each trial
for i = 1:length(odor_events)

    oe = odor_events(i);
    
    % The odor applied events, time and block for the ith trial
    E_t(i) = all_etimes(oe);
    E_b(i) = all_blocks(oe);

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

    % Finds the following stim
    S2 = stimon_events(min(find(stimon_events > S1off)));
    % and check whether it is the next event
    if ~(S2 == S1off+1)
        disp(['problems associated with:'])
        msgstr = [num2str(S2) ' after ' odor_names{i}  ];
        disp(msgstr);
        disp(['please update the handle_event_exceptions file and continue']);
        return  
    end

    % Finds the following end of stim
    S2off = stimoff_events(min(find(stimoff_events > S2)));
    % and check whether it is the next event
    if ~(S2off == S2+1)
        disp(['problems associated with:'])
        msgstr = [num2str(S2off) ' after ' odor_names{i}  ];
        disp(msgstr);
        disp(['please update the handle_event_exceptions file and continue']);
        return  
    end

    % Find the following start clean event
    C = start_clean(min(find(start_clean > S2off)));
    % and check whether it is the next event
    if ~(C == S2off+1 + EXTRASTIMEVENTS) % this is where the number of stims applied makes a difference
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
    if ~(Coff == Cs2off+1+EXTRASTIMEVENTS)
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

    S2_t(i) = all_etimes(S2);
    S2_b(i) = all_blocks(S2);

    S2off_t(i) = all_etimes(S2off);
    S2off_b(i) = all_blocks(S2off);

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

    if ~isempty(Coff)
        Coff_t(i) = all_etimes(Coff);
        Coff_b(i) = all_blocks(Coff);
    else
        Coff_t(i) = 0;
        Coff_b(i) = 0;
    end

end
