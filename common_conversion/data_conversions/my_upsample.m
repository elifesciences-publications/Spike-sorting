function [yi] = my_upsample(y,resamp_factor);
% xi is not returned as it is not needed for my purposes
% This funciton requires less memory that resample.

% I easily get lengths that overpower the 3GB Linux system as well.
% my solution would be to run this recursiveily - arghhhhh !

MAXLIM = 1000000;

if (length(y)  * resamp_factor) > MAXLIM
    middle = round(length(y)/2);
    y1 = y(1:middle);
    y2 = y(middle+1:end);
    clear y;
    y1i = my_upsample(y1,resamp_factor);
    y2i = my_upsample(y2,resamp_factor);
    yi = [y1i y2i];
else
    x = 1:length(y);
    newint = 1/resamp_factor;
    xi = 1:newint:length(y);
    yi = interp1(x,y,xi);
end

return