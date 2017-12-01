function [VAR BinTimeS] = get_running_var(D,StepSize,BinSize,SR,info_str);


D = double(D);
D(find(D == intmax('int16'))) = nan;

N = length(D);
% number of samples in each step
StepSamples = round(StepSize*SR);
% Number of samples in each bin
BinSamples = round(BinSize*SR);
% make window to be an odd number so that it can have a center sample
if ~mod(BinSamples,2)
    BinSamples = BinSamples + 1;
end
HalfBin = (BinSamples-1) / 2;
BinCen = ceil(BinSamples/2);

k = 1;
while (BinCen + BinSamples) <= N
    BinCenS(k) = BinCen;
    VAR(k) = var(D(BinCen-HalfBin:BinCen+HalfBin));    
    k = k + 1;
    BinCen = BinCen + StepSamples;
end

BinTimeS = BinCenS / SR;

% close all
% figure; 
% plot([1:N]/SR,D)
% hold on
% plot(BinTimeS,VAR,'g')
% title(info_str)
% plot(BinTimeS,sV,'r')

% tmp = input('blah','s')
% if strcmp(tmp,'q')
%     VAR = [];
%     return
%  
% end



return