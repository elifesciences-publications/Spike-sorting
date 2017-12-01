function [odor_events,odor_names,event_type]  =   YBS_find_odor_events(expdate,all_etypes,all_enames);

odor_events = [];
odor_names = [];
event_type = [];

%%%%%%%%


switch expdate
    
    % Later on we did only MOS or VNS but there were some errors in
    % reporting to TDT
    case {'15may09','20may09'}
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
    case {'14apr09','10apr09','07apr09','03apr09'}
        odor_events = strmatch('odor applied',all_etypes,'exact');
        event_type = 3 * ones(1,length(odor_events));
        odor_names = all_enames(odor_events);
        
        % During earlier session we had both the VNS and the MOS stim in each
    case {'26may09_test','27may09','04jun09','18jun09','11jun09','23jun09','30jun09','15jul09','20aug09','01sep09','02sep09','04sep09'...
            '08sep09','09sep09','29sep09','01oct09','09mar10','11mar10'}
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
    case {'18mar10','23mar10','01apr10','05apr10','08apr10','09apr10'}
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
                event_type(i) = 1;   % 1 is for VNS
            else
                event_type(i) = 2.5; % 2 is for MOS
            end
        end
        
        
        
        % Both VNS and MOS, but the MOS does no longer have a clean period
        % and now the VNS has only one clean stimulation
    case {'14apr10','16apr10','22apr10','23apr10','30apr10'}
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
        
        
    case {'20oct09','23oct09','27oct09','28oct09','10nov09','11nov09','17nov09','18nov09','19nov09','20nov09'}
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
        
end

