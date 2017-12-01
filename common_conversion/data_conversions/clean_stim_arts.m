function [data] = clean_stim_arts(data,stims,SR,maxSN);

stim_times = floor(stims(2,:)*SR);
stim_dur     = 1 * SR; % For 1 second
maxstim   = 0;

% duration of minimal unit in seconds used to delete the stimulus artifact
StimFreq = 20; % This is the minimal stimulus frequency in Hz - and the interval will be the smallest unit 
               % used to flatten stimulus artifacts.
SmallSeg = floor(1/StimFreq * SR); 

SD = std(data);

% Start with each stimultion period, and continue over segments of
% SmallSeg lengths - as long as the segment contains a value that is maxSN
% times the SD of the entire signal, - make the segment zero.
for i = 1:length(stim_times)
    k = 1;
    while 1
        inds = SmallSeg*(k-1) + [stim_times(i):(stim_times(i)+SmallSeg-1)];
        if max(inds) > length(data)
            return
        end
        if max(abs(data(inds))) > SD * maxSN;
            data(inds) = 0;
            k = k + 1;
        else 
            break;
        end
    end
end


return

