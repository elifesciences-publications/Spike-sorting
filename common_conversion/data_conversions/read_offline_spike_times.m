function [SpikeTimes SpikeClass units] = read_offline_spike_times(expdate,session,SR);
% Reads spike times from mat files containing detection for each channel  generated at the end of the offline sorting
% These are already provided in seconds. 

global GLBL_WHICH_PC;
switch GLBL_WHICH_PC
    case 'LAPTOP'
        basepath = 'C:\DATA\Offline_sorted\';
    otherwise
        basepath = 'C:\DATA\Offline_sorted\'; % Modified for TDT computer to restore on Jan 09
%        basepath = 'c:\Offline_sorted\';
end
        
datafile = [basepath 'AllSpikes_' expdate '_' num2str(session)];

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