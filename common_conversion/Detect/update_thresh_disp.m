function update_thresh_disp(handles);
% Plot the threshold bars on the detection display

% delete previous threshold lines:
if isfield(handles,'PT_H');
    if ishandle(handles.PT_H)
        delete(handles.PT_H);
    end
end
if isfield(handles,'NT_H');
    if ishandle(handles.NT_H)
        delete(handles.NT_H);
    end
end



% Get the current axes:
axes(handles.filtered_signal_axes);
Xlims = get(handles.filtered_signal_axes,'xlim');
Ylims = get(handles.filtered_signal_axes,'ylim');


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
    
    
    % Draw the threshold line
    PT_H = line([Xlims],[Thresh Thresh],'color','b');
    NT_H = line([Xlims],-1*([Thresh Thresh]),'color','b');
    set(handles.filtered_signal_axes,'xlim',Xlims,'ylim',Ylims);
    
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
    
    % Draw the threshold line
    PT_H = line([Xlims],[Pos_Thresh Pos_Thresh],'color','b');
    NT_H = line([Xlims],[Neg_Thresh Neg_Thresh],'color','b');
    set(handles.filtered_signal_axes,'xlim',Xlims,'ylim',Ylims);    
end

% Update currently plotted position lines:
handles.PT_H = PT_H;
handles.NT_H = NT_H;
guidata(handles.main_detect_figure,handles);      


