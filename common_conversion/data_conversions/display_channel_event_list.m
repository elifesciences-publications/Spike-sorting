%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% display the list of events in the block (see the help for the tdt
% functions in OpenDeveloper)
tmp_chunksize = 1;
traces = invoke(ttank, 'GetEventCodes', 0);
for i = 1:length(traces)
    event_names{i} = invoke(ttank,'CodeToString',traces(i));
end


for i = 1:length(traces)
        tmp_events = invoke(ttank, 'ReadEventsV', tmp_chunksize, event_names{i},0, 0, 0, 0, 'ALL');        
        % extracts the channel numbers from the events that were read
        data = invoke(ttank, 'ParseEvInfoV', 0, tmp_events, 0); 
        % See help for ParseEvInfoV for explanation of the data structure.
%         switch data(2)
%             case 33025
%                 type = 'contin';
%             case 257
%                 type = 'scalar';
%             otherwise
%                 type = '????'
%         end
        type = invoke(ttank,'EvTypeToString',data(2));
        enames{i}  = invoke(ttank,'CodeToString',data(3));                
        nchans(i) = data(4);
        msgstr{i} = ([enames{i} '(' type ') | SR: ' num2str(data(9)) ' block size: ' num2str(data(1)) ' nchan: ' num2str(data(4))]);        
end
msgstr{i+1} = 'Select all channels in all contin waveforms and all events into files ?';
ButtonName=questdlg(msgstr,'Select channels for conversion','OK','No','OK');                   
switch   ButtonName
    case 'OK' % just continue
    case 'No'
        msgbox('Then edit the file getTANKdata and select which waveforms/channels/5events to include' ); 
        % After all the events have been read, the code is finished. It cleans up by releasing the server.
        invoke(ttank, 'CloseTank')
        invoke(ttank, 'ReleaseServer');
        return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%