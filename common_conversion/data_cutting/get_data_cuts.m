function get_data_cuts(UnSorted,expdate,session,CutEvent,Tb,Ta);
% example: get_data_cuts(1,'05oct06',1,'stimulation',30,30)


global GLBL_WHICH_PC;

% Do not return enything, just save the result

% based on 
% plot_script_32(UnSorted,DO_DD,expdate,session,do_groups,units,combine,CutEvent,Tb,Ta,Blocks);
% e.g. plot_script_32(1,1,'29aug06',1,'all','all',0,'stimulation',20,30)

% Construct the session string
sstring = ['(' expdate '-s' num2str(session) ')'];

% A flag denoting whetehr to delete all spikes that occur between start of
% stimulation and end of stimulation - this is only possible if that day
% included a stimulation off Event
purge_spikes_during_stimulation = 1;
StartStimEvent = 'stimulation';
EndStimEvent = 'stimulation off';

SR =  2.441406250000000e+004;
% Get information pertaining to session
[datadir,combined_datadir,blocks,PC_block,groups,maxSN] = get_session_info(expdate,session);
% Leave this line unless analyzing only a subset of groups
do_groups = 1:length(groups);


switch GLBL_WHICH_PC
    case 'LAPTOP'
        basepath = 'C:\DATA\';
    otherwise
        basepath = 'c:\';
end
        
if UnSorted
    outfname = [basepath 'CutData\cutdata_' CutEvent '_' num2str(Tb) '_' num2str(Ta) '_' sstring '_unsorted'];
else
    outfname = [basepath 'CutData\cutdata_' CutEvent '_' num2str(Tb) '_' num2str(Ta) '_' sstring '_sorted'];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% get Event data 
[etimes, enames, etypes, Events] =  get_Event_cuts(expdate,datadir,blocks);
[stimodor, stimnum] = get_event_description(etypes,enames,etimes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Get spike time data
if UnSorted  % Then we load the results of the detection step and get MUA - and potentially same spikes across close channels 
    %[spiketimes spikeclass units] = read_spikes_times_per_channel(combined_datadir);
    [spiketimes spikeclass units] = read_spikes_times_per_channel_2(combined_datadir);    
else
    [spiketimes spikeclass units] =  read_offline_spike_times(expdate,session,SR);
    
%     
%     unit_list = [];
%     for bi = 1:length(blocks)
%         [spiketimes{bi} spikeclass{bi}] = read_spikes_times(datadir,blocks(bi),groups,do_groups,SR);
%         unit_list  = union(unit_list,unique(spikeclass{bi}));
%     end
%     % Take all units, otherwise take units explicitly given
%     units = unit_list;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Get time of CutEvent occurence
if ~strcmp(CutEvent,'odor applied') % There is no such Event name really, this is an Event type
    for bi = 1:length(blocks)
        theseinds = strmatch(CutEvent,enames{bi},'exact');
        CutTimes{bi} = etimes{bi}(theseinds);
        ntrials(bi) = length(CutTimes{bi});
        CUT_Event_names{bi} = enames{bi}(theseinds); % required because here we cut all odor appication Events
        CUT_Event_stimodor{bi} = stimodor{bi}(theseinds);
        CUT_Event_stimnum{bi}  = stimnum{bi}(theseinds);

    end
    totntrials = sum(ntrials);
else
    for bi = 1:length(blocks)
        theseinds       = strmatch(CutEvent,etypes{bi},'exact');
        CutTimes{bi}  = etimes{bi}(theseinds);
        CUT_Event_names{bi} = enames{bi}(theseinds); % required because here we cut all odor appication Events
        CUT_Event_stimodor{bi} = stimodor{bi}(theseinds);
        CUT_Event_stimnum{bi}  = stimnum{bi}(theseinds);
        ntrials(bi) = length(CutTimes{bi});
    end
    totntrials = sum(ntrials);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Get time of StartStimEvent occurence
for bi = 1:length(blocks)
    theseinds       = strmatch(StartStimEvent,etypes{bi},'exact');
    SS_Times{bi}  = etimes{bi}(theseinds);
    ntrialsStart(bi) = length(SS_Times{bi});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if purge_spikes_during_stimulation
    % Get time of EndStimEvent occurence
    found_end_Event = 0;  
    for bi = 1:length(blocks)
        theseindsEND = strmatch(EndStimEvent,enames{bi},'exact');
        SE_TimesEND{bi} = etimes{bi}(theseindsEND);
        ntrialsEND(bi) = length(SE_TimesEND{bi});
        if ~isempty(theseindsEND)
            found_EndStim_Event = 1;
        end
    end
    totntrialsEND = sum(ntrialsEND);
    % If we have a corresponding stim off for every stims on
    % we can clean any spikes that are actually stimulation artifacts
    if found_EndStim_Event % Not all days logged the stimulation off Event
        for bi = 1:length(blocks)
            if ntrialsEND(bi) == ntrialsStart(bi)
                for j = 1:ntrialsStart(bi)
                    badspikes = spiketimes{bi} > SS_Times{bi}(j) & spiketimes{bi} < SE_TimesEND{bi}(j);
                    disp(['excluded a section of ' num2str(SE_TimesEND{bi}(j) - SS_Times{bi}(j)) ' seconds ' ]);
                    spiketimes{bi}(badspikes) = [];
                    spikeclass{bi}(badspikes) = [];
                end
            end
        end
    end
end



% Get cut data
% Initialize the spike times and corrsponding trials
for u = 1:length(units)
    spike_times{u} = [];  spike_trials{u} = [];
end
Event_times =  [];
Event_trials = [];
Event_names =  [];
Event_types  = [];        

% These are Events that are not within the cut segments, (but are obviously
% important too).
prev_Event_times =  [];
prev_Event_trials = [];
prev_Event_names =  [];
prev_Event_types  = [];        

k = 1;
for bi = 1:length(blocks)
    for j = 1:length(CutTimes{bi})        
        
        % Spike times within each segment
        for u = 1:length(units) 
            this_unit = units(u);
            thesespiketimes = spiketimes{bi}(find(spikeclass{bi} == this_unit));
            % get spikes falling within data segments
            inds = find(thesespiketimes >= CutTimes{bi}(j) - Tb & thesespiketimes <= CutTimes{bi}(j) + Ta);
            % This results in spike times being specified relative to
            % segment cut time 
            spike_times{u} = [spike_times{u} ; thesespiketimes(inds) - CutTimes{bi}(j)];
            % And all these spikes are denoted as belonging to this cut (not very economical I guess)
            spike_trials{u} = [spike_trials{u} ; k * ones(size(inds))];
        end
        
        % Even times within each segments
        tmp_ev_inds  = find(etimes{bi} >= CutTimes{bi}(j) - Tb & etimes{bi} <= CutTimes{bi}(j) + Ta);
        Event_names  = [Event_names enames{bi}(tmp_ev_inds)];
        Event_types  = [Event_types etypes{bi}(tmp_ev_inds)];        
        Event_times  = [Event_times etimes{bi}(tmp_ev_inds) - CutTimes{bi}(j)];
        Event_trials = [Event_trials k * ones(size(tmp_ev_inds))];

        % Get Events falling between end of previous data segment and
        % beginning of this one
        if j > 1
            tmp_prev_ev_inds = find(etimes{bi} > CutTimes{bi}(j-1) + Ta & etimes{bi} < CutTimes{bi}(j) - Tb);
            overlap(k) = (CutTimes{bi}(j) - Tb) - (CutTimes{bi}(j-1) + Ta); % Overlap between segments
        else
            % Sometimes we get an initial "psuedo cleaning" Event that
            % occurs immedialtey, this is not real.
            tmp_prev_ev_inds = find(etimes{bi} < CutTimes{bi}(j) - Tb & etimes{bi} > 1);
            overlap(k) = nan;
        end
        prev_Event_names  = [prev_Event_names enames{bi}(tmp_prev_ev_inds)];
        prev_Event_times = [prev_Event_times etimes{bi}(tmp_prev_ev_inds) - CutTimes{bi}(j)];
        prev_Event_trials = [prev_Event_trials k * ones(size(tmp_prev_ev_inds))];        
        prev_Event_types  = [prev_Event_types etypes{bi}(tmp_prev_ev_inds)];         
        
        block_tag(k) = blocks(bi); % KEEP A TAG ON WHICH TRIAL EACH BLOCK COMES FROM
        k = k + 1;
    end
end

%%%%%%%%%%%
clear   bi;
clear   inds;
clear  j;
clear   k;
clear  session;
clear   theseinds;
clear  thesespiketimes;
clear   this_unit;
clear  tmp_ev_inds;
clear  tmp_prev_ev_inds;
clear   u;
clear  badspikes;
%%%%%%%%%%%%

save(outfname);

return
