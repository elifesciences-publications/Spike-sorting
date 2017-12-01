function SpikeInds = detect_spikes(handles);
% Get the (processed) signal and return the indices where spikes are found.

SpikeInds = [];

% The (filtered) signal
GLOB_DATA = get(handles.main_detect_figure,'userdata');
D = GLOB_DATA{2};
% Information about length of spike
Si_data = GLOB_DATA{4};
Si = Si_data(1); % sampling interval (ms)
Sb = Si_data(2);
Sa = Si_data(3);

% Get infomation about threshold from GUI

% get type of threshold
PolT = get(handles.polarity_thresh_rb,'value');
AbsT = get(handles.abs_thresh_rb,'value');
if sum([PolT AbsT]) ~= 1
    errordlg('Cannot determine threshold polarity','ASORT')
end
% If we have an absolute threshold
if AbsT
    Thresh = get(handles.abs_thresh_val,'string');
    if isempty(Thresh)
        errordlg('Absolute threshold not specified','ASORT detection')
        return
    end
    Thresh = str2num(Thresh);
    if isempty(Thresh)
        errordlg('Absolute threshold must be a positive number','ASORT detection')
        return
    end    
    if Thresh <= 0 
        errordlg('Absolute threshold must be a positive number','ASORT detection')
        return
    end      

    
elseif PolT
    
    Pos_Thresh = get(handles.positive_thresh_val,'string');
    if isempty(Pos_Thresh)
        errordlg('Positive threshold not specified','ASORT detection')
        return
    end
    Pos_Thresh = str2num(Pos_Thresh);
    if isempty(Pos_Thresh)
        errordlg('Positive threshold must be a number','ASORT detection')
        return
    end      
    if Pos_Thresh <= 0 
        errordlg('Positive threshold must be a positive number','ASORT detection')
        return
    end      
    
    Neg_Thresh = get(handles.negative_thresh_val,'string');
    if isempty(Neg_Thresh)
        errordlg('Negative threshold not specified','ASORT detection')
        return
    end
    Neg_Thresh = str2num(Neg_Thresh);
    if isempty(Neg_Thresh)
        errordlg('Negative threshold must be a number','ASORT detection')
        return
    end      
    if Neg_Thresh >= 0 
        errordlg('Negative threshold must be a negative number','ASORT detection')
        return
    end      
    
end


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
if AbsT
    SpikeInds = intersect(All_Peaks,find(abs(D) > Thresh));
elseif PolT
    % If we have to look separately for negative and positive peaks
    Pos_SpikeInds = intersect(Pos_Peaks,find(D > Pos_Thresh));
    Neg_SpikeInds = intersect(Neg_Peaks,find(D < Neg_Thresh));
    SpikeInds = union(Pos_SpikeInds,Neg_SpikeInds);
end

% Retain only those spikes which are fully contained within the signal
SpikeInds = SpikeInds(find((SpikeInds > Sb) & (SpikeInds < (length(D) - Sa))));


% Apply the dead time criterion
DT = get(handles.dt_value_eb,'string');
if isempty(DT)
    errordlg('Dead Time not specified','ASORT detection')
    return
end
DT = str2num(DT);
if isempty(DT)
    errordlg('Dead Time must be a number','ASORT detection')
    return
end      
% Get the detection method:
takeL  = get(handles.dt_largest_rb,'value');
takeLP = get(handles.dt_largest_pos_rb,'value');
takeLN = get(handles.dt_largest_neg_rb,'value');
takeF  = get(handles.dt_first_rb,'value');
takeLst  = get(handles.dt_last_rb,'value');
if (sum([takeL takeLP takeLN takeF takeLst]) ~= 1)
    errordlg('Could not determine dead time handling condition','ASORT detection')
    return
end

%CHECK THIS ALGORITHM:

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
        these_D_vals     = D(SpikeInds(these_spike_inds));
        % Based on the selection criterion - select one spike
        if takeL  
            [tmp good_one] = max(abs(these_D_vals));
        elseif takeLP
            [tmp good_one] = max(these_D_vals);
        elseif takeLN
            [tmp good_one] = min(these_D_vals);
        elseif takeF
            good_one = 1;
        elseif takeLst
            good_one = length(these_D_vals);
        end
            
        % Build the group of spikes to exclude
        exclude = setdiff(these_spike_inds,these_spike_inds(good_one));
        % And exclude them from the set of detected spikes. 
        SpikeInds(exclude) = -1;
    end
end

SpikeInds = SpikeInds(find(SpikeInds > 0));

% Update the detected spikes in the figure user data
GLOB_DATA{3} = SpikeInds;
set(handles.main_detect_figure,'userdata',GLOB_DATA);


% Generate a report on quality of detection
% Show the times of the actual spikes (if this information exists):
% Just for testing purposes
CM = zeros(4,2);
if length(GLOB_DATA) > 7 
    if ~isempty(GLOB_DATA{8}) & ~isempty(GLOB_DATA{9})
        realspktimes = GLOB_DATA{8};
        realspkclass = GLOB_DATA{9};        
        
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
    end    
end

disp('Detection:')
disp(CM)













