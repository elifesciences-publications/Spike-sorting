function varargout = select_detection_files(varargin)
% SELECT_DETECTION_FILES Application M-file for select_detection_files.fig
%    FIG = SELECT_DETECTION_FILES launch select_detection_files GUI.
%    SELECT_DETECTION_FILES('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 18-Feb-2002 22:26:27

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
function varargout = detection_files_listbox_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = detection_filename_filter_eb_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = apply_filesel_button_Callback(h, eventdata, handles, varargin)
% get the list of files which fit the filter:
[PATHSTR,NAME,EXT,VERSN] =  fileparts(get(handles.first_file_name,'string'));
% Get the filter:
Name_Filter = get(handles.detection_filename_filter_eb,'string');
Name_Spec   = [PATHSTR  filesep Name_Filter];
Flist = dir([Name_Spec]);
if isempty(Flist)
    errordlg('No files in selected directory match the filter','ASORT detection');
else
    % Remove the file seperator for the dirtocell function
    PATHSTR = [PATHSTR filesep];
    FileList = dir_to_cell(Flist,PATHSTR,1);
end
set(handles.detection_files_listbox,'string',FileList)


% --------------------------------------------------------------------
function varargout = done_detect_selection_button_Callback(h, eventdata, handles, varargin)
% Put the file list in the user data of the main detection figure:
set(0,'ShowHiddenHandles','on');
MdfH = findobj('tag','main_detect_figure');
if isempty(MdfH)
    eH = errordlg('Cannot apply file list when detection figure does not exist','ASORT Detection');
    uiwait(eH);
    set(0,'ShowHiddenHandles','off');
    closereq
    return
else
    % Get list in selected file list:
    FileList = get(handles.detection_files_listbox,'string');
    if isempty(FileList)
        eH = errordlg('No files seleced for detection','ASORT Detection');
        uiwait(eH);
        set(0,'ShowHiddenHandles','off');
        closereq
        return
    else
        GLOB_DATA{5} = FileList;
        set(MdfH,'userdata',GLOB_DATA);
        set(0,'ShowHiddenHandles','off');
        closereq
        return
    end
end
 
    
    

% --------------------------------------------------------------------
function varargout = select_first_file_button_Callback(h, eventdata, handles, varargin)
[filename, pathname] = uigetfile('*.mat','Pick first data file for detection');
if ~isequal(filename,0)
    % Write the name in the appropriate text box
    set(handles.first_file_name,'string',[pathname filename]);
end

% set the name filter:
set(handles.detection_filename_filter_eb,'string',filename);

