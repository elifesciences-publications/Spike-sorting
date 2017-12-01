function get_trial_epochs_V3JFB()
% get the spike data and arrange it into cuts defined by events
% Results are saved in an output file: [basepath 'CutData\cutdata_TrialEpochs_' sstring '_unsorted']


% Time before and after each event to include in a segment  - the values are now distinct
% for different epochs.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global call_process_params %%set input paramterers

Sorted=1;
fn               = call_process_params.file_num;
basepath         = call_process_params.basepath;
datadir          = call_process_params.analysis_datadir;
combined_datadir = call_process_params.analysis_combined_datadir;

expdate=call_process_params.expdate;
session=call_process_params.site{fn};
session=str2num(session(5:end));  %%converts the string 'site1' to a number 1

blocks=call_process_params.blocks{fn};
PC_block=call_process_params.PC_block{fn};
groups=call_process_params.groups{fn};
maxSN=inf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Tbs = [10 10 10 10 10 10]; these were Yoram's previous settings
% Tas = [20 40 20 20 20 20];

Tbs = [10 10 10 10 10 10 40];
Tas = [20 40 20 20 20 20 100];
% for binning spikes
BinSize = 0.2;
for ci = 1:length(Tas)
    timevecS{ci} = [-Tbs(ci):BinSize:Tas(ci)];
    for j = 1:length(timevecS{ci})-1
        TimeVecCenS{ci}(j) = mean([timevecS{ci}(j) timevecS{ci}(j+1)]);
    end
end



% Parameters for smoothing the binned spike counts
SHOW_BINNED_FOR_DEBUGGING = 0;
SmoothWinLen = 3; % In seconds
WL = round(SmoothWinLen./BinSize);
if ~mod(WL,2)
    WL = WL + 1;
end
Wdur = BinSize * WL;
W = window(@triang,WL);
W = W/sum(W); % normalize it !








if  Sorted
    DELETE_STIMULATION_SPIKES = 0;
else
    DELETE_STIMULATION_SPIKES = 1;
end

% Construct the session string
sstring = ['(' expdate '-s' num2str(session) ')'];
% the accurate sampling rate
SR =  2.441406250000000e+004;

% Block included for restoring on TDT pc, january 09
if isempty(blocks) % Some cases are inlcuded in the session data base but were not really sorted
    
    disp('no blocks')
    return
end






% name of output file
if ~Sorted
    outfname = [basepath 'CutData',filesep,'cutdata_TrialEpochs_' sstring '_unsorted'];
else
    outfname = [basepath 'CutData',filesep,'cutdata_TrialEpochs_' sstring '_sorted'];
end










% get the events that pertain to each of the individual trials, i..e application, stimulation, cleaning, etc ....
% For sessions conducted starting 2008
get_epoch_times_script_V3JFB





if ~sum([length(MOS_odor_events),length(VNS_odor_events),length(all_odor_events),length(inhale_NPD_events),length(inhale_odor_events)])
    disp('no odor, VNS, MOS, or inhale events')
    return
end



% % whos %%JFB debug
% % pause
% % 

% Get spike time data
if ~Sorted  % Then we load the results of the detection step and get MUA - and potentially same spikes across close channels
    [spiketimes spikeclass units] = read_spikes_times_per_channel_2(combined_datadir);
else
    [spiketimes spikeclass units] =  read_offline_spike_times_JFB(expdate,session,SR);
end

% Ignore the 0 (Artifact) class
units = units(find(units));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parts of this section commented out for the third version of this code, because we
% always use spike sorted data now
% Get stimulation durations and exlcude spikes if required
for i = 1:length(S1_t)

    % these are the spike times in the relevant block that are larger than some value and smaller than another value
    %  badspikes = spiketimes{S1_b(i)} > S1_t(i) & spiketimes{S1off_b(i)} < S1off_t(i);
    S1_stimdur(i) =  S1off_t(i) - S1_t(i);
    disp(['excluded a section of ' num2str(S1_stimdur(i)) ' seconds ' ]);

    %     if DELETE_STIMULATION_SPIKES
    %         spiketimes{S1_b(i)}(badspikes) = [];
    %         spikeclass{S1_b(i)}(badspikes) = [];
    %     end
end

for i = 1:length(Cs1_t)
    %    badspikes = spiketimes{Cs1_b(i)} > Cs1_t(i) & spiketimes{Cs1off_b(i)} < Cs1off_t(i);
    Cs1_stimdur(i) =  Cs1off_t(i) - Cs1_t(i);
    disp(['excluded a section of ' num2str(Cs1_stimdur(i)) ' seconds ' ]);
    %     if DELETE_STIMULATION_SPIKES
    %         spiketimes{Cs1_b(i)}(badspikes) = [];
    %         spikeclass{Cs1_b(i)}(badspikes) = [];
    %     end
end

for i = 1:length(Cs2_t)
    %    badspikes = spiketimes{Cs2_b(i)} > Cs2_t(i) & spiketimes{Cs2off_b(i)} < Cs2off_t(i);
    Cs2_stimdur(i) =  Cs2off_t(i) - Cs2_t(i);
    disp(['excluded a section of ' num2str(Cs2_stimdur(i)) ' seconds ' ]);
    %     if DELETE_STIMULATION_SPIKES
    %         spiketimes{Cs2_b(i)}(badspikes) = [];
    %         spikeclass{Cs2_b(i)}(badspikes) = [];
    %     end
end


% Used later for identifying cut identities
cut_names{1} = 'application';
cut_names{2} = 'S1';
cut_names{3} = 'Suction';
cut_names{4} = 'start clean';
cut_names{5} = 'cS1';
cut_names{6} = 'cS2';
cut_names{7} = 'fulltime'; %%JFB

% For each odor application event, make a list of the block, start time and end time
for i = 1:length(odor_names)
    if event_type(i) == 1 % VNS

        % rel_seg indicates whether the segment in question is relevant for this type of event, being either
        % MOS or VNS related - required for subsquent programs
        rel_seg(i,1) = 1;
        rel_seg(i,2) = 1;
        rel_seg(i,3) = 0;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 1;
        rel_seg(i,7) = 1; %%JFB


        SEG_B(i,1) = [E_b(i)];
        SEG_S(i,1) = [E_t(i)-Tbs(1)];
        SEG_E(i,1) = [E_t(i)+Tas(1)];

        SEG_B(i,2) = [S1_b(i)];
        SEG_S(i,2) = [S1_t(i)-Tbs(2)];
        SEG_E(i,2) = [S1_t(i)+Tas(2)];

        SEG_B(i,3) = nan;
        SEG_S(i,3) = nan;
        SEG_E(i,3) = nan;

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = [Cs2_b(i)];
        SEG_S(i,6) = [Cs2_t(i)-Tbs(6)];
        SEG_E(i,6) = [Cs2_t(i)+Tas(6)];
                
        SEG_B(i,7) = [E_b(i)]; %%Base VNS full time on the VNS application of the fluid
        SEG_S(i,7) = [E_t(i)-Tbs(7)];
        SEG_E(i,7) = [E_t(i)+Tas(7)];


        % MOS event
    elseif event_type(i) == 2

        rel_seg(i,1) = 0;
        rel_seg(i,2) = 0;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 1;
        rel_seg(i,7) = 1;

        SEG_B(i,1) = nan;
        SEG_S(i,1) = nan;
        SEG_E(i,1) = nan;

        SEG_B(i,2) = nan;
        SEG_S(i,2) = nan;
        SEG_E(i,2) = nan;

        SEG_B(i,3) = [E_b(i)];
        SEG_S(i,3) = [E_t(i)-Tbs(3)];
        SEG_E(i,3) = [E_t(i)+Tas(3)];

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = [Cs2_b(i)];
        SEG_S(i,6) = [Cs2_t(i)-Tbs(6)];
        SEG_E(i,6) = [Cs2_t(i)+Tas(6)];
        
        SEG_B(i,7) = [E_b(i)];  %%Base MOS fulltime on the suction start time
        SEG_S(i,7) = [E_t(i)-Tbs(7)];
        SEG_E(i,7) = [E_t(i)+Tas(7)];

        



    elseif event_type(i) == 3

        rel_seg(i,1) = 1;
        rel_seg(i,2) = 1;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 1;
        rel_seg(i,5) = 1;
        rel_seg(i,6) = 1;
        rel_seg(i,7) = 1;

        SEG_B(i,1) = [E_b(i)];
        SEG_S(i,1) = [E_t(i)-Tbs(1)];
        SEG_E(i,1) = [E_t(i)+Tas(1)];

        SEG_B(i,2) = [S1_b(i)];
        SEG_S(i,2) = [S1_t(i)-Tbs(2)];
        SEG_E(i,2) = [S1_t(i)+Tas(2)];

        SEG_B(i,3) = [Suc_b(i)];
        SEG_S(i,3) = [Suc_t(i)-Tbs(3)];
        SEG_E(i,3) = [Suc_t(i)+Tas(3)];

        SEG_B(i,4) = [C_b(i)];
        SEG_S(i,4) = [C_t(i)-Tbs(4)];
        SEG_E(i,4) = [C_t(i)+Tas(4)];

        SEG_B(i,5) = [Cs1_b(i)];
        SEG_S(i,5) = [Cs1_t(i)-Tbs(5)];
        SEG_E(i,5) = [Cs1_t(i)+Tas(5)];

        SEG_B(i,6) = [Cs2_b(i)];
        SEG_S(i,6) = [Cs2_t(i)-Tbs(6)];
        SEG_E(i,6) = [Cs2_t(i)+Tas(6)];  
        
        SEG_B(i,7) = [E_b(i)]; %%base the VNS and MOS fulltime (7) on the VNS fluid application
        SEG_S(i,7) = [E_t(i)-Tbs(7)];
        SEG_E(i,7) = [E_t(i)+Tas(7)];

        
     
        
        
        
        
           elseif event_type(i) == 4   %%inhale

        
        rel_seg(i,1) = 0;
        rel_seg(i,2) = 0;
        rel_seg(i,3) = 1;
        rel_seg(i,4) = 0;
        rel_seg(i,5) = 0;
        rel_seg(i,6) = 0;
        rel_seg(i,7) = 1;


        SEG_B(i,1) = nan;
        SEG_S(i,1) = nan;
        SEG_E(i,1) = nan;

        SEG_B(i,2) = nan;
        SEG_S(i,2) = nan;
        SEG_E(i,2) = nan;

        SEG_B(i,3) = [Inhale_b(i)];
        SEG_S(i,3) = [Inhale_t(i)- Tbs(3)];
        SEG_E(i,3) = [Inhale_t(i)+ Tas(3)];

        SEG_B(i,4) = nan;
        SEG_S(i,4) = nan;
        SEG_E(i,4) = nan;

        SEG_B(i,5) = nan;
        SEG_S(i,5) = nan;
        SEG_E(i,5) = nan;

        SEG_B(i,6) = nan;
        SEG_S(i,6) = nan;
        SEG_E(i,6) = nan;
 
        SEG_B(i,7) = [Inhale_b(i)]; %%base the VNS and MOS fulltime (7) on the VNS fluid application
        SEG_S(i,7) = [Inhale_t(i)-Tbs(7)];
        SEG_E(i,7) = [Inhale_t(i)+Tas(7)];
        
        
        
        
        
        
        
        
        
        
        
        
    end
end





for oi = 1:length(odor_names)     % over all trials
    for u = 1:length(units)  % over all units
        this_unit = units(u);
        for ci = 1:size(SEG_B,2) % Over all cut events

            clear binned_spikes

            S = SEG_S(oi,ci);
            E = SEG_E(oi,ci);
            B = SEG_B(oi,ci);


            if ~isnan(B) % If this is not an empty segment

                thesespiketimes = spiketimes{B}(find(spikeclass{B} == this_unit));
                % get spikes falling within data segments
                inds = find(thesespiketimes >= S & thesespiketimes <= E);
                % Specify spike times relative to segment cut time
                thesespiketimes = (thesespiketimes(inds)-S) -Tbs(ci);

                % the indices here are for, odor, cut, and unit
                spike_times{oi}{ci}{u} = thesespiketimes;
                % bin these spikes
                for bsi = 1:length(timevecS{ci})-1
                    binned_spikes(bsi) = length(find(thesespiketimes >= timevecS{ci}(bsi) & thesespiketimes < timevecS{ci}(bsi+1)));
                end

                binned_spike_times{oi}{ci}{u} = binned_spikes;
                % Make smoothed spike counts
                S_binned_spike_times{oi}{ci}{u} = smooth_responses(binned_spike_times{oi}{ci}{u},W);

            else
                spike_times{oi}{ci}{u} = '';
                binned_spike_times{oi}{ci}{u} = '';
                % Make smoothed spike counts
                S_binned_spike_times{oi}{ci}{u} = '';
            end


            if SHOW_BINNED_FOR_DEBUGGING
                close
                figure
                plot(binned_spike_times{oi}{ci}{u})
                hold on
                plot(S_binned_spike_times{oi}{ci}{u},'r')
            end

        end
    end
end


% Display a summary of odor application events
for i = 1:length(odor_names)
    disp(['block: ' num2str(E_b(i)) ' time: ' num2str(round(E_t(i)*10)/10)]);
    disp([odor_names{i}]);
    disp(['-----------']);
end

% Generates a command line display of which odorants where given at which concentrations
full_odor_names = odor_names;
odor_names = shorten_event_names(full_odor_names);
un = unique(odor_names);
for i = 1:length(un)
    [N{i} Dval(i) Dunit{i} Vval(i) Vunit{i}] = parse_stim_name(un{i},'short');
end
% FIND WHICH ODORANTS EXIST IS VARIOUS CONCENTRATIONS
unique_Ns = unique(N)
for i  = 1:length(unique_Ns)
    Odor_ID{i} = unique_Ns{i};
    relinds = strmatch(unique_Ns{i},N,'exact');
    Stim_Names{i} = un(relinds);
    Odor_Conc{i} = Dval(relinds);
    disp([Odor_ID{i} ' was tested in the following concentrations:']);
    disp([num2str(Odor_Conc{i})]);
    disp(['     ']);
end

% save the data in a file
save(outfname,'rel_seg','spike_times','S_binned_spike_times','Wdur','binned_spike_times','BinSize','TimeVecCenS','odor_names','full_odor_names','cut_names','E_b','E_t','S1_b','S1_t','C_b','C_t','Cs1_b','Cs1_t','Cs2_b','Cs2_t','Tbs','Tas','SEG_B','SEG_S','SEG_E','spikeclass','units','S1_stimdur','Cs1_stimdur','Cs2_stimdur')

return




