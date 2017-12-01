function [meanWaveforms stdWaveforms] = get_waveform_properties(expdate,site,units);
% Get the waveforms for the relevant units from the

meanWaveforms = [];
stdWaveforms = [];

fn = ['c:\data\Offline_sorted\' expdate '_site' num2str(site) '_' 'spikelib.mat' ];
if exist(fn,'file')
    load(fn);
else
    disp([fn ' does not exist - can''t load spike shape file ' ])
    return
end

for i = 1:length(Class)
    unitnames(i) = Class(i).name;
end

for i = 1:length(units)
    thisone = find(unitnames == units(i));
    if isempty(thisone)
        disp(['unit not found in spike shape database'])
        return
    else
        meanWaveforms{i} = Class(thisone).mean;
        stdWaveforms{i} = Class(thisone).std;
    end
end


return