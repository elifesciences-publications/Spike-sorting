function [xd,cxd,lxd] = wden(in1,in2,in3,in4,in5,in6,in7)
%WDEN Automatic 1-D de-noising using wavelets.
%   WDEN performs an automatic de-noising process of a 1-D
%   signal using wavelets.
%
%   [XD,CXD,LXD] = WDEN(X,TPTR,SORH,SCAL,N,'wname') returns 
%   a de-noised version XD of input signal X obtained by 
%   thresholding the wavelet coefficients. 
%   Additional output arguments [CXD,LXD] are the wavelet 
%   decomposition structure of de-noised signal XD.
%
%   TPTR string contains threshold selection rule:
%   'rigrsure' use principle of Stein's Unbiased Risk.
%   'heursure' is an heuristic variant of the first option.
%   'sqtwolog' for universal threshold sqrt(2*log(.)).
%   'minimaxi' for minimax thresholding.
%       (see THSELECT for more details).
%   SORH ('s' or 'h') is for soft or hard thresholding
%       (see WTHRESH for more details).
%   SCAL defines multiplicative threshold rescaling:
%     'one' for no rescaling.
%     'sln' for rescaling using a single estimation 
%       of level noise based on first level coefficients.
%     'mln' for rescaling done using level dependent
%       estimation of level noise.
%   Wavelet decomposition is performed at level N and 'wname'
%   is a string containing the name of desired orthogonal
%   wavelet.
%
%   [XD,CXD,LXD] = WDEN(C,L,TPTR,SORH,SCAL,N,'wname') returns 
%   same output arguments, using the same options as above, but 
%   obtained directly from the input wavelet decomposition 
%   structure [C,L] of the signal to be de-noised, at level N
%   and using 'wname' orthogonal wavelet.
%
%   See also THSELECT, WAVEDEC, WDENCMP, WFILTERS, WTHRESH.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 01-Jun-1998.
%   Copyright 1995-2000 The MathWorks, Inc.
% $Revision: 1.8 $

% Check arguments.
if nargin==7
    if errargn(mfilename,nargin,[7],nargout,[0:3]) , error('*'); end
    c=in1; l=in2; tptr=in3; sorh=in4; scal=in5; n=in6; w=in7;
else
    if errargn(mfilename,nargin,[6],nargout,[0:3]), error('*'), end
    x=in1; tptr=in2; sorh=in3; scal=in4; n=in5; w=in6;
end
if errargt(mfilename,tptr,'str'), error('*'), end
if errargt(mfilename,sorh,'str'), error('*'), end
if errargt(mfilename,scal,'str'), error('*'), end
if errargt(mfilename,n,'int'), error('*'), end
if errargt(mfilename,w,'str'), error('*'), end

if nargin==6
    % Wavelet decomposition of x.
    [c,l] = wavedec(x,n,w);
end

% Threshold rescaling coefficients.
switch scal
  case 'one' , s = ones(1,n);
  case 'sln' , s = ones(1,n)*wnoisest(c,l,1);
  case 'mln' , s = wnoisest(c,l,1:n);
  otherwise  , errargt(mfilename,'invalid argument value','msg'); error('*')
end

% Wavelet coefficients thresholding.
first = cumsum(l)+1;
first = first(end-2:-1:1);
ld   = l(end-1:-1:2);
last = first+ld-1;
first = [first 1];                              %changed by Rodrigo
last = [last l(1)];                             %changed by Rodrigo
n=n+1;                                          %changed by Rodrigo
s = [s median(abs(c(first(n):last(n))))/0.6745]; %changed by Rodrigo

cxd = c;
lxd = l;
for k = 1:n                     
    flk = first(k):last(k);
    if tptr=='sqtwolog' | tptr=='minimaxi'
        thr = thselect(c,tptr);
    else
        if s(k) < sqrt(eps) * max(c(flk))
            thr = 0;
        else
            thr = thselect(c(flk)/s(k),tptr);
        end
    end                                     % threshold.
    thr      = thr * s(k);                  % rescaled threshold.
    cxd(flk) = wthresh(c(flk),sorh,thr);    % thresholding or shrinking.
end

% Wavelet reconstruction of xd.
xd = waverec(cxd,lxd,w); 
