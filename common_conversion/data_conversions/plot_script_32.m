function plot_script_32(NoSort,DO_DD,expdate,session,do_groups,units,combine,psth_event,Tb,Ta,Blocks);
% e.g. plot_script_32(1,1,'29aug06',1,'all','all',0,'stimulation',20,30)

DO_RESPONSES = 1;
DO_IMAGES = 0;
SHOW_IND = 1;
DO_DD = 1;


% Time before, and time after stimulation - in seconds
SR = 24414;

[datadir,combined_datadir,blocks,PC_block,groups,maxSN] = get_session_info(expdate,session);

% We can also select to do only one block
if exist('Blocks') == 1
    blocks = Blocks;
    SHOW_IND = 0; % The whole point of showing a single block is to see all the units together.
end

sstring = ['(' expdate '-s' num2str(session) ')'];
if ischar(do_groups)
    if strcmp(do_groups,'all')
        do_groups = 1:length(groups);
    end
end
% Get Event Data
events = [];
for bi = 1:length(blocks)
    [etimes{bi} enames{bi}]  = read_event_times(datadir,blocks(bi)); % Read the event times - this is for reading from the ASCII file, since I
    events = union(events,unique(enames{bi}));
end
% Get the corresponding data file and find the matches


global GLBL_WHICH_PC;
switch GLBL_WHICH_PC
    case 'LAPTOP'
        log_file = ['c:\DATA\exp_log_files\' expdate(1:2) '-' expdate(3:5) '-20' expdate(6:7) '_log.mat'];
    otherwise
        log_file = ['c:\exp_log_files\' expdate(1:2) '-' expdate(3:5) '-20' expdate(6:7) '_log.mat'];
end




load(log_file);
for i = 1:length(log_data)
    log_codes(i) = log_data(i).EvSynch;
end
% Find all the synchronization codes
k = 1;
for bi = 1:length(blocks)
     I = strmatch('evsn',enames{bi});
     for j = 1:length(I)
         %disp(enames{bi}{I(j)})
         usp = findstr('_',enames{bi}{I(j)});
         Scodes(k) = str2num(enames{bi}{I(j)}(usp(2)+1:end));

         if k > 1 % This block is required to fix some problems with updating the synch value in earlier versions of the log file script. 
             if ~(Scodes(k) > Scodes(k-1))
                 Scodes(k) = Scodes(k-1) + 1;
             end
         end
         
         %disp(Scode)
         Event_synch_code{bi}(j) = Scodes(k);
         Event_time{bi}(j) = etimes{bi}(I(j));
         % Find the corresponding 
         tc = find(log_codes == Scodes(k));
         %disp(tc);
         %disp('  --   ')
         Eventtype{bi}{j} = log_data(tc).what_happened;
         Eventname{bi}{j} = log_data(tc).event_name;
         Eventcode{bi}{j} = log_data(tc).event_code;
         
         if isempty(Eventname{bi}{j}) % Stimulation events have no name, but still need to be considered
           Eventname{bi}{j} =   Eventtype{bi}{j};
         end
         
         k = k + 1;
     end
     
     % The stim_off event is not synchronized (only TDT reports it and not MATLAB) and so should be detected
     % seperately 
     I2 = strmatch('stim off',enames{bi});
     for l = 1:length(I2)
         Event_time{bi}(l+j) = etimes{bi}(I2(l));
         Eventtype{bi}{l+j} = 'stimulation off';;
         Eventname{bi}{l+j} = 'stimulation off';
         Eventcode{bi}{l+j} = [];                 
     end         
end
    
% Filter the log file events for those that have a name (unlike a comment or a stim)
% Get Event Data
events = [];
for bi = 1:length(blocks)
    etimes{bi} = Event_time{bi};
    enames{bi} = Eventname{bi};
    
    [etimes{bi} ind] = sort(etimes{bi});
    enames{bi} = enames{bi}(ind);
    
    events = union(events,unique(enames{bi}));
end

% Get spike time data
if NoSort % UNSORTED DATA - PER CHANNEL
    [spiketimes spikeclass units] = read_spikes_times_per_channel(combined_datadir);
    
    PO = 1:length(units);
    PO2 = PO;
else
    unit_list = [];
    for bi = 1:length(blocks)
        [spiketimes{bi} spikeclass{bi}] = read_spikes_times(datadir,blocks(bi),groups,do_groups,SR);
        unit_list  = union(unit_list,unique(spikeclass{bi}));
    end
    % IF units is 'all' - take all units, otherwise take units explicitly given
    if ischar(units)
        if strcmp(units,'all')
            units = unit_list;
        end
    end
end

% Get time of psth_event occurence
for bi = 1:length(blocks)
    theseinds = strmatch(psth_event,enames{bi},'exact');
    thesetimes{bi} = etimes{bi}(theseinds);
    ntrials(bi) = length(thesetimes{bi});
end
CutTimes = thesetimes;
totntrials = sum(ntrials); 
   
% Get time of end psth_event occurence 
found_end_event = 0;
end_psth_event = 'stimulation off';
for bi = 1:length(blocks)
    theseindsEND = strmatch(end_psth_event,enames{bi},'exact');
    thesetimesEND{bi} = etimes{bi}(theseindsEND);
    ntrialsEND(bi) = length(thesetimes{bi});
    if ~isempty(theseindsEND)
        found_end_event = 1;
    end
end
CutTimesEND = thesetimesEND;
totntrialsEND = sum(ntrialsEND); 


% If we have a corresponding stim off for every stims on
% we can clean any spikes that are actually stimulation artifacts
if found_end_event % Not all days logged the stimulation off event
    for bi = 1:length(blocks)
        if ntrialsEND(bi) == ntrials(bi)
            for j = 1:ntrials(bi)
                badspikes = spiketimes{bi} > CutTimes{bi}(j) & spiketimes{bi} < CutTimesEND{bi}(j);
                spiketimes{bi}(badspikes) = [];
                spikeclass{bi}(badspikes) = [];
            end
        end
    end
end


% Initialize the spike times and corrsponding trials
for u = 1:length(units)
    spike_times{u} = [];  spike_trials{u} = [];
end

% Retrieve spike data within segments
event_times =  [];
event_trials = [];
event_names =  [];
prev_event_times =  [];
prev_event_trials = [];
prev_event_names =  [];

k = 1;
for bi = 1:length(blocks)
    for j = 1:length(thesetimes{bi})        
        for u = 1:length(units) % spike data
            this_unit = units(u);
            thesespiketimes = spiketimes{bi}(find(spikeclass{bi} == this_unit));
            % get spikes falling within data segments
            inds = find(thesespiketimes >= thesetimes{bi}(j) - Tb & thesespiketimes <= thesetimes{bi}(j) + Ta);
            spike_times{u} = [spike_times{u} ; thesespiketimes(inds) - thesetimes{bi}(j)];
            spike_trials{u} = [spike_trials{u} ; k * ones(size(inds))];
        end
        tmp_ev_inds  = find(etimes{bi} >= thesetimes{bi}(j) - Tb & etimes{bi} <= thesetimes{bi}(j) + Ta);
        event_names  = [event_names enames{bi}(tmp_ev_inds)];
        event_times  = [event_times etimes{bi}(tmp_ev_inds) - thesetimes{bi}(j)];
        event_trials = [event_trials k * ones(size(tmp_ev_inds))];

        % Get events falling between end of previous data segment and
        % beginning of this one
        if j > 1
            tmp_prev_ev_inds = find(etimes{bi} > thesetimes{bi}(j-1) + Ta & etimes{bi} < thesetimes{bi}(j) - Tb);
            overlap(k) = (thesetimes{bi}(j) - Tb) - (thesetimes{bi}(j-1) + Ta);
        else
            % Sometimes we get an initial "psuedo cleaning" event that
            % occurs immedialtey, this is not real.
            tmp_prev_ev_inds = find(etimes{bi} < thesetimes{bi}(j) - Tb & etimes{bi} > 1);
            overlap(k) = nan;
        end
        prev_event_names  = [prev_event_names enames{bi}(tmp_prev_ev_inds)];
        prev_event_times = [prev_event_times etimes{bi}(tmp_prev_ev_inds) - thesetimes{bi}(j)];
        prev_event_trials = [prev_event_trials k * ones(size(tmp_prev_ev_inds))];        
        
                    
        block_tag(k) = blocks(bi); % KEEP A TAG ON WHICH TRIAL EACH BLOCK COMES FROM
        k = k + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%% DONE RETRIEVING DATA %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This function significantly reduced length of event names and makes them
% visible in the display therefore
event_names = shorten_event_names(event_names);
prev_event_names = shorten_event_names(prev_event_names);


BinSize = 0.5; %0.5;
MaxRate = 50 * BinSize; % 50
%%calculate_responses(MaxRate,sstring,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,blocks,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO2,block_tag);
%%%%%%%%%%


method =  'minus baseline';
%method = 'minus baseline norm';
%method = 'raw';
%%make_image_response_plot(method,sstring,spike_trials,spike_times,Tb,Ta,CutTimes,blocks,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO2,block_tag);
%%if DO_RESPONSES
    make_bar_response_plot(method,sstring,spike_trials,spike_times,Tb,Ta,CutTimes,blocks,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO2,block_tag);
%%end


return

% Create matrices with spike counts per trial
BinSize = 0.5; %0.5;
MaxRate = 50 * BinSize; % 50
calculate_responses(MaxRate,sstring,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,blocks,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO2,block_tag);
% Per trial and per unit images

if DO_IMAGES
    make_per_units_displays(MaxRate,sstring,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,blocks,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO2,block_tag,SHOW_IND);
end


% DD is seperate figures
DO_DD = 1;
if DO_DD
    PSTH = 0;
    DD = 1;
    for u = 1:length(units)
        figure
%         if NoSort
%             tu = units(u);
%         else
%             tu = find(units == units(u));
%         end
        set(gcf,'name',['channel ' num2str(units(u))],'numbertitle','off')
        set(gcf,'paperorientation','landscape')
        ah = axes;
        plot_spikes(spike_times{u},spike_trials{u},[-Tb Ta],event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,[num2str(units(u)) sstring],block_tag,totntrials,DD,PSTH,[ah],1);
        %plot_spikes3(2,spike_times{u},spike_trials{u},[-Tb Ta],event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,[num2str(units(u)) sstring],block_tag,totntrials,DD,PSTH,[ah],1);
    end
end

return

% For stereo
% C1 = 5;
% C2 = 15;
% PSTH = 0;
% DD = 1;
% figure
% if NoSort
%     tu1 = units(C1);
%     tu2 = units(C2);
% else
%     tu1 = find(units == units(C1));
%     tu2 = find(units == units(C2));
% end
% set(gcf,'name',['channel ' num2str(units(C1)) ' and ' num2str(units(C2))],'numbertitle','off')
% set(gcf,'paperorientation','landscape')
% ah = axes;
% plot_spikes_stereo(spike_times{tu1},spike_trials{tu1},spike_times{tu2},spike_trials{tu2},[-Tb Ta],event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,[num2str(units(C1)) '+' num2str(units(C2)) ' ' sstring],block_tag,totntrials,DD,PSTH,[ah],1);



return


% For PSTHs
% SEND DATA TO PLOTTING FUNCTION
% DD = 0;
% PSTH = 1;
% fh1 = figure;
% 
% % SORT THEM ACCORDING TO PLOT ORDER
% if NoSort
%     units = PO;
% end
% % Do the PSTHs in one figure
% [Cs Rs] = best_subplot_dims(length(units));
% figure(fh1)
% maxYscale = 0;
% for u = 1:length(units)
%     %figure(fh1)
%     ah(u) = subplot(Cs,Rs,u);
%     if NoSort
%         tu = units(u);
%     else
%         tu = u;
%     end 
%     plot_spikes(spike_times{tu},spike_trials{tu},[-Tb Ta],event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,[num2str(units(u)) sstring ],block_tag,totntrials,DD,PSTH,[0 ah(u)],0);
%     maxYscale = max([maxYscale get(gca,'ylim')]);
% end
% SAME_Y_SCALE = 1;
% maxYscale = min([50 maxYscale]); % correcting a stupid matlab behavior for a specific case
% if SAME_Y_SCALE
%     set(ah,'ylim',[0 maxYscale],'ytick',[0:10:maxYscale])
% end




% THIS IS FOR COMBINING DATA ACROSS UNITS - this is a bad solution however, it makes mroe sense to do this in the previous
% step, while retrieving spike data - and by designating units not as
% scalars, but as vectors - so the list of units will be a cell array of
% vectors.
% else % HERE - WE COMBINE ALL UNITS IN THE LIST - NOTE HOWEVER THAT THIS IS ONLY APPROPRIATE FOR A SMALL NUMBER OF UNITS
%     comb_spike_trials = [];
%     comb_spike_times  = [];
%     titstr = [];
%     for u = 1:length(units)
%         comb_spike_times = [comb_spike_times ; spike_times{u}];
%         comb_spike_trials = [comb_spike_trials ; spike_trials{u}];
%         titstr = [titstr ' ' num2str(units(u))];
%     end
%     plot_spikes(comb_spike_times,comb_spike_trials,event_times,event_trials,event_names,titstr,block_tag,totntrials);
% end







