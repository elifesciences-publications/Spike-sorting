function smoothed = smooth_reponses(X,W);

L = length(W);

if ~mod(L,2)
    disp('window in smooth_responses must be odd');
    return
end

L1 = (L-1)/2;

smoothed = conv(W,X);
L2 = length(smoothed);

smoothed = smoothed(L1+1:1:L2-L1);

return