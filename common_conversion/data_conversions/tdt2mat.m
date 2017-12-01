function TDT2MAT


% Variables needed to upsample certain events
%upsample_events{1} = 'hart';
%upsample_events{2} = 'brth';
%upsample_vals(1) = 2;
%upsample_vals(2) = 128;
upsample_events = '';

FIRST_TIME = 1;

% The first section of code selects which tank, block, and event to access.
% first three variables are session specific, the last two are not.
% outdir = 'D:\may04_05\matlab converted test\';
outdir = 'D:\20july05\mat\';

tankname   = 'tank20july05'; % set this to the name of your tank
% blocknames{1}  = 'Block-1'; % set this to the block you want to read from (case-sensitive!)
servername = 'Local'; % change this if you are not using a Local server
clientname = 'myclient'; % change this if you are not using a Local server
% The next section of code initializes the ActiveX control, connects to the server, opens the tank, and selects the block to read.
ttank = actxcontrol('ttank.x', [1 1 1 1]);
if (invoke(ttank, 'ConnectServer', 'Local', 'myclient') ~= 1); err = 'error connecting to server'; end
if (invoke(ttank, 'OpenTank', tankname, 'r') ~= 1);            err = 'error opening tank'; end

blocknames{1} = 'Block-4';

% Inform the user of all blocks names
if ~exist('blocknames')
    done = 0;
    k = 0;
    while ~done
        b= invoke(ttank,'QueryBlockName',k+1);
        if b
            blocknames{k+1} = b;
            k = k + 1;
        else
            done = 1;
        end
    end
    msgstr = blocknames;
    msgstr{length(blocknames) + 1} = 'Process all these blocks ?';
    ButtonName=questdlg(msgstr ,'Select blocks for conversion','OK','No','OK');
    switch   ButtonName
        case 'OK' % just continue
        case 'No'
            msgbox('Then edit the file getTANKdata and select which blocks to include' );
            % After all the events have been read, the code is finished. It cleans up by releasing the server.
            invoke(ttank, 'CloseTank')
            invoke(ttank, 'ReleaseServer');
            return
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Now, run over all blocks

for bi = 1:length(blocknames)
    % for bi = 1:1    %   For debugging ofcourse
    % The events and chunksize variables are important and may need to
    % be tuned.


    % Select that block
    if (invoke(ttank, 'SelectBlock', blocknames{bi}) ~= 1); err = 'error selecting block'  ;end
    % Let the user know about the events in it
    if FIRST_TIME
        display_channel_event_list;
        FIRST_TIME = 0;
    end

    for evni = 1:length(enames) % event names and channel numbers are obtained in display_channel_event_list script.
        eventname = enames{evni};
        channel_numbers = nchans(evni);
        if ~channel_numbers
            ev_type = 0; % Discrete event
            channel_numbers = 1; %(otherwise it would not run the loop)
        else
            ev_type = 1; % waveform
        end

        for i = 1:channel_numbers % this should work, since the channel numbers for
            data = [];
            count = 0;
            % events are 0.
            disp(['Converting block ' blocknames{bi} ' event ' eventname  ' channel ' num2str(i)]);
            chunksize = 1000000; % YBS
            events = 1000000; % YBS
            whilecount = 0;
            while (events == chunksize)
                % while count <= 100
                % reads up to 200 events from the tank. currently reads all channels, but
                % could be changed to only read from one specific channel.
                if ~count
                    mode = 'ALL';
                else
                    mode = 'NEW';
                end
                if ~ev_type % An ungly way, but I must have a channel designation of 0 to get some data from scalar events
                    events = invoke(ttank, 'ReadEventsV', chunksize, eventname,0, 0, 0, 0, mode);
                else
                    events = invoke(ttank, 'ReadEventsV', chunksize, eventname,i, 0, 0, 0, mode);
                end

                % extracts the data points from the events that were read
                newdata = invoke(ttank, 'ParseEvV', 0, events);
                % extracts the channel numbers from the events that were read
                % channels = invoke(ttank, 'ParseEvInfoV', 0, events, 4);
                % extracts the timestamps freom the events that were read
                timestamps = invoke(ttank, 'ParseEvInfoV', 0, events, 6);
                if ~ev_type % If it is an event rather than a waveform
                    %  timestamps = invoke(ttank, 'ParseEvInfoV', 0, events, 6);
                    newdata = [newdata ; timestamps];
                end
                % concatenates this chunk of data onto the previously saved data
                % chunk = cat(2, channels', timestamps', newdata');
                data = cat(2, data, newdata);
                count = count+1;
                if ~whilecount
                    all_timestamps{evni,i} = timestamps;
                end
                whilecount = whilecount + 1;
            end
            fulloutdir = [outdir blocknames{bi} filesep];
            if ~isdir(fulloutdir)
                mkdir(fulloutdir);
            end
            outname = [fulloutdir blocknames{bi} '_' eventname '_chan_'  num2str(i)];
            % uchan   = unique(channels);
            if ev_type
                data       = reshape(data,1,prod(size(data)));
            else
                data       = reshape(data,2,prod(size(data))/2);
            end

            % If resampling is required, this is where we do it
            I = strmatch(eventname,upsample_events);
            if ~isempty(I)
                sample_factor = upsample_vals(I);
                data = my_upsample(data,sample_factor);
            end

            varname = [eventname '_' num2str(i)];
            eval([ varname ' = data;']);
            save(outname,varname);

            clear data;
            eval(['clear ' , varname]);

        end
    end
end
% After all the events have been read, the code is finished. It cleans up by releasing the server.
invoke(ttank, 'CloseTank')
invoke(ttank, 'ReleaseServer')

