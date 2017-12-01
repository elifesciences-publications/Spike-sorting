function filter_signal(handles);

GLOB_DATA = get(handles.main_detect_figure,'userdata');
signal = GLOB_DATA{1};
Si_Data = GLOB_DATA{4};

% get the sampling interval:
Si = Si_Data(1);
% Calcualte the sampling frequency (in Hz)
Fs = 1000 * (1/Si);

% This should be a constant
LPass = 6000;

% determine which filter is to be used
HPF   = get(handles.Highpass_rb,'value');
SF    = get(handles.slope_filter_rb,'value');
OF    = get(handles.other_filter_rb,'value');
No_F  = get(handles.no_filter_rb,'value');


% Make sure that only one button is set
if sum([HPF SF OF No_F]) ~= 1
    errordlg('Cannot determine filter type','ASORT detection');
    return
end
% No filtration
if No_F
    GLOB_DATA{2} = GLOB_DATA{1};
    % Save the result in the user data of the figure
    set(handles.main_detect_figure,'userdata',GLOB_DATA);        
    return
end

% If the highpass filter is selected:
if HPF
    % Get the Cutoff
    Strings = get(handles.HP_cutoff_value,'string');
    Cur_Val = get(handles.HP_cutoff_value,'value');    
    CutOff = Strings{Cur_Val};
    CutOff = str2num(CutOff);
    % Get number of poles
    Strings = get(handles.highpass_npoles_value,'string');
    Cur_Val = get(handles.highpass_npoles_value,'value');    
    Npoles = Strings{Cur_Val};
    Npoles = str2num(Npoles);
           
    % Make the butterworth filter:
    Wn=[CutOff LPass]/(Fs/2);
    [b,a]=butter(Npoles, Wn);
    
    % Filter the signal
    filtered=filtfilt(b,a,signal);
    
    % Save the result in the user data of the figure
    GLOB_DATA{2} = filtered;
    set(handles.main_detect_figure,'userdata',GLOB_DATA);        
end % Of if highpass filter

if SF
    % Get the number of samples before
    Msb = get(handles.slope_before_ms,'string');
    if isempty(Msb)
        errordlg('Time before peak not specified','ASORT detection')
        return
    end
    Msb = str2num(Msb);
    if isempty(Msb)
        errordlg('Time before peak must be a number','ASORT detection')
        return
    end      
    if ~(Msb > 0) & ~(Msb <= 2)
        errordlg('Time before peak must be in the interval (0,2]','ASORT detection')
        return
    end        
    % And number of samples after
    Msa = get(handles.slope_after_ms,'string');
    if isempty(Msa)
        errordlg('Time after peak not specified','ASORT detection')
        return
    end
    Msa = str2num(Msa);
    if isempty(Msa)
        errordlg('Time after peak must be a number','ASORT detection')
        return
    end      
    if ~(Msa > 0) & ~(Msa <= 2)
        errordlg('Time atfer peak must be in the interval (0,2]','ASORT detection')
        return
    end
    % Now calcualte the values in terms of samples:
    Sb = round(Msb/Si);
    if Sb == 0 
        Sb = 1;
    end
    Sa = round(Msa/Si);
    if Sa == 0 
        Sa = 1;
    end
    
    GLOB_DATA{2} = p2nd_der(signal,Sb,Sa);
    % Save the result in the user data of the figure
    set(handles.main_detect_figure,'userdata',GLOB_DATA);            
end

% If the other filter method is selected:
if OF
    % Get the Cutoff
   function_name = get(handles.selected_filter_txt,'userdata');
   [P function_name E] = fileparts(function_name);
    % Filter the signal
    
    [filtered] = feval(function_name,signal); 
        
    
    
    % Save the result in the user data of the figure
    GLOB_DATA{2} = filtered;
    set(handles.main_detect_figure,'userdata',GLOB_DATA);        
end % Of if highpass filter



