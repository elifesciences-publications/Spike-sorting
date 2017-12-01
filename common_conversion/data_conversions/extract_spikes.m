function Spikes = extract_spikes(D,SpikeInds,Tb,Ta,SR);
% Get spikes from given data segments based on spike samples

Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after

% Alocate memory before running - this saves plenty of time !!!!
Spikes = zeros(length(SpikeInds),Sb+Sa+1);
for i = 1:length(SpikeInds)
    Spikes(i,:)  = D(SpikeInds(i)-Sb:SpikeInds(i)+Sa);
end

% Subtract DC
Mspikes = mean(Spikes');

% baseline subtraction added on may 07
for i = 1:length(SpikeInds)
    Spikes(i,:) = Spikes(i,:) - Mspikes(i);
end


return













