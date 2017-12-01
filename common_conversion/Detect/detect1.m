function varargout = detect1(varargin)
% DETECT1 Application M-file for detect1.fig
%    FIG = DETECT1 launch detect1 GUI.
%    DETECT1('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 16-Mar-2002 21:43:13

if nargin == 0  % LAUNCH GUI
    
    fig = openfig(mfilename,'reuse');
    
    % Use system color scheme for figure:
    set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));
    
    % Generate a structure of handles to pass to callbacks, and store it. 
    handles = guihandles(fig);
    guidata(fig, handles);
    
    if nargout > 0
        varargout{1} = fig;
    end
            
    file_menuH = uimenu('parent',handles.main_detect_figure,'Label','Data File');
    channel_menuH = uimenu('parent',handles.main_detect_figure,'Label','Channel');
   % We need this because we changed the menu settings
   handles.filemenu = file_menuH;
   handles.channelmenu = channel_menuH;
   guidata(handles.main_detect_figure,handles);      
   
elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK
    
    try
        if (nargout)
            [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
        else
            feval(varargin{:}); % FEVAL switchyard
        end
    catch
        disp(lasterr);
    end
    
end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


% --------------------------------------------------------------------
function varargout = where_am_i_button_Callback(h, eventdata, handles, varargin)
show_position

% --------------------------------------------------------------------
function varargout = select_button_Callback(h, eventdata, handles, varargin)
% Select a channel and display it on the main interface:

sH = select_detection_files;
uiwait(sH)

USER_DATA = get(handles.main_detect_figure,'userdata');
FileList = USER_DATA{5};
if isempty(FileList)
    return
end

%    handles.filemenu = channel_menuH;

% Otherwise - set the file names in the file menu
% Reset the previous file list:
CH = get(handles.filemenu,'children');
for i = 1:length(CH)
    delete(CH(i));
end
% Add the new file list:
for i = 1:length(FileList)
    [tmp FNAME] = fileparts(FileList{i});
    uimenu(handles.filemenu,'Label',FNAME,'Callback',['load_detect(' num2str(i) ',0,1)']);     
end

% Now see how many channels are in the first file:
FileConts = load(FileList{1});
% Check that the data file contains the appropriate fields !!!!!!!!!!

% get the data:
Datamat = FileConts.data;
Nchans = size(Datamat,1);
clear Datamat FileConts;

CH = get(handles.channelmenu,'children');
for i = 1:length(CH)
    delete(CH(i));
end
% Add the new file list:
for i = 1:Nchans
    % We should actually get the channel names, and not their numbers:
    uimenu(handles.channelmenu,'Label',['channel  ' num2str(i)],'Callback',['load_detect(0,' num2str(i) ',0)']);         
end

% Set the global data to include names of files and channels:
USER_DATA{5} = FileList;  % file names
USER_DATA{6} = 1:Nchans; % Channel numbers
USER_DATA{7} = [1,1]; % Indicates which file and which channel are currently active:

set(handles.main_detect_figure,'userdata',USER_DATA);
% Load the first channel from the first file 
load_detect(1,1,1);


return
% % Filter the signal
% filter_signal(handles);
% % Normalize
% normalize_filtered(handles);
% % Detect the spikes
% SpikeInds = detect_spikes(handles);
% % Plot the detected spikes:
% detect_navigate(handles,'first_time',[]);
% return


% --------------------------------------------------------------------
function varargout = Highpass_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.slope_filter_rb,'value',0);
set(handles.other_filter_rb,'value',0);
set(handles.no_filter_rb,'value',0);

% --------------------------------------------------------------------
function varargout = slope_filter_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.Highpass_rb,'value',0);
set(handles.other_filter_rb,'value',0);
set(handles.no_filter_rb,'value',0);

% --------------------------------------------------------------------
function varargout = other_filter_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.slope_filter_rb,'value',0);
set(handles.Highpass_rb,'value',0);
set(handles.no_filter_rb,'value',0);

% --------------------------------------------------------------------
function varargout = no_filter_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.slope_filter_rb,'value',0);
set(handles.Highpass_rb,'value',0);
set(handles.other_filter_rb,'value',0);

% --------------------------------------------------------------------
function varargout = select_other_filter_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.slope_filter_rb,'value',0);
set(handles.Highpass_rb,'value',0);
set(handles.no_filter_rb,'value',0);

% Select another filter:
[filename, pathname] = uigetfile('*.m','Pick the filtering function');
if filename
fullname = [pathname filename];
% Set the file name in the text box
set(handles.selected_filter_txt,'string',filename);
% Set the file name in the user data of the object
set(handles.selected_filter_txt,'userdata',filename);
end













% --------------------------------------------------------------------
function varargout = zoomin_button_Callback(h, eventdata, handles, varargin)
detect_navigate(handles,'zoomin',[]);

% --------------------------------------------------------------------
function varargout = zoomout_button_Callback(h, eventdata, handles, varargin)
detect_navigate(handles,'zoomout',[]);

% --------------------------------------------------------------------
function varargout = nav_right_button_Callback(h, eventdata, handles, varargin)
detect_navigate(handles,'right',[]);

% --------------------------------------------------------------------
function varargout = nav_left_button_Callback(h, eventdata, handles, varargin)
detect_navigate(handles,'left',[]);

% --------------------------------------------------------------------
function varargout = refresh_button_Callback(h, eventdata, handles, varargin)
% Refresh the display - 
% Filter
filter_signal(handles)
% Normalize:
normalize_filtered(handles);
% Detect
SpikeInds = detect_spikes(handles);
% Plot
detect_navigate(handles,'refresh',[]);





% --------------------------------------------------------------------
function varargout = togglebutton1_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = SD_units_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.no_norm_rb,'value',0);

% --------------------------------------------------------------------
function varargout = no_norm_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.SD_units_rb,'value',0);

% --------------------------------------------------------------------
function varargout = sd_time_const_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = popupmenu8_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = dt_largest_rb_Callback(h, eventdata, handles, varargin)
set(handles.dt_largest_pos_rb,'value',0);
set(handles.dt_largest_rb,'value',1);
set(handles.dt_largest_neg_rb,'value',0);
set(handles.dt_first_rb,'value',0);
set(handles.dt_last_rb,'value',0);


% --------------------------------------------------------------------
function varargout = dt_largest_pos_rb_Callback(h, eventdata, handles, varargin)
set(handles.dt_largest_pos_rb,'value',1);
set(handles.dt_largest_rb,'value',0);
set(handles.dt_largest_neg_rb,'value',0);
set(handles.dt_first_rb,'value',0);
set(handles.dt_last_rb,'value',0);


% --------------------------------------------------------------------
function varargout = radiobutton20_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = radiobutton21_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = radiobutton22_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = dt_largest_neg_rb_Callback(h, eventdata, handles, varargin)
set(handles.dt_largest_pos_rb,'value',0);
set(handles.dt_largest_rb,'value',0);
set(handles.dt_largest_neg_rb,'value',1);
set(handles.dt_first_rb,'value',0);
set(handles.dt_last_rb,'value',0);




% --------------------------------------------------------------------
function varargout = dt_first_rb_Callback(h, eventdata, handles, varargin)
set(handles.dt_largest_pos_rb,'value',0);
set(handles.dt_largest_rb,'value',0);
set(handles.dt_largest_neg_rb,'value',0);
set(handles.dt_first_rb,'value',1);
set(handles.dt_last_rb,'value',0);

% --------------------------------------------------------------------
function varargout = dt_last_rb_Callback(h, eventdata, handles, varargin)
set(handles.dt_largest_pos_rb,'value',0);
set(handles.dt_largest_rb,'value',0);
set(handles.dt_largest_neg_rb,'value',0);
set(handles.dt_first_rb,'value',0);
set(handles.dt_last_rb,'value',1);




% --------------------------------------------------------------------
function varargout = dt_value_eb_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = positive_thresh_val_Callback(h, eventdata, handles, varargin)
update_thresh_disp(handles);



% --------------------------------------------------------------------
function varargout = negative_thresh_val_Callback(h, eventdata, handles, varargin)
update_thresh_disp(handles);



% --------------------------------------------------------------------
function varargout = abs_thresh_val_Callback(h, eventdata, handles, varargin)
update_thresh_disp(handles);


% --------------------------------------------------------------------
function varargout = polarity_thresh_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.abs_thresh_rb,'value',0);
update_thresh_disp(handles);

% --------------------------------------------------------------------
function varargout = abs_thresh_rb_Callback(h, eventdata, handles, varargin)
set(gcbo,'value',1);
set(handles.polarity_thresh_rb,'value',0);
update_thresh_disp(handles);

% --------------------------------------------------------------------
function varargout = auto_thresh_button_Callback(h, eventdata, handles, varargin)
% Get the (filtered) signal
GLOB_DATA = get(handles.main_detect_figure,'userdata');

if isempty(GLOB_DATA)
    errordlg('Cannot determine threshold without signal','ASORT Detection');
    return
end

D = GLOB_DATA{2};
if isempty(D)
    errordlg('Cannot determine threshold without signal','ASORT Detection');
    return
end
% Call the function that genertes the threshold:
thr = threshold(D);
% set the abolute level:
set(handles.polarity_thresh_rb,'value',0);
set(handles.abs_thresh_rb,'value',1);
% set the decided value:
set(handles.abs_thresh_val,'string',num2str(thr));
% Update the display lines
update_thresh_disp(handles);
