% A first attempt a script coordinating between MATLAB and TDT
n = 1;
clear run_time;

% Initiate a connection with server
DA = actxcontrol('TDevAcc.X');
OK = invoke(DA,'ConnectServer','Local');
% If we are in preview or run mode, CheckServerConnection should return 1
% if invoke(DA,'CheckServerConnection')==0 
%     display('Client application not connected to server')
%     return
% end

go_on = invoke(DA,'GetSysMode')==3;
% Mode 3 is the run/record mode - kind of redundant with the
% CheckServerConnection I think.

%Start Routine
tic % reset clock
while go_on
    % They take about 20ms each.
    Trigger = invoke(DA,'GetTargetVal','myamp.BreathTrig');  % myamp.BreathMax could be used too
    if Trigger % If we were triggered by breathing
        invoke(DA,'SetTargetVal','myamp.dOdorStim',unidrnd(64));
        invoke(DA,'SetTargetVal','myamp.ValveOnDur',0); % This should be sent not onl every cycle, and of course
        % we should check for changes in this parameter through
        % MATLAB
        % Now, set value to high and then to low - this is the only way I
        % figured out for trigerring through MATLAB
        invoke(DA,'SetTargetVal','myamp.ValveIn',1);
        invoke(DA,'SetTargetVal','myamp.ValveIn',0);
        % This should trigger data acquisition of the Odor number and
        % also stimulate the duration of the valve control
        pause(2);
    end
    % run_time(n) = toc; % These lines are for debugging
    % triggers(n) = Trigger; 
    n = n+1;
    if ~rem(n,10) % Every 10 cycles, to save time on this time consuming operation
        % Check if system is still in Run mode
        go_on = invoke(DA,'GetSysMode')==3;
    end
end

% This is proper cleaning up
disp('OpenWorkBench is no longer in Run Mode')
invoke(DA,'CloseConnection');
