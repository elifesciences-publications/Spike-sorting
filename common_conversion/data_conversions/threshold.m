function thr = threshold(signal,criteria);
%lx=length(signal);
criteria = 'minimaxi';
%criteria = 'sqtwolog';
a = median(abs(signal))/0.6745;
thr = thselect(signal,criteria);
thr = thr * a;
%thr = a * ( 0.3936 + 0.1829 * ( log(lx) / log(2) ) );
