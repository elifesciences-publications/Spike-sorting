function [spiketime spikeclass] = read_spikes_times(datadir,block,groups,do_groups,SR);

spiketime =   [];
spikeclass =  [];


for gi = 1:length(do_groups)
    classshift = str2num(groups(do_groups(gi)).name) * 100;
    spiketime_file_name = [datadir 'Block-' num2str(block) filesep 'Block-' num2str(block) '.res.' groups(do_groups(gi)).name];
    fid = fopen(spiketime_file_name,'rt');
    this_spiketime = fscanf(fid,'%f');
    this_spiketime = this_spiketime/SR; % Convert time units to seconds
    fclose(fid);
    cluster_file_name = [datadir 'Block-' num2str(block) filesep 'Block-' num2str(block) '.clu.' groups(do_groups(gi)).name];
    fid = fopen(cluster_file_name,'rt');
    thisclass    = fscanf(fid,'%f');
    thisclass = classshift + thisclass(2:end);    
    fclose(fid);
    
    spiketime  = [spiketime ; this_spiketime];
    spikeclass = [spikeclass ; thisclass]; 
end

% sort them
[spiketime I ] = sort(spiketime);
spikeclass     = spikeclass(I);


return