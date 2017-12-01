function update_position_display(handles);

% Update the position display:
USER_DATA = get(handles.main_detect_figure,'userdata');

% Set the global data to include names of files and channels:
FileList = USER_DATA{5};% file names
Nchans   = length(USER_DATA{6}); % Channel numbers
Cur_FC = USER_DATA{7}; % Indicates which file and which channel are currently active:
Nfiles = length(FileList);

% Get Sampling Interval:
Si = USER_DATA{4}(1);
% Get the length of the current signal:
Tot_Len = length(USER_DATA{2});
% Get the current position
Cur_Xlim =  get(handles.filtered_signal_axes,'xlim');


% Update the displays:
    
% File and channel display:
axes(handles.file_chan_axes);
cla
set(handles.file_chan_axes,'xlim',[0 Nfiles],'ylim',[0 Nchans+1],'xtick',[],'ytick',[],'box','on');
for i = 1:Nchans
      line([0 Nfiles],[i i],'linewidth',1,'color','k');
end
% Display the first channel on top, and the last channel on the bottom
line([Cur_FC(1)-1 Cur_FC(1)],[Nchans + 1- Cur_FC(2) Nchans + 1- Cur_FC(2)],'color','r','linewidth',2);

% Within current channel display
axes(handles.pos_within_chan_axes);
cla
set(gca,'xlim',[0 Tot_Len],'ylim',[0 1])
ph = patch('parent',gca);
set(ph,'tag','progress_patch');
set(ph,'xdata',[Cur_Xlim(1) Cur_Xlim(1) Cur_Xlim(2) Cur_Xlim(2) ]);
set(ph,'ydata',[0 1 1 0]);
set(ph,'facecolor','r');
    
% Update text displays:
set(handles.current_channel_text,'string',['Channel ' num2str(Cur_FC(2)) ' of ' num2str(Nchans)]);
[tmp1 Fname] = fileparts(FileList{Cur_FC(1)});
set(handles.current_file_text,'string',['File: ' Fname  ' (' num2str(Cur_FC(1)) ' of ' num2str(Nfiles) ')']);    
% Get total time and current time and display the information:    
TT = Tot_Len*Si;

% Get the current position
CT = Cur_Xlim*Si;          % Total time accuracy is up to 0.1 ms

if TT < 1000
    TT = TT - rem(TT,0.1);    
    TTstr = [num2str(TT) ' ms'];
elseif TT < 5000
    TT = TT/1000;
    TT = TT - rem(TT,0.1);    
    TTstr = [num2str(TT) ' seconds'];
else
    TT = round(TT/1000);
    TTstr = [num2str(TT) ' seconds'];
end
    
% More then 100 ms:
if range(CT) < 1    
    CT = CT - rem(CT,0.1);     
    Pos_str = ['Shown: ' num2str(CT(1)) '-' num2str(CT(2)) ' ms of ' TTstr];    
elseif range(CT) < 1000    
    CT = round(CT);    
    Pos_str = ['Shown: ' num2str(CT(1)) '-' num2str(CT(2)) ' ms of ' TTstr];
elseif range(CT) < 5000
    CT = (CT/1000);
    CT = CT - rem(CT,0.1);    
    Pos_str = ['Shown: ' num2str(CT(1)) '-' num2str(CT(2)) ' secs of ' TTstr];
else  range(CT) 
    CT = round(CT/1000);
    Pos_str = ['Shown: ' num2str(CT(1)) '-' num2str(CT(2)) ' secs of ' TTstr];
end    
    
    
set(handles.time_within_chan_text,'string',Pos_str);    





return