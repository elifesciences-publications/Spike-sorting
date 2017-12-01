
for i = 1:length(datainfo)
    if strcmp(datainfo(i).name,'PDec')
        elecI = i;
    end
    if strcmp(datainfo(i).name,'hart')
        hartI = i;
    end
    if strcmp(datainfo(i).name,'brth')
        brthI = i;
    end
end

% Find the PDec channel


% SampRat1 = datainfo(elecI).SR./datainfo(hartI).SR
% SampRat2 = datainfo(elecI).SR./datainfo(brthI).SR
% if ~(SampRat1-SampRat2) % If they are equal
%     SampRat = SampRat1;
%     clear SampRat1, SampRat2;
% else
%     beep
%     disp('different sampling for heart and breathing');
% end

% SlowTimes = 1:SampRat:(SampRat*length(hart_1));
% FastTimes = 1:length(PDec_1);

% SlowTimes = SlowTimes * 1/datainfo(hartI).SR; % Time in seconds
% FastTimes = FastTimes * 1/datainfo(elecI).SR; % Time in seconds

SlowTimes = (1:length(hart_1)) /(datainfo(hartI).SR) -  1/datainfo(hartI).SR; % Time in seconds
FastTimes = (1:length(PDec_1))/(datainfo(elecI).SR) - 1/datainfo(elecI).SR; % Time in seconds

% FInd a certain tiome region
T1 = 1740;
T2 = 1800;
T1 = 0;
T2 = 5;


%Td = abs(FastTimes(end) - SlowTimes(end));
% Td = 1.1;
SlowTimes = SlowTimes; % An attempt to correct the time lag
eT1 = min(find(FastTimes > T1));
hT1 = min(find(SlowTimes > T1));
eT2 = max(find(FastTimes < T2));
hT2 = max(find(SlowTimes < T2));
figure
plot(FastTimes(eT1:eT2),PDec_1(eT1:eT2),'k')
hold on
plot(SlowTimes(hT1:hT2),100000*brth_1(hT1:hT2),'g')
plot(SlowTimes(hT1:hT2),100000*hart_1(hT1:hT2),'r')




