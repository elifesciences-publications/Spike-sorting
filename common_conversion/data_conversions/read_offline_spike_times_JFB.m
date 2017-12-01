function [SpikeTimes SpikeClass units] = read_offline_spike_times_JFB(foo,session,SR);
% Reads spike times from mat files containing detection for each channel  generated at the end of the offline sorting
% These are already provided in seconds. 
global call_process_params
expdate=call_process_params.filename{call_process_params.file_num};
       
datafile = [call_process_params.basepath, 'Offline_sorted',filesep, 'AllSpikes_' expdate '_' num2str(session)]

% these are the channel time based spike times
load(datafile);

% The spikes time have to be sorted, since this is not necessarily done after the sorting - the index i runs over blocks
units = [];
for i = 1:length(SpikeTimes)
    [SpikeTimes{i} inds ] = sort(SpikeTimes{i});
    SpikeClass{i}         = SpikeClass{i}(inds);
    SpikeTimes{i} = SpikeTimes{i} / SR; % To get the time ins econds - it is originally in samples
    units = union(units,SpikeClass{i});
end
    
   
return