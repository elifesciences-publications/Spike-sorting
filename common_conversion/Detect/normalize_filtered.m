function normalize_filtered(handles);
% Normalize the filtered signal

GLOB_DATA = get(handles.main_detect_figure,'userdata');
filtered = GLOB_DATA{2};
Si_Data = GLOB_DATA{4};
% get the sampling interval:
Si = Si_Data(1);
% convert it to seconds
Si = Si/1000;

% Determine which normaliztion
NO_norm = get(handles.no_norm_rb,'value');
SD_norm = get(handles.SD_units_rb,'value');

% If not normalization - do nothing
if NO_norm
    return
end

% Otherwise - we have to determine the time constant
Strings = get(handles.sd_time_const,'string');
cur_val = get(handles.sd_time_const,'value');
TC = Strings{cur_val};
TC = str2num(TC);
if isempty(TC)
    TC = inf;
end
    
% Find out how many samples are needed for the averaging:
Win_Len = round(TC/(Si));

if Win_Len > length(filtered)
    Win_Len = length(filtered);
end

% The averaging time constant
Q = (1 - (1/Win_Len));

% Initialize:
% At this stage it is still a variance:
FILTERED_STD = zeros(size(filtered));
FILTERED_STD(1:Win_Len) = std(filtered(1:Win_Len));
% Now run over all other samples
for i = Win_Len+1: length(filtered)
    FILTERED_STD(i) = sqrt((Q)*FILTERED_STD(i-1).^2 + (1-Q)*filtered(i).^2);  
end
% Now only we convert it into SD
%FILTERED_STD = sqrt(FILTERED_STD);
% And now we assign the normalized signal:
GLOB_DATA{2} = GLOB_DATA{2}./FILTERED_STD;
% Save the result in the user data of the figure
set(handles.main_detect_figure,'userdata',GLOB_DATA);            



