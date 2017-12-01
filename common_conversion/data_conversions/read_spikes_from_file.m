function AllSpikes = read_spikes_from_file(nspikes,SpikeLen,Nchans,spike_file_name,method);
% Read spikes from file in the NeuroScope data format
% each row in AllSpikes contains data for one spike.
% the columns are divided into a number of contiguous sections which
% correspond to the number of channels within a group
% Thus, for a group with 4 channels and a spike of 100 samples, columns
% 1:100 will describe the spike as recorded by the first channel, columns
% 101:200 will describe the spikes as recorded by the second channel - etc
% ...

% number of samples describing a single spike, accounting for number of
% channels
FSpikeLen = SpikeLen * Nchans; 
% Allocate memory - this saves a HUGE amount of time
%AllSpikes = int16(zeros(nspikes,FSpikeLen));
fid = fopen(spike_file_name,'rb');
D = fread(fid,'int16=>int16');

%D = my_fread(fid,'int16=>int16');

if ~(length(D) == nspikes*SpikeLen*Nchans)
    disp(['error in number of samples within a file ' spike_file_name ' -number of samples should be a multiple of the number of spikes'])
end
% I first define some index vectors to save calcualtions within the loop.
% This saves time.
% "interleaved indices"
for j = 1:Nchans
    inds(j,:) = [j:Nchans:FSpikeLen];
end
% "concatanated indices"
for j = 1:Nchans
    inds2(j,:) = (j-1)*SpikeLen + [1:SpikeLen];
end
% Recosntruct data
% This is the original version which first alocated memory and then reshaped the data
if method == 1 | nspikes <= 10000 

    AllSpikes = int16(zeros(nspikes,FSpikeLen));
    for i = 1:nspikes
        thisSpike = D(FSpikeLen*(i-1) + [1:FSpikeLen])';
        for j = 1:Nchans
            AllSpikes(i,inds2(j,:)) = thisSpike(inds(j,:))';
        end
    end

else % this methods parses the spikes into chunks of 10000 - and processes them one at a time
     % documenting this months after doing it, i think the goal is to prevent large memory usage
     % due to the original spike data and the initially allocated memory

    % Make smaller segments of data to rehsape once at a time
    Su = 10000; % number of spikes per segment
    nspikesS = floor(nspikes/Su);
    spikesSrem = rem(nspikes,Su);
    if ~(nspikes == nspikesS * Su + spikesSrem)
        disp('error in the spike division indices in read_spikes_from_file')
        return
    end
    for i = 1:nspikesS
        Sstart(i) = 1 + Su * (i-1);
        Send(i)   = Su * i;
    end
    if spikesSrem
        Sstart(i+1) = Send(i) + 1;
        Send(i+1) = nspikes;
    end
    Slengths = Send - Sstart + 1;
    if ~(nspikes == sum(Slengths))
        disp('error in spike division indices in read_spikes_from_file')
    end

    tmpsinds = 0;
    Allinds = [];
    for i = 1:length(Slengths)
        thisDinds = [1 Slengths(i)*FSpikeLen];
        Allinds = [Allinds ; tmpsinds + thisDinds];
        tmpsinds = Allinds(i,2);
    end
    AllSpikes = [];
    for i = 1:length(Allinds)
        thisDindices    = [1:(Allinds(i,2)-Allinds(i,1)+1)];
        disp(['reading sample indices from 1  to ' num2str((Allinds(i,2)-Allinds(i,1)+1))  ]);
        disp(['remaining number of samples is ' num2str(length(D))]);
        thisD        = D(thisDindices);
        D(thisDindices) = [];
        tmpAllSpikes = int16(zeros(Slengths(i),FSpikeLen));
        for i = 1:Slengths(i)
            thisSpike = thisD(FSpikeLen*(i-1) + [1:FSpikeLen])';
            for j = 1:Nchans
                tmpAllSpikes(i,inds2(j,:)) = thisSpike(inds(j,:))';
            end
        end
        AllSpikes = [AllSpikes ; tmpAllSpikes];
    end

end



return












