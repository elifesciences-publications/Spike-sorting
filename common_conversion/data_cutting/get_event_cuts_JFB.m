function [etimes, enames, etype, Events] =  get_Event_cuts_JFB(expdate,datadir,blocks);
% Get event times, types and their names, this involves reading both the TDT evt files and the log files created by the MATLAB behavioral interface
global call_process_params



% Get Event Data
Events = [];
for bi = 1:length(blocks)
    [etimes{bi} enames{bi}]  = read_Event_times(datadir,blocks(bi)); % Read the Event times - this is for reading from the ASCII file, since I
    Events = union(Events,unique(enames{bi}));
end

log_file=call_process_params.exp_log_file;


load(log_file);
for i = 1:length(log_data)
    log_codes(i) = log_data(i).EvSynch;
end

% Find all the synchronization codes
k = 1;
for bi = 1:length(blocks)
     % find synchronization code Events
     I = strmatch('evsn',enames{bi}); 
     for j = 1:length(I)
         % Find the actual code number
         usp = findstr('_',enames{bi}{I(j)});
         Scodes(k) = str2num(enames{bi}{I(j)}(usp(2)+1:end));

         if k > 1 % This block is required to fix some problems with updating the synch value in earlier versions of the log file script. 
             if ~(Scodes(k) > Scodes(k-1))
                 Scodes(k) = Scodes(k-1) + 1;
             end
         end
                 
         Event_synch_code{bi}(j) = Scodes(k); 
         Event_time{bi}(j)       = etimes{bi}(I(j)); % Event time as given by TDT system

         % Find the corresponding code in the log file
         tc = find(log_codes == Scodes(k));
    
         Eventtype{bi}{j} = log_data(tc).what_happened; % stimulation, odor presentation, comment, etc ...
         Eventname{bi}{j} = log_data(tc).event_name;    % specific description of Event
         Eventcode{bi}{j} = log_data(tc).event_code;    % code of Event - no longer used reall;y
         
         % Stimulation and cleaning Events have no name, so their name is like their type
         if isempty(Eventname{bi}{j}) 
           Eventname{bi}{j} =   Eventtype{bi}{j};
         end
         
         k = k + 1;
     end
     
     % The stim_off Event is not synchronized (only TDT reports it and not
     % MATLAB) and so should be detected regardless of a synchronization
     % code
     I2 = strmatch('stim off',enames{bi});
     for l = 1:length(I2)
         Event_time{bi}(l+j) = etimes{bi}(I2(l));
         Eventtype{bi}{l+j} = 'stimulation off';;
         Eventname{bi}{l+j} = 'stimulation off';
         Eventcode{bi}{l+j} = [];                 
     end         
end
   

% Rename and sort the Events 
Events = [];
for bi = 1:length(blocks)
    etimes{bi} = Event_time{bi};
    enames{bi} = Eventname{bi};
    etype{bi}  = Eventtype{bi};
    
    [etimes{bi} ind] = sort(etimes{bi});    
    enames{bi}   = enames{bi}(ind);
    etype{bi}    = etype{bi}(ind);
    
    Events = union(Events,unique(enames{bi}));    
end




