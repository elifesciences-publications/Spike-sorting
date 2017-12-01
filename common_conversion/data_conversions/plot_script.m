function plot_script(NoSort,expdate,session,do_groups,units,combine,psth_event,Tb,Ta)
% Plotting the data - and initial script
% e.g. psth_event = 'stim_on'

% Time before, and time after stimulation - in seconds
SR = 24414;
% Tb = 60;
% Ta = 30;

[datadir,combined_datadir,blocks,PC_block,groups,maxSN] = get_session_info(expdate,session);

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

% Get spike time data
if NoSort % UNSORTED DATA - PER CHANNEL
    [spiketimes spikeclass units] = read_spikes_times_per_channel(combined_datadir);
    PO = [1 7 13 14 3 4 10 16 2 8 12 11 6 5 9 15]; % This is the order to plot 16 channels so that they retain spatial position in subplot
    PO2 = [1 3 2 6 7 4 8 5 13 10 12 9 14 16 11 15]; % This is the order when plotting an imagesc, i..e one dimension corresponding to chanels - like in neuroscope
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
            tmp_prev_ev_inds = [];
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


% Create matrices with spike counts per trial
BinSize = 0.5;

% Per trial and per unit images
make_per_units_displays(sstring,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO2,block_tag);
make_per_trial_displays(sstring,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,PO,block_tag);

% DD is seperate figures
PSTH = 0;
DD = 1;
for u = 1:length(units)
    figure
    if NoSort
        tu = units(u);
    else
        tu = find(units == units(u));
    end
    set(gcf,'name',['channel ' num2str(units(u))],'numbertitle','off')
    ah = axes;
    plot_spikes(spike_times{tu},spike_trials{tu},[-Tb Ta],event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,[num2str(units(u)) sstring],block_tag,totntrials,DD,PSTH,[ah],1);
end
  
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







