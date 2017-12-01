function [data] = clean_stim_arts(data,stims,SR);

%origdata = data;

% If we do not know the stimulation time, we will start by asusming one
% second
% The first stimulation may not be active, so I would try the second first
stim_times = floor(stims(2,:)*SR);
stim_dur     = 1 * SR; % For 1 second
maxstim   = 0;
maxnostim = 0;

StimFact = 10; % This value means that anything that is at least 1/Stimfact the size of the maximum artifact is considered also a sitmulus.
% For example - if the maximum value is 100 and the Simfact is 2, anything
% highe than 50 will be considered as an artifcat.

% duration of minimal unit in seconds used to delete the stimulus artifact
SmallSeg = floor(0.2 * SR); 

% Get the maximal values before stimulations and after stimulations -
% starting from the second segment - since if we have only one stimulation
% event - it may not be active
if length(stim_times) > 1
for i = 2:length(stim_times)
    % For each segment after stim, as defined by stim_dur - find the maximum values 
    stimseg = data([stim_times(i):stim_times(i)+stim_dur]);
    maxstim = max(maxstim,max(abs(stimseg)));
    % if we have an interval long enough before - meaning that there is no
    % overalp with preivous stimulus period - we obtain the maximyum value
    % from that time
    if (stim_times(i) - stim_times(i-1)) > stim_dur
        nostimseg = data([stim_times(i)-stim_dur:stim_times(i)]);
        maxnostim = max(maxnostim,max(abs(nostimseg)));
    end    
end
else % If there is only one segment
    stimseg = data([stim_times:stim_times+stim_dur]);
    maxstim = max(abs(stimseg));
    % And the other reference is for 30 seconds later
    % at least one minute
    if length(data) > SR*(30)+stim_dur
        nostimseg = data([SR*30:SR*30+stim_dur]); 
        maxnostim = max(abs(nostimseg));
    end        
    % Just delete the section after the first stim
end
% Find the stim artifact magnitudes

% Ratio between maximum amplitude before and after stim
R1 = maxstim/maxnostim; 
if R1 < 5         % This is probably not large enough
    return
else
%     StimFact = R1/2; % meaning that a size at least this fraction of the stim implies an artifact - this allows the stimuli
%                      %t o be twice as large without getting deleted
end
% If this ratio is larger than 10, than go to the next stage, which entails
% cleaning the data .... 
% The algorithm would be to start at any stimulation point, and delete any
% SmallSeg length segment that contains as value that is at least one one
% half as large as the maxstim value.
for i = 1:length(stim_times)
    go_on = 1;
    k = 1;
    while go_on
        inds = SmallSeg*(k-1) + [stim_times(i):(stim_times(i)+SmallSeg-1)];
        if max(inds) > length(data)
            return
        end
        if max(abs(data(inds))) > (maxstim/StimFact);
            data(inds) = 0;
            k = k + 1;
        else 
            go_on = 0;
        end
    end
end




% 
% figure
% subplot(2,1,1)
% plot(data)
% subplot(2,1,2)
% plot(origdata)



return

