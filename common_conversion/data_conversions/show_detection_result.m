function show_detection_result(D,Inds1,Inds2,St,Et,Si,Sb,Sa);

% St and Et are start and end time in ms
% Si is the sampling itnerval in ms
% Sb and Sa are the samples before and after the detection value
% D is the signal and Inds1 and Inds2 are the indices of detection into D
% expressed in samples

% D           1x8622080            17244160  int16 array
%   Et          1x1                         8  double array
%   Inds1       1x3353                  26824  double array
%   Inds2       1x3551                  28408  double array
%   Sa          1x1                         8  double array
%   Sb          1x1                         8  double array
%   Si          1x1                         8  double array
%   St          1x1                         8  double array


% Convert start and end inds from ms to samples
sSt = ceil(St/Si);
sEt = floor(Et/Si);

% Find the detection idnices that are within these limits
rI1 = Inds1(find(Inds1 > sSt+Sb & Inds1 < sEt - Sa));
rI2 = Inds2(find(Inds2 > sSt+Sb & Inds2 < sEt - Sa));

figure
plot([sSt:sEt]*Si,D(sSt:sEt),'k');
hold on
for i =1:length(rI1)
    plot([rI1(i)-Sb:rI1(i)+Sa]*Si,D([rI1(i)-Sb:rI1(i)+Sa]),'r');
    plot(rI1(i)*Si,D(rI1(i)),'r*');
end
for i =1:length(rI2)
    plot([rI2(i)-Sb:rI2(i)+Sa]*Si,D(rI2(i)-Sb:rI2(i)+Sa),'g');
    plot(rI2(i)*Si,D(rI2(i)),'g*');
end
set(gca,'xlim',Si*[sSt,sEt])



return



























return