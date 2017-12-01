function data = my_filter(data,Npoles,HP,LP);

HP = 6000;
LP = 500;

% Filter it
% Make the butterworth filter:
Npoles = 2;
Wn=[500 6000]/(SR/2);
[b,a]=butter(Npoles, Wn);
% Filter the signal
data=filtfilt(b,a,double(data));
data = int16(data);
