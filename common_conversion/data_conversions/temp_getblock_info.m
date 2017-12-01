
% See the help for the tdt functions in OpenDeveloper
chunksize = 1;
traces = invoke(ttank, 'GetEventCodes', 0);
for i = 1:length(traces)
        events = invoke(ttank, 'ReadEventsV', chunksize, event_name{i},0, 0, 0, 0, 'ALL');        
        % extracts the channel numbers from the events that were read
        data = invoke(ttank, 'ParseEvInfoV', 0, events, 0); 
        % See help for ParseEvInfoV for explanation of the data structure.
        switch data(2)
            case 33025
                type = 'contin';
            case 257
                type = 'scalar';
            otherwise
                type = '????'
        end
        ename = invoke(ttank,'CodeToString',data(3));        
        disp([ename '(' type ') | SR: ' num2str(data(9)) ' block size: ' num2str(data(1)) ' nchan: ' num2str(data(4))]);
end

