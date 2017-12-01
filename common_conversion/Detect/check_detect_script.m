% A script to check the detection


D = load('d:\yoram\simulator\data\sim1C_001.mat');
% We take the first channel always
signal       =  D.data(1,:);
realspktimes =  D.spike_times{1};
realspkclass =  D.spike_class{1};

% Parameters kept constant for all runs
params.dead_time = 2;
params.deadtime_select_criteria = 'takeL';
params.Si = D.samplingInterval;
params.cutoff  = 300;
params.npoles  = 2;


params.filt_ms_before = 0.2; 
params.filt_ms_after  = 0.4;

%Type of filter {'No_F','HPF' ,'SF' ,'WV'}  
params.filter_type = 'SF'; 
% - Set thresh automatically {0,1}    
params.auto_thresh_flag = 0;
% - type of threshold {'AbsT','PolT'}
params.thresh_type = 'AbsT';
params.thresh_abs_value = 0.5;
params.thresh_pos_value = 3;
params.thresh_neg_value = 3;

% whether to normalize data to standard deviation units
params.normalize_sd = 1;
%
%Tvals = [0.1 0.2  0.4  0.6 0.8 1 1.2 1.4 1.6 1.8  2  3  4  5 6  8 ]
Tvals = [0.1 0.2  0.5  1 1.5  2  3  4  5 6  7 8 ]
%Tvals = [0.01 0.05 0.1 0.15 0.2 0.3  0.5 1  1.5 2 ];
for i = 1:length(Tvals)
    params.thresh_abs_value = Tvals(i);
    [CM{i}]    = script_detect_spikes(signal,realspktimes,realspkclass,params);
    all_params{i}  = params;
end


% calcualte the percent correct for each method and each class:
for i = 1:length(CM)
    det1(i) = CM{i}(1,1)/(CM{i}(1,1)+CM{i}(1,2));
    det2(i) = CM{i}(2,1)/(CM{i}(2,1)+CM{i}(2,2));
    det3(i) = CM{i}(3,1)/(CM{i}(3,1)+CM{i}(3,2));
    totdet(i) = sum(CM{i}(1:3,1))/(sum(CM{i}(1:3,1)) + sum(CM{i}(1:3,2)));
    FP(i)     = CM{i}(4,2);
    FP_rat(i)     = CM{i}(4,2)/CM{i}(4,1);    
end
figure
axes
hold on
plot(Tvals,det1,'c')
plot(Tvals,det2,'g')
plot(Tvals,det3,'r')
plot(Tvals,totdet,'b')
plot(Tvals,FP_rat,'k')
legend('1','2','3','all','FP')
xlabel('threshold');







