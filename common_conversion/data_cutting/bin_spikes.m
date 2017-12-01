
Ta = 20;
Tb = 20;
BinSize = 1;

timevec = [-Tb:BinSize:Ta];
for u = 1:length(spike_trials) % Over all units
    for i = 1:totntrials
        trialspikes = spike_times{u}(spike_trials{u} == i);
        for j = 1:length(timevec)-1
            SC{u}(i,j) = length(find(trialspikes >= timevec(j) & trialspikes < timevec(j+1)));
        end
    end   
end