function [CM] = script_detect_spikes(signal,realspktimes,realspkclass,params);
% % signal - A vector of samples
% % realspktimes = a Vector conatining sample numbers where a spike occured
% % realspktimes = a Vector conatining spike classes of the classes that occured
% % params - various oarameters related to detection and filtration
% % The param structure fields
% % params.dead_time - Detection dead time  {number in ms}
% % params.deadtime_select_criteria - how to decide which spikes to take when dense ones are found
% % {'takeL'  - take largest (abs) 
% % 'takeLP' - take largest positive
% % 'takeLN' - take largest negative
% % 'takeF'  - take first spike
% % 'takeLst' - take last spike}
% % params.Si  Sampling interval of data
% % params.filter_type  - Type of filter {'No_F','HPF' ,'SF' ,'WV'}  
% % params.auto_thresh_flag - Set thresh automatically {0,1}    
% % params.filt_ms_before - ms before spike for spike filtering {value in ms}
% % params.filt_ms_after; - ms after spike for spike filtering   {value in ms} 
% % params_thresh_type - type of threshold {'AbsT','PolT'}
% % params.thresh_abs_value - absolute value of trheshold {number}
% % params.thresh_pos_value - postive value of trheshold {number}
% % params.thresh_neg_value - negative value of trheshold {number}
% % params.normalize_sd - to normalize or not normalize the spikes to SD units (0 or 1);
% % params.cutoff - high pass of filter
% % params.npoles - number of poles in filter
% % CM - the confuision matrix 
% % CM(n,1) = % correct deteciton of class n
% % CM(n,2) = % misses of class n
% % CM(end,1) = % total number of detections
% % CM(end,2) = % total number of false positives
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%



% get the sampling interval:
Si = params.Si;
% Calcualte the sampling frequency (in Hz)
Fs = 1000 * (1/Si);

% How long to take before and after the detection
Sb  = floor(0.8/Si);
Sa  = floor(1.7/Si);

% This should be a constant
LPass = 6000;

% determine which filter is to be used
% Possible values for params.filter_type HPF  SF  WV  No_F 

% No filtration
switch params.filter_type
case 'No_F'
    filtered = signal;
    % If the highpass filter is selected:
case 'HPF'
    % Get the Cutoff
    CutOff = params.cutoff;
    % Get number of poles
    Npoles = params.npoles;
    
    % Make the butterworth filter:
    Wn=[CutOff LPass]/(Fs/2);
    [b,a]=butter(Npoles, Wn);
    
    % Filter the signal
    filtered=filtfilt(b,a,signal);    
case 'SF'
    % Get the number of samples before and after
    Fsb = params.filt_ms_before;
    Fsa = params.filt_ms_after;
    % Now calcualte the values in terms of samples:
    Fsb = round(Fsb/Si);
    if Fsb == 0 
        Fsb = 1;
    end
    Fsa = round(Fsa/Si);
    if Fsa == 0 
        Fsa = 1;
    end    
    filtered = p2nd_der(signal,Fsb,Fsa);    
case 'WV' % wavelets
    % Get the Cutoff
    filtered = filt_wave(signal); 
end  % of filter type switch

if params.normalize_sd
    filtered = filtered / std(filtered);
end


SpikeInds = [];

% Get infomation about threshold from GUI

% get type of threshold
% If we have an absolute threshold
switch  params.thresh_type
case    'AbsT'
    Thresh = params.thresh_abs_value;
case 'PolT'    
    Pos_Thresh = params.thresh_pos_value;
    Neg_Thresh = params.thresh_neg_value;
end

n = length(filtered);
% Find the peaks - which are defined as these points where the slope 
% before and slope after are different sign
Slope_Sign  = sign(diff(filtered));

% First term is the slope to the second point until the one before last
% Second term is the slope from the second point until the last 
All_Peaks = find(abs(Slope_Sign(1:end-1) + Slope_Sign(2:end)) < 2); % semi real extreme - see below
All_Peaks = All_Peaks + 1;

% This is for a real minimum or maximum
% Alternatively, an extrema is also defined when the second point is at a negative slope
Pos_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) <  2   & Slope_Sign(1:end-1) > 0);
Neg_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) > -2   & Slope_Sign(1:end-1) < 0);

Pos_Peaks = Pos_Peaks + 1;
Neg_Peaks = Neg_Peaks + 1;


% See if we have automatic threshold criterion
% Call the function that genertes the threshold:
if params.auto_thresh_flag
    Thresh = threshold(filtered);
    params.thresh_type = 'AbsT';
end


% Get the spikes for the absolute detection criterion
switch params.thresh_type
case 'AbsT'
    SpikeInds = intersect(All_Peaks,find(abs(filtered) > Thresh));
case 'PolT'
    % If we have to look separately for negative and positive peaks
    Pos_SpikeInds = intersect(Pos_Peaks,find(D > Pos_Thresh));
    Neg_SpikeInds = intersect(Neg_Peaks,find(D < Neg_Thresh));
    SpikeInds = union(Pos_SpikeInds,Neg_SpikeInds);
end

% Retain only those spikes which are fully contained within the signal
SpikeInds = SpikeInds(find((SpikeInds > Sb) & (SpikeInds < (length(filtered) - Sa))));

% Apply the dead time criterion
DT = params.dead_time;;

% Get intervals between detected spikes:
Spike_Intervals = diff(SpikeInds);
% Find which are the dense spikes
DSi    = find(Spike_Intervals*Si < DT);

% Go over all cases of dense spikes
dind = 1;   Done = 0;
if ~isempty(DSi)
    while  ~Done
        k = 1;
        not_this_done = 1;
        % Dspikes includes at the end of this stage one full set of dense spikes
        Dspikes = [];
        Dspikes(k) = DSi(dind);
        % Complete this group
        while dind < length(DSi) & not_this_done            
            dind = dind + 1;        
            % We check if the next close interval follows immediately
            if (DSi(dind) - Dspikes(k)) == 1
                % If it does we add it to the Dspikes
                k = k + 1;   
                Dspikes(k) = DSi(dind);
            else
                % And if it does not, we are finished with the current group
                not_this_done = 0;             
            end
        end
        % This is the exit condition - if the last spike interval in current group is the last one
        % we exit.
        if Dspikes(k) == DSi(end)
            Done = 1;
        end
        % Now for each group
        % Get the spike indices form the interval indices:
        these_spike_inds = [Dspikes Dspikes(end)+1];
        % Now get the 
        these_D_vals     = filtered(SpikeInds(these_spike_inds));
        % Based on the selection criterion - select one spike
        switch params.deadtime_select_criteria
        case 'takeL'  
            [tmp good_one] = max(abs(these_D_vals));
        case 'takeLP'
            [tmp good_one] = max(these_D_vals);
        case 'takeLN'
            [tmp good_one] = min(these_D_vals);
        case 'takeF'
            good_one = 1;
        case 'takeLst'
            good_one = length(these_D_vals);
        end
        
        % Build the group of spikes to exclude
        exclude = setdiff(these_spike_inds,these_spike_inds(good_one));
        % And exclude them from the set of detected spikes. 
        SpikeInds(exclude) = -1;
    end
end

SpikeInds = SpikeInds(find(SpikeInds > 0));


% Generate a report on quality of detection
% Show the times of the actual spikes (if this information exists):
% Just for testing purposes
CM = zeros(4,2);
% This is the range where the peak of the spike may be found
% relative to the start of the spike. It is a function of the 
% spike shapes themselves ofcourse.        
Det_Range = [1 40];                  

% Check for real spikes - detections and misses
for si = 1:length(realspktimes)
    % See it this spike is a correct detection:
    % Get the minimum distance of this spike to all detections:
    [absint sii] = min(abs(SpikeInds - realspktimes(si)));
    int =  SpikeInds(sii) - realspktimes(si);
    if (int > Det_Range(1) & int < Det_Range(2))         
        CM(realspkclass(si),1) = CM(realspkclass(si),1) + 1;
    else % This is a miss
        CM(realspkclass(si),2) = CM(realspkclass(si),2) + 1;                
    end
end

% Check for false positives:
for si = 1:length(SpikeInds)
    % See it this spike is a correct detection:
    % Get the minimum distance of this spike to all detections:
    [absint sii] = min(abs(realspktimes - SpikeInds(si)));            
    int =  SpikeInds(si) - realspktimes(sii);            
    if ~(int > Det_Range(1) & int < Det_Range(2))         
        CM(4,2) = CM(4,2) + 1;
    else  % This is just a check - this should be the total number of detections               
        CM(4,1) = CM(4,1) + 1;
    end                
end


return










