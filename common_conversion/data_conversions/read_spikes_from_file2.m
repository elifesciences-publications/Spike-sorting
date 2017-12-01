function AllSpikes = read_spikes_from_file2(nspikes,SpikeLen,Nchans,spike_file_name);
% Read spikes from file in the NeuroScope data format
% each row in AllSpikes contains data for one spike.
% the columns are divided into a number of contiguous sections which
% correspond to the number of channels within a group
% Thus, for a group with 4 channels and a spike of 100 samples, columns
% 1:100 will describe the spike as recorded by the first channel, columns
% 101:200 will describe the spikes as recorded by the second channel - etc
% ...

Su = 10000; % maximal number of spikes per segment of file read

% number of samples describing a single spike, accounting for number of channels
FSpikeLen = SpikeLen * Nchans; 
% Allocate memory - this saves a HUGE amount of time
AllSpikes = int16(zeros(nspikes,FSpikeLen));

% I first define some index vectors to save calcualtions within the loop.
% "interleaved indices"
for j = 1:Nchans
    inds(j,:) = [j:Nchans:FSpikeLen];
end
% "concatanated indices"
for j = 1:Nchans
    inds2(j,:) = (j-1)*SpikeLen + [1:SpikeLen];
end

% Find and check number of elements in file
fid = fopen(spike_file_name,'rb');
% Get to end of file and see how many elements there are
fseek(fid, 0, 'eof');
n = ftell(fid);
fseek(fid, 0, 'bof'); % Get back to beginning of file
exp_n = nspikes * SpikeLen * Nchans * 2; % The 2 factor is because data is 16 bit (2 bytes)
% Check 
if ~(exp_n == n)
    disp(['number of elements in file does not match expected number'])
    return
end

% Calctulate number of segments and remainder
nspikesS = floor(nspikes/Su);
spikesSrem = rem(nspikes,Su);
if ~(nspikes == (nspikesS * Su + spikesSrem))
    disp('error in the spike division indices in read_spikes_from_file')
    return
end
count1 = Su * Nchans * SpikeLen * 2; % Number of bytes for each segment
Nels1 = count1 / 2; % Number of elements per segment
count2 = spikesSrem * Nchans * SpikeLen * 2; % Number of bytes for last segment
Nels2 = count2/2; % Number of elements 
N1 = nspikesS * count1 + count2; % So, total number of bytes
if ~(N1 == n)
    disp(['error in expected number elements / file division procedure'])
    return
end

Si = 1;
nextpos = 0;
% Number of elements in each Su spikes (in each segment)
for i = 1:nspikesS    
    % Next position in bytes
    %nextpos(i)    = 0 + Su * (i-1)* Nchans * SpikeLen * 2 
    status     = fseek(fid,nextpos,'bof');
    %curpos = ftell(fid)
    % I divide  by two since the number of elements is half of the number
    [D counted ] = fread(fid, Nels1, 'int16=>int16');
    nextpos = ftell(fid)
    if ~(counted == Nels1)
        disp(['some elements not succesfuly read'])
        return
    end
    for k = 1:Su
        thisSpike = D(FSpikeLen*(k-1) + [1:FSpikeLen])';
        for j = 1:Nchans
            AllSpikes(Si,inds2(j,:)) = thisSpike(inds(j,:))';
        end
        Si = Si + 1;
    end    
end

nextpos = ftell(fid)    
% Now you have to read the remainder spikes
status     = fseek(fid,nextpos,'bof');
[D counted ] = fread(fid, Nels2, 'int16=>int16');
if ~(counted == Nels2)
    disp(['some elements not succesfuly read'])
    return
end
for k = 1:spikesSrem
    thisSpike = D(FSpikeLen*(k-1) + [1:FSpikeLen])';
    for j = 1:Nchans
        AllSpikes(Si,inds2(j,:)) = thisSpike(inds(j,:))';
    end
    Si = Si + 1;
end

fclose(fid)

if ~(Si-1 == nspikes)
    disp(['error, incorrect number of spikes read'])
    return
end

return










