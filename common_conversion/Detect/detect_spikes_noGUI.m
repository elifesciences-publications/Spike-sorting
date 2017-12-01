function [SpikeInds Spikes] = detect_spikes_noGUI(D,Thresh,DT,Tb,Ta,SR);
% Get the (processed) signal and return the indices where spikes are found.

% SR is sampling rate in Hz
% DT is dead time in seconds
% Tb and Ta are the times before and after the spike peak to be extracted,
% in ms

% DT = 2; % Dead time
Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after

SpikeInds = [];
% These values correspond to artifacts - but this should be updated in new
% setip
MAX_PHYS_VAL =  500;
MIN_PHYS_VAL = -500;

% get type of threshold
%PolT = get(handles.polarity_thresh_rb,'value');
%AbsT = get(handles.abs_thresh_rb,'value');

Pos_Thresh = Thresh;
Neg_Thresh = -inf;
AbsT = 0;
PolT = 1;

% This is the simplest option
n = length(D);

% Find the peaks - which are defined as these points where the slope 
% before and slope after are different sign
Slope_Sign  = sign(diff(D));

% First term is the slope to the second point until the one before last
% Second term is the slope from the second point until the last 
%All_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) == 0); % real extrema
All_Peaks = find(abs(Slope_Sign(1:end-1) + Slope_Sign(2:end)) < 2); % semi real extreme - see below
All_Peaks = All_Peaks + 1;

% This is for a real minimum or maximum
%Pos_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) == 0   & Slope_Sign(1:end-1) > 0);
%Neg_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) == 0   & Slope_Sign(1:end-1) < 0);
% Alternatively, an extrema is also defined when the second point is at a negative slope
Pos_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) <  2   & Slope_Sign(1:end-1) > 0);
Neg_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) > -2   & Slope_Sign(1:end-1) < 0);

Pos_Peaks = Pos_Peaks + 1;
Neg_Peaks = Neg_Peaks + 1;

% Get the spikes for the absolute detection criterion
switch tresh_type
    case 'AbsT'
        SpikeInds = intersect(All_Peaks,find(abs(D) > Thresh));
    case 'PolT'
        % If we have to look separately for negative and positive peaks
        Pos_SpikeInds = intersect(Pos_Peaks,find(D > Pos_Thresh));
        Neg_SpikeInds = intersect(Neg_Peaks,find(D < Neg_Thresh));
        SpikeInds = union(Pos_SpikeInds,Neg_SpikeInds);
end

% Retain only those spikes which are fully contained within the signal
SpikeInds = SpikeInds(find((SpikeInds > Sb) & (SpikeInds < (length(D) - Sa))));

% Now, take away all those which are artifacts, i.e. which are above
% MAX_PHYS_VAL or below MIN_PHYS_VAL
goodinds = find(D(SpikeInds) < MAX_PHYS_VAL & D(SpikeInds) > MIN_PHYS_VAL);
SpikeInds = SpikeInds(goodinds);

[spikeInds] = apply_dead_time(spikeInds,select_criterion,DT)


for i = 1:length(SpikeInds)
    Spikes(i,:) = D(SpikeInds(i)-Sb:SpikeInds(i)+Sa);
end














