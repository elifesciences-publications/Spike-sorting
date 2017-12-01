function corrs = correlate_chans(datadir,blocks,channels);
% Calculate raw correlation between sites


% HARD PARAMETERS:
DT = 2; % dead time in ms
Tb = 1; % time before peak of spike to extract
Ta = 1.5;  % Time after peak of spike to exract
SR = 24414; % Sampling rate in Hz
Npcs = 2; % number of PCs
IBI = 1; % Inter block itnerval - used for combining files.
DTmethod = 'TakeLN'; % Dead time method, for dealing with closely spaced spikes.



% maxspikevalinSDs - maximum values magnbitude of spikes in SDs relative to
% background signals

% data,thr,DT,Tb,Ta,SR,'takeLN',SHOW_DETECT_RES,maxspikeval

% The functions does not return arguments except the OK flag, but rather
% saves the following files:
% For each group in each block
%   1. A spikes time file
%   2. An initial cluster file, which is required along with the spike time file
%   to view detected spikes in neurscope - all spikes are assigned to the
%   same cluster in this file.
% The file Nspikes.mat which contains the number of spikes detected for
% each channel and each block. This is saved in the combined_directory.


for block_ind = 1:length(blocks)    % Loop over each of the blocks within a certain day
    for i1 = 1:length(channels) % loop over channels within a group within a block
        relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_PDec_chan_' num2str(channels(i1)) '.mat'];
        varname = ['PDec_' num2str(channels(i1))];
        eval(['load ' relfile ' ' varname ';' 'data1 =' varname ';' 'clear '  varname ';']);
        for i2 = (i1+1):length(channels)
            relfile = [datadir 'Block-' num2str(blocks(block_ind)) filesep 'Block-' num2str(blocks(block_ind)) '_PDec_chan_' num2str(channels(i2)) '.mat'];
            varname = ['PDec_' num2str(channels(i2))];
            eval(['load ' relfile ' ' varname ';' 'data2 =' varname ';' 'clear '  varname ';']);            
            tmp = corrcoef(double(data1(1:1000000)),double(data2(1:1000000))); % A million points shuld be enough
            corrs{block_ind}(channels(i1),channels(i2)) = tmp(1,2);
        end        
    end % of channels within a group
end % over blocks



return
