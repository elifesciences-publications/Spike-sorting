function [spike] = straighten_spike(spike)
% A modification of straighten_pcs for the purpose of straigetening single spikes. 
% make them damn Pcs straight

splen = length(spike);

% Make the line for each of the PCs:
L1 = [1:splen]*(spike(end) - spike(1))/splen;

% Detrend
spike = spike - L1;

% Make zero
spike = spike - spike(1);

% Nomalize them:
spike = spike / sum(abs(spike));

% Make them 256 samples long
% spike(11:end+10,:) = straight_pc;
% spike(1:10,:)      =  0;
% spike(end+1:256,:) =  0;

