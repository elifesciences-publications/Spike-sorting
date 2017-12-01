function load_detect(fN,cN,fS);
% Load data from the fN file, and cN channel form the list.
% If either of these are zero, then the current value is taken. 

% fS indiactes if we want to refreshj and see the full signal


%try
    set(0,'ShowHiddenHandles','on');
    MdfH = findobj('tag','main_detect_figure');
    USER_DATA = get(MdfH,'userdata');
    
    AllFiles = USER_DATA{5};
    AllChans = USER_DATA{6};
    Current_Vals = USER_DATA{7};
    
    if ~fN
        fN = Current_Vals(1);
    end
    if ~cN
        cN = Current_Vals(2);
    end
    
    % get list of files and channels:
    A = load([AllFiles{fN}]);
    
    % Check that the data file contains the appropriate fields !!!!!!!!!!
    
    % get the data:
    signal = A.data;
    signal = signal(cN,:);
    % % In ms
    Si = A.samplingInterval;
    % We take one 1 ms before, and 1.5 ms after the peak 
    Sb  = floor(0.8/Si);
    Sa  = floor(1.7/Si);
    USER_DATA{1} = signal;
    USER_DATA{4} = [Si,Sb,Sa]; % These are the Sampling interval (Hz) and number of samples before and after the peak
    
    USER_DATA{7} = [fN cN];
    
    % Load the actual spike times (for monitoring the spike detection performance): 
    % We are not checking anything about the validity of spike_times variable:
    TEST_VER = 1; % When we want to test the detection algorithms - should be off
    if isfield(A,'spike_times')  
        % I assume that if we have a spike times we will also have a spike class. 
        USER_DATA{8} = A.spike_times{cN};
        USER_DATA{9} = A.spike_class{cN};
    else
        if TEST_VER
            mock_spike = binornd(1,0.0001,size(signal));
            spike_class = mock_spike(cN,find(mock_spike(cN,:)));                
            spike_times = find(mock_spike(cN,:));                
            USER_DATA{8} = spike_times;                
            USER_DATA{9} = spike_class;                            
        end    
    end                    
               
    set(MdfH,'userdata',USER_DATA);
    
    % Refresh the display
    handles = guidata(MdfH);
    filter_signal(handles)
    % Normalize:
    normalize_filtered(handles);
    % Detect
    SpikeInds = detect_spikes(handles);
    % Plot
    if fS
        detect_navigate(handles,'first_time',[]);
    else
        detect_navigate(handles,'refresh',[]);
    end
    
    set(0,'ShowHiddenHandles','off');    
% catch
%     set(0,'ShowHiddenHandles','off');    
% end



