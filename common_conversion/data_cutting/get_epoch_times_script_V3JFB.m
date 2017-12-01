% Get the times of the application, stimulations and cleaning events for each trial - i.e. for each odor application


% The V2 is for sessions conducted after changing the protocol, so that now it is:
% application
% wait 20 seconds
% stimulation
% wait 40 seconds
% start clean
% stimulation
% wait 20 seconds
% stimulation
% wait 20 seconds
% stop clean


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% get Event data
[etimes, enames, etypes, Events] =  get_Event_cuts_JFB(expdate,datadir,blocks);
%[stimodor, stimnum] = get_event_description(etypes,enames,etimes);


% There are only a few days that require this kind of correction. 
[enames,etypes] = correct_enames(enames,etypes,expdate,session);


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
[all_enames,all_etimes,all_etypes,all_blocks] = handle_event_exceptions_JFB(expdate,session,all_enames,all_etimes,all_etypes,all_blocks);

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
    

switch lower(expdate)
    
    % Later on we did only MOS or VNS but there were some errors in
    % reporting to TDT
    case {'15may09','20may09'}
         
        % Get times of all event types - in this version we have to distinguish
        % between MOS and VNS events
        VNS_odor_events = strmatch('odor applied',all_etypes,'exact');
        
        fake_events = strmatch('fake',all_enames,'exact'); %%JFB edit to remove fake events
        fake_VNS_events = intersect(fake_events,VNS_odor_events); %%JFB edit edit to remove fake events
        VNS_odor_events = setdiff(VNS_odor_events,fake_VNS_events); %%JFB edit edit to remove fake events
        
        
        %VNS_odor_names = all_enames(VNS_odor_events);

        MOS_odor_events = strmatch('one air pulse - 3 sec',all_etypes,'exact');
        %MOS_odor_names = all_enames(MOS_odor_events);

        odor_events = union(VNS_odor_events,MOS_odor_events);
        odor_names = all_enames(odor_events);
        for i = 1:length(odor_events)
            if ismember(odor_events(i),VNS_odor_events)
                event_type(i) = 1; % 1 is for VNS
            else
                event_type(i) = 2; % 2 is for MOS
            end
        end

    % During earlier session we had both the VNS and the MOS stim in each    
    case {'14apr09','10apr09','07apr09','03apr09'}
        odor_events = strmatch('odor applied',all_etypes,'exact');
        event_type = 3 * ones(1,length(odor_events));
        odor_names = all_enames(odor_events);
        
    % During earlier session we had both the VNS and the MOS stim in each    
    case {'26may09_test','27may09','04jun09','18jun09','11jun09','23jun09','30jun09'}
        % Get times of all event types - in this version we have to distinguish
        % between MOS and VNS events
        VNS_odor_events = strmatch('odor applied',all_etypes,'exact');
        %VNS_odor_names = all_enames(VNS_odor_events);

        MOS_odor_events = strmatch('odor suction',all_etypes,'exact');
        %MOS_odor_names = all_enames(MOS_odor_events);

        odor_events = union(VNS_odor_events,MOS_odor_events);
        odor_names = all_enames(odor_events);
        for i = 1:length(odor_events)
            if ismember(odor_events(i),VNS_odor_events)
                event_type(i) = 1; % 1 is for VNS
            else
                event_type(i) = 2; % 2 is for MOS
            end
        end
    otherwise %%the most up-to-date filetype   %%%%%JFB EDITS
        
        % Get times of all event types - in this version we have to distinguish
        % between MOS and VNS events
        VNS_odor_events = strmatch('odor applied',all_etypes,'exact');
        VNS_odor_names = all_enames(VNS_odor_events);

        all_odor_events = strmatch('odor suction',all_etypes,'exact');
        all_odor_names = all_enames(all_odor_events);

        MOS_odor_events = all_odor_events(strmatch('*MOS*',all_odor_names));
        MOS_odor_names = all_enames(MOS_odor_events);
                
        inhale_odor_events = all_odor_events(strmatch('inhale',all_odor_names));
        inhale_odor_names = all_enames(inhale_odor_events);

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% adding NPD inhale
        inhale_NPD_events = all_odor_events(strmatch('NPD inhale',all_odor_names)); %%this is to capture the NPD inhale events for the MOB recordings
        inhale_NPD_names = all_enames(inhale_NPD_events);

        inhale_odor_events=union(inhale_odor_events,inhale_NPD_events)
        inhale_odor_names=union(inhale_odor_names,inhale_NPD_names)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
       
        odor_events = union(VNS_odor_events,all_odor_events);
        odor_names = all_enames(odor_events);
        for i = 1:length(odor_events)
            
            if ismember(odor_events(i),VNS_odor_events)
                event_type(i) = 1; % 1 is for VNS
            elseif ismember(odor_events(i),MOS_odor_events)
                event_type(i) = 2; % 2 is for MOS
            elseif ismember(odor_events(i),inhale_odor_events)
                event_type(i) = 4; % 4 is for inhale

            end
        end
        %%Above this is where I need to add #4 for the inhale stimuli
        
end
        






stimon_events = strmatch('stimulation',all_etypes,'exact');
stimoff_events = strmatch('stimulation off',all_etypes,'exact');
start_clean = strmatch('start clean',all_etypes,'exact');
stop_clean = strmatch('stop clean',all_etypes,'exact');
suction_events = strmatch('one air pulse',all_etypes);




% NOw we start building the sequences associated with each trial
for i = 1:length(odor_events)

    oe = odor_events(i);

    
    
    
    
    % The odor applied events, time and block for the ith trial
    E_t(i) = all_etimes(oe);
    E_b(i) = all_blocks(oe);

    % If this is a VNS event
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



        % a combined event
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
        Coff = stop_clean(min(find(stop_clean > Cs2off)))
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
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    elseif event_type(i) == 4
               
        Inhale_t(i) = all_etimes(oe);
        Inhale_b(i) = all_blocks(oe);

        
%%%%disp('inhale #4')
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
