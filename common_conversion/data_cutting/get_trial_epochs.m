function get_trial_epochs(expdate,session,Sorted);
% get the spike data and arrange it into cuts defined by events
% Results are saved in an output file: [basepath 'CutData\cutdata_TrialEpochs_' sstring '_unsorted']


% Time before and after each event to include in a segment
Tb = 10;
Ta = 30;
% for binning spikes
BinSize = 0.2;
timevec = [-Tb:BinSize:Ta];
for j = 1:length(timevec)-1
    TimeVecCen(j) = mean([timevec(j) timevec(j+1)]);
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
% Get information pertaining to session
[datadir,combined_datadir,blocks,PC_block,groups,maxSN] = get_session_info(expdate,session);


global GLBL_WHICH_PC;
switch GLBL_WHICH_PC
    case 'LAPTOP'
        basepath = 'C:\DATA\';
    otherwise
        basepath = 'c:\DATA\';
end

% name of output file
if ~Sorted
    outfname = [basepath 'CutData\cutdata_TrialEpochs_' sstring '_unsorted'];
else
    outfname = [basepath 'CutData\cutdata_TrialEpochs_' sstring '_sorted'];
end

% get the events that pertain to each of the individual trials, i..e application, stimulation, cleaning, etc ....
get_epoch_times_script


% Get spike time data
if ~Sorted  % Then we load the results of the detection step and get MUA - and potentially same spikes across close channels
    [spiketimes spikeclass units] = read_spikes_times_per_channel_2(combined_datadir);
else
    [spiketimes spikeclass units] =  read_offline_spike_times(expdate,session,SR);
end

% Ignore the 0 (Artifact) class
units = units(find(units));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get stimulation durations and exlcude spikes if required
for i = 1:length(S1_t)

    % these are the spike times in the relevant block that are larger than some value and smaller than another value
    badspikes = spiketimes{S1_b(i)} > S1_t(i) & spiketimes{S1off_b(i)} < S1off_t(i);
    S1_stimdur(i) =  S1off_t(i) - S1_t(i);
    disp(['excluded a section of ' num2str(S1_stimdur(i)) ' seconds ' ]);

    if DELETE_STIMULATION_SPIKES
        spiketimes{S1_b(i)}(badspikes) = [];
        spikeclass{S1_b(i)}(badspikes) = [];
    end
end

for i = 1:length(S2_t)
    badspikes = spiketimes{S2_b(i)} > S2_t(i) & spiketimes{S2off_b(i)} < S2off_t(i);
    S2_stimdur(i) =  S2off_t(i) - S2_t(i);
    disp(['excluded a section of ' num2str(S2_stimdur(i)) ' seconds ' ]);
    if DELETE_STIMULATION_SPIKES
        spiketimes{S2_b(i)}(badspikes) = [];
        spikeclass{S2_b(i)}(badspikes) = [];
    end
end

for i = 1:length(Cs1_t)
    badspikes = spiketimes{Cs1_b(i)} > Cs1_t(i) & spiketimes{Cs1off_b(i)} < Cs1off_t(i);
    Cs1_stimdur(i) =  Cs1off_t(i) - Cs1_t(i);
    disp(['excluded a section of ' num2str(Cs1_stimdur(i)) ' seconds ' ]);
    if DELETE_STIMULATION_SPIKES
        spiketimes{Cs1_b(i)}(badspikes) = [];
        spikeclass{Cs1_b(i)}(badspikes) = [];
    end
end

for i = 1:length(Cs2_t)
    badspikes = spiketimes{Cs2_b(i)} > Cs2_t(i) & spiketimes{Cs2off_b(i)} < Cs2off_t(i);
    Cs2_stimdur(i) =  Cs2off_t(i) - Cs2_t(i);
    disp(['excluded a section of ' num2str(Cs2_stimdur(i)) ' seconds ' ]);
    if DELETE_STIMULATION_SPIKES
        spiketimes{Cs2_b(i)}(badspikes) = [];
        spikeclass{Cs2_b(i)}(badspikes) = [];
    end
end


% Used later for identifying cut identities
cut_names{1} = 'application';
cut_names{2} = 'S1';
cut_names{3} = 'S2';
cut_names{4} = 'start clean';
cut_names{5} = 'cS1';
cut_names{6} = 'cS2';

% For each odor application event, make a list of the block, start time and end time
for i = 1:length(odor_names)
    SEG_B(i,1) = [E_b(i)];
    SEG_S(i,1) = [E_t(i)-Tb];
    SEG_E(i,1) = [E_t(i)+Ta];

    SEG_B(i,2) = [S1_b(i)];
    SEG_S(i,2) = [S1_t(i)-Tb];
    SEG_E(i,2) = [S1_t(i)+Ta];

    SEG_B(i,3) = [S2_b(i)];
    SEG_S(i,3) = [S2_t(i)-Tb];
    SEG_E(i,3) = [S2_t(i)+Ta];

    SEG_B(i,4) = [C_b(i)];
    SEG_S(i,4) = [C_t(i)-Tb];
    SEG_E(i,4) = [C_t(i)+Ta];

    SEG_B(i,5) = [Cs1_b(i)];
    SEG_S(i,5) = [Cs1_t(i)-Tb];
    SEG_E(i,5) = [Cs1_t(i)+Ta];

    SEG_B(i,6) = [Cs2_b(i)];
    SEG_S(i,6) = [Cs2_t(i)-Tb];
    SEG_E(i,6) = [Cs2_t(i)+Ta];
end



for oi = 1:length(odor_names)     % over all trials
    for u = 1:length(units)  % over all units
        this_unit = units(u);
        for ci = 1:size(SEG_B,2) % Over all cut events

            S = SEG_S(oi,ci);
            E = SEG_E(oi,ci);
            B = SEG_B(oi,ci);

            thesespiketimes = spiketimes{B}(find(spikeclass{B} == this_unit));
            % get spikes falling within data segments
            inds = find(thesespiketimes >= S & thesespiketimes <= E);
            % Specify spike times relative to segment cut time
            thesespiketimes = (thesespiketimes(inds)-S) -Tb;

            % the indices here are for, odor, cut, and unit
            spike_times{oi}{ci}{u} = thesespiketimes;
            % bin these spikes
            for bsi = 1:length(timevec)-1
                binned_spikes(bsi) = length(find(thesespiketimes >= timevec(bsi) & thesespiketimes < timevec(bsi+1)));
            end

            binned_spike_times{oi}{ci}{u} = binned_spikes;
            % Make smoothed spike counts
            S_binned_spike_times{oi}{ci}{u} = smooth_responses(binned_spike_times{oi}{ci}{u},W);


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
odor_names = shorten_event_names(odor_names);
un = unique(odor_names);
for i = 1:length(un)
    [N{i} Dval(i) Dunit{i} Vval(i) Vunit{i}] = parse_stim_name(un{i},'short');
end
% FIND WHICH ODORANTS EXIST IS VARIOUS CONCENTRATIONS
unique_Ns = unique(N)
for i  = 1:length(unique_Ns)
    Odor_ID{i} = unique_Ns{i};
    relinds = strmatch(unique_Ns{i},N);
    Stim_Names{i} = un(relinds);
    Odor_Conc{i} = Dval(relinds);
    disp([Odor_ID{i} ' was tested in the following concentrations:']);
    disp([num2str(Odor_Conc{i})]);
    disp(['     ']);
end

% save the data in a file
save(outfname,'spike_times','S_binned_spike_times','Wdur','binned_spike_times','BinSize','TimeVecCen','odor_names','full_odor_names','cut_names','E_b','E_t','S1_b','S1_t','S2_b','S2_t','C_b','C_t','Cs1_b','Cs1_t','Cs2_b','Cs2_t','Tb','Ta','SEG_B','SEG_S','SEG_E','spikeclass','units','S1_stimdur','S2_stimdur','Cs1_stimdur','Cs2_stimdur')

return




