function [odor_events,odor_names,event_type]  =   JFB_find_odor_events(expdate,all_etypes,all_enames);

odor_events = [];
odor_names = [];
event_type = [];

%%%%%%%%
switch lower(expdate)
    
    % Later on we did only MOS or VNS but there were some errors in
    % reporting to TDT
     % Later on we did only MOS or VNS but there were some errors in
    % reporting to TDT
    case {''}
        % Get times of all event types - in this version we have to distinguish
        % between MOS and VNS events
        VNS_odor_events = strmatch('odor applied',all_etypes,'exact');
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
    case {''}
        odor_events = strmatch('odor applied',all_etypes,'exact');
        event_type = 3 * ones(1,length(odor_events));
        odor_names = all_enames(odor_events);
        
        % During earlier session we had both the VNS and the MOS stim in each
    case {''}
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
        
        
        % Both VNS and MOS, but the MOS does no longer have a clean period
    case {''}
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
                event_type(i) = 2.5; % 2 is for MOS
            end
        end
        
        
        
        % Both VNS and MOS, but the MOS does no longer have a clean period
        % and now the VNS has only one clean stimulation
    case {''}
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
                event_type(i) = 1.5; % 1 is for VNS with one clean
            else
                event_type(i) = 2.5; % 2 is for MOS without clean
            end
        end
        
        
    case {''}
        % Get times of all event types - in this version we have to distinguish
        % between MOS and VNS events
        VNS_odor_events = strmatch('odor applied',all_etypes,'exact');
        VNS_odor_names = all_enames(VNS_odor_events);
        
        % MOS_odor_events = strmatch('odor suction',all_etypes,'exact');
        MOS_odor_events = strmatch('odor suction',all_etypes,'exact');
        MOS_odor_names = all_enames(MOS_odor_events);
        
        odor_events = union(VNS_odor_events,MOS_odor_events);
        odor_names = all_enames(odor_events);
        for i = 1:length(odor_events)
            event_type(i) = 4; % 4 is for MOS with inhalation only
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
        
        inhale_odor_events=union(inhale_odor_events,inhale_NPD_events);
        inhale_odor_names=union(inhale_odor_names,inhale_NPD_names);
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




