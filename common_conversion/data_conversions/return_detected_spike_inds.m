function [SpikeInds SpikeData] = return_detected_spike_inds(D,Thresh,DT,Tb,Ta,SR,DT_method,SHOW_RES,maxspikevals);
% Get the (processed) signal and return the indices where spikes are found.

% SR is sampling rate in Hz
% DT is dead time in seconds
% Tb and Ta are the times before and after the spike peak to be extracted,
% in ms

% DT = 2; % Dead time
Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after

SpikeInds = [];

% get type of threshold
tresh_type = 'AbsT'; % The other option is 'PolT' and then a positive and a negative thresholds have to be given

% This is the simplest option
n = length(D);

% Find the peaks - which are defined as these points where the slope 
% before and slope after are different sign
Slope_Sign  = sign(diff(D));

% Get the spikes for the absolute detection criterion
switch tresh_type
    case 'AbsT'        
        
        % First term is the slope to the second point until the one before last
        % Second term is the slope from the second point until the last
        %All_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) == 0); % real extrema
        All_Peaks = (find(abs(Slope_Sign(1:end-1) + Slope_Sign(2:end)) < 2)); % semi real extreme - see below
        All_Peaks = All_Peaks + 1;

        
        
        % The intersect approach is much faster - but it can comsume a lot
        % of memory sometimes, so I prefer the slower version as below:
        %SpikeInds = intersect(All_Peaks,find(abs(D) > Thresh));
        SpikeInds = my_intersect(All_Peaks,find(abs(D) > Thresh));              
        
        clear All_Peaks Slope_Sign
        
    case 'PolT'
        % This is for a real minimum or maximum
        %Pos_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) == 0   & Slope_Sign(1:end-1) > 0);
        %Neg_Peaks = find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) == 0   & Slope_Sign(1:end-1) < 0);
        % Alternatively, an extrema is also defined when the second point is at a negative slope
        Pos_Peaks = (find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) <  2   & Slope_Sign(1:end-1) > 0));
        Neg_Peaks = (find( (Slope_Sign(1:end-1) + Slope_Sign(2:end)) > -2   & Slope_Sign(1:end-1) < 0));

        Pos_Peaks = Pos_Peaks + 1;
        Neg_Peaks = Neg_Peaks + 1;
                
        % If we have to look separately for negative and positive peaks
%         Pos_SpikeInds = intersect(Pos_Peaks,find(D > Pos_Thresh));
%         Neg_SpikeInds = intersect(Neg_Peaks,find(D < Neg_Thresh));
        
        Pos_SpikeInds = my_intersect(Pos_Peaks,find(D > Pos_Thresh));
        Neg_SpikeInds = my_intersect(Neg_Peaks,find(D < Neg_Thresh));
        
        SpikeInds = union(Pos_SpikeInds,Neg_SpikeInds);
        clear Neg_SpikeInds Pos_SpikeInds Slope_Sign
end

% Retain spikes fully contained within the signal
SpikeInds = SpikeInds(find((SpikeInds > Sb) & (SpikeInds < (length(D) - Sa))));

% Remove artifacts, i.e. values above MAX_PHYS_VAL or below MIN_PHYS_VAL
%goodinds = find(D(SpikeInds) < MAX_PHYS_VAL & D(SpikeInds) > MIN_PHYS_VAL);
%SpikeInds = SpikeInds(goodinds);



% Apply dead time criterion
[SpikeInds] = apply_dead_time(SpikeInds,DT_method,DT,Si,D);
SpikeData   = D(SpikeInds);

goodinds = find(abs(D(SpikeInds)) < maxspikevals);
SpikeInds = SpikeInds(goodinds);

if SHOW_RES
    %This is for extracting the actual spikes.
    % I also show a segment beyond the spikes
    figure
    for i = 1:length(SpikeInds)
        if (SpikeInds(i) > Sb*2) & (SpikeInds(i) < (length(D) - 2*Sa))
%             ThisSpike =  D(SpikeInds(i)-Sb:SpikeInds(i)+Sa);
%             plot(ThisSpike,'r');

            ThisSpike =  D(SpikeInds(i)-2*Sb:SpikeInds(i)+2*Sa);
            plot(1:length(ThisSpike),ThisSpike,'k');
            hold on
            plot([(Sb+1):(2*Sb+1+Sa)],ThisSpike([(Sb+1):(2*Sb+1+Sa)]),'r')
                %plot(D(SpikeInds(i)-2*Sb:SpikeInds(i)+2*Sa),'r');
                %Spikes(i,:) = D(SpikeInds(i)-Sb:SpikeInds(i)+Sa);
        end
    end
    % Mark detection point
    lh = line([2*Sb+1 2*Sb+1],[-1000 1000]);
    set(lh,'color','g')
end



return











