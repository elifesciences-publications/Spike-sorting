function detect_navigate(handles,action,stepsize);


GLOB_DATA = get(handles.main_detect_figure,'userdata');
signal    = GLOB_DATA{1};
filtered  = GLOB_DATA{2};
SpikeInds = GLOB_DATA{3};
Samp_Data = GLOB_DATA{4};


Si        = Samp_Data(1);
Samp_Back = Samp_Data(2);
Samp_For  = Samp_Data(3);


% Get the data:
MinTime = 1;
MaxTime = length(signal);

OldXLim = get(handles.filtered_signal_axes,'Xlim');
OldRange = range(OldXLim);
cen      = OldXLim(1) + round(OldRange/2);

OldXVals = [OldXLim(1):OldXLim(2)];
NewXVals = OldXVals;

% FiltOldYLim = get(handles.filtered_signal_axes,'Ylim');
% SigOldYLim  = get(handles.signal_axes,'Ylim');

% Determine the Y limits
SRange = range(signal);
FRange = range(filtered);
SigYLim =  [min(signal) -   0.05*SRange     max(signal)   + 0.05*SRange];
FiltYLim = [min(filtered) - 0.05*FRange     max(filtered) + 0.05*FRange];


switch action    
case 'zoomin'    
    % Zoom in (only on the X axis)
    NewXVals = [ceil(cen-0.25*OldRange)  :  floor(cen+0.25*OldRange)];    
case 'zoomout'
    if (cen-OldRange > MinTime & cen+OldRange < MaxTime)   
        NewXVals = [ceil(cen-OldRange)   :  floor(cen+OldRange)];
    elseif (cen-OldRange > MinTime & cen+OldRange >= MaxTime)
        NewXVals = [ceil(cen-OldRange)   :  MaxTime];
    elseif (cen-OldRange < MinTime & cen+OldRange < MaxTime)        
        NewXVals = [MinTime   :  floor(cen+OldRange)];
    else
        NewXVals = [MinTime : MaxTime];
    end    
case 'right'
    % Move one frame to the right
    if ~(OldXLim(2) >= MaxTime)
        % IF also after moving to the left we include all spikes in the window
        if ((OldXLim(2)+OldRange) <= MaxTime)
            NewXVals = round(OldRange*0.5) + OldXVals;
        else
            NewXVals = [MaxTime-OldRange : MaxTime];
        end
    end
case 'left'
    % Move one frame to the right
    if ~(OldXLim(1) <= MinTime)
        % IF also after moving to the left we include all spikes in the window
        if ((OldXLim(1)-OldRange) >= MinTime)
            NewXVals = OldXVals - round(OldRange*0.5);        
        else
            NewXVals = [MinTime : MinTime+OldRange];
        end
    end
case 'refresh'
    % We do not have to do anything regarding the limits in this case
case 'first_time'
    % PLot the entire signal
    NewXVals = [MinTime:MaxTime];  
end % of switch

NewXLim = [min(NewXVals) max(NewXVals)];

% Plot the detected spikes (only those whose peaks are within the current limits)
SpikeInds = SpikeInds( find(SpikeInds > NewXLim(1)  &  SpikeInds < NewXLim(2)  ));

axes(handles.filtered_signal_axes);
plot(NewXVals,filtered(NewXVals),'k');
set(handles.filtered_signal_axes,'xlim',NewXLim,'Ylim',FiltYLim);
set(handles.filtered_signal_axes,'XaxisLocation','top');

hold on
for i = 1:length(SpikeInds)
    Ti = SpikeInds(i);
    This_Range = Ti-Samp_Back:Ti+Samp_For; 
    plot(This_Range,filtered(This_Range),'r')
    % plot the point of detection in green
    plot(Ti,filtered(Ti),'k.')
end
hold off

axes(handles.signal_axes);
plot(NewXVals,signal(NewXVals));
set(handles.signal_axes,'xlim',NewXLim,'Ylim',SigYLim,'xtick',[]);


% Show the times of the actual spikes (if this information exists):
% Just for testing purposes
if length(GLOB_DATA) > 7 
    SpikeInds = GLOB_DATA{3};    
    if ~isempty(GLOB_DATA{8})
        realspktimes = GLOB_DATA{8};
        % This is the range where the peak of the spike may be found
        % relative to the start of the spike. It is a function of the 
        % spike shapes themselves ofcourse.
        
        Det_Range = [1 40];        
        
        % Plot the detected spikes (only those whose peaks are within the current limits)
        realspktimes = realspktimes( find(realspktimes > NewXLim(1)  &  realspktimes < NewXLim(2)  ));

        % Check for real spikes - detections and misses
        for si = 1:length(realspktimes)
            % See it this spike is a correct detection:
            % Get the minimum distance of this spike to all detections:
            [absint sii] = min(abs(SpikeInds - realspktimes(si)));
            int =  SpikeInds(sii) - realspktimes(si);
            if (int > Det_Range(1) & int < Det_Range(2))
                lh = line([realspktimes(si) realspktimes(si) ],SigYLim);
                set(lh,'color','k');
            else % This is a miss
                lh = line([realspktimes(si) realspktimes(si) ],SigYLim);
                set(lh,'color','g');
            end
        end        
        % Plot false positives:
        for si = 1:length(SpikeInds)
            % See it this spike is a correct detection:
            % Get the minimum distance of this spike to all detections:
            [absint sii] = min(abs(realspktimes - SpikeInds(si)));            
            int =  SpikeInds(si) - realspktimes(sii);            
            if ~(int > Det_Range(1) & int < Det_Range(2))
                lh = line([SpikeInds(si) SpikeInds(si) ],SigYLim);
                set(lh,'color','m');
            end                
        end
    end    
end




hold on
for i = 1:length(SpikeInds)
    Ti = SpikeInds(i);
    This_Range = Ti-Samp_Back:Ti+Samp_For; 
    plot(This_Range,signal(This_Range),'r')
    % plot the point of detection in green
    plot(Ti,signal(Ti),'k.')
end
hold off



% Put the X label in ms
%XTK = get(handles.filtered_signal_axes,'XTick');
XTK = [NewXLim(1) :  (NewXLim(2)-NewXLim(1))/10  : NewXLim(2)];

% % add the last and first points
% if ~(XTK(1) == NewXLim(1))
%     XTK(1) = [NewXLim(1)];
% end
if ~(XTK(end) == NewXLim(2))
    XTK(end) = [NewXLim(2)];
end

% Convert values to ms for labeling
% If we have more than 10 ms in the plot, round the value
if (range(XTK*Si) > 10)
    NXTKL = round((XTK*Si));
else
    % This removes all digits beyonf the first decimal place
    NXTKL = XTK*Si - rem(XTK*Si,0.1);    
end

%NXTKL = num2str(NXTKL')
set(handles.filtered_signal_axes,'XTick',XTK);
set(handles.filtered_signal_axes,'XTickLabel',NXTKL);


% Update the position display:
update_position_display(handles);
% Update the threshold bars
update_thresh_disp(handles);