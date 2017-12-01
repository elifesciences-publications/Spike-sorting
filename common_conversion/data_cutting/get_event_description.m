function [stimodor, stimnum] = get_event_description(etypes,enames,etimes);
% Accepts cells containing the event names, event times and even types, and
% for every stimulation event returns the preceeding odor present in the -
% stim num returns the serial number of the stimulation following odorant
% application



for i = 1:length(enames)
    for k = 1:length(enames{i})
        stimodor{i}{k} = [];
        stimnum{i}(k) = 0;
    end
end


for i = 1:length(enames)
 
    thesetypes = etypes{i};
    thesenames = enames{i};
    thesetimes = etimes{i};

    % fins those that are stimulations
    stim_events = strmatch('stimulation',thesetypes,'exact');
    % those that are odor applications
    odor_events = strmatch('odor',thesetypes);

    % Go over each odor_event
    for j = 1:length(odor_events)
        thistime = thesetimes(odor_events(j));
        thisname = thesenames{odor_events(j)};
        if j < length(odor_events)
            nexttime = thesetimes(odor_events(j+1));
        else
            nexttime = inf;
        end
        sc = 1;
        for k = 1:length(stim_events)
            if thesetimes(stim_events(k)) > thistime & thesetimes(stim_events(k)) < nexttime
                stimodor{i}{stim_events(k)} = [thisname];
                stimnum{i}(stim_events(k)) = sc;
                sc = sc + 1;
            end
        end
    end
end

% Just for displaying the results
% for i = 1:length(enames)
%     for j = 1:length(enames{i})
%         disp([enames{i}{j} ' ' stimodor{i}{j} ' ' num2str(stimnum{i}(k))])
%     end
% end


% 
return