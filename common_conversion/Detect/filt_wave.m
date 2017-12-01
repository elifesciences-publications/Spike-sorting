function [filtered] = filt_wave(signal);

level = 7;
wavelet = 'haar';
%wavelet = 'rbio3.9';

    Wn=[300 6000]/(24000/2);
    [b,a]=butter(4, Wn);
    
    % Filter the signal
    filter=filtfilt(b,a,signal);
    
%criteria = 'sqtwolog';
criteria = 'minimaxi';
    
filtered = wden1(filter,criteria,'h','mln',level,wavelet);



