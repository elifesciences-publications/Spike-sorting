% A script to analyze the data within a file taking a closer look
% at individual units.
clear

SR = 24414;
% Specify time range in minutes for loading
T1 = 20*60+30;
T2 = 21*60+40;
% Convert to samples
S1 = round(T1 * SR);
S2 = round(T2 * SR);

DATADIR = '/home/yoram/DATA/TDTDATA/'
EXPDATE  = '18apr06'
BLOCK = '1';
ELECVAR = 'PDec';
ELECCHANS = 1:16;
CHANORD = [1 3 2 6 7 4 8 5 13 10 12 9 14 16 11 15];
CHANCOL = 'rrrrggggbbbbkkkk';
CHANGAIN = [1 1 1 1 2 2 2 2 1 1 1 1 1 1 1 1];
EVENTS = {'evnt','stim'};

HEARTVAR = 'hart';
BREATHVAR = 'brth';


basename = [DATADIR EXPDATE filesep 'mat' filesep 'Block-' BLOCK filesep]
% Based on these, load the data
for i = 1:length(ELECCHANS)
    ELEC_fn{i} = [basename 'Block-' BLOCK '_' ELECVAR '_chan_' num2str(ELECCHANS(i)) '.mat'];
    load(ELEC_fn{i});
end
% Info file
INFO_fn{1} = [basename 'info.mat'];
load(INFO_fn{1});
% Event files
for i = 1:length(EVENTS)
    EVNT_fn{i} = [basename 'Block-' BLOCK '_' EVENTS{i} '_chan_1.mat'];
    load(EVNT_fn{i})
end

HEART_fn = [basename 'Block-' BLOCK '_' HEARTVAR '_chan_1.mat'];
load(HEART_fn);
BREATH_fn = [basename 'Block-' BLOCK '_' BREATHVAR '_chan_1.mat'];
load(BREATH_fn);


var = whos(['*' ELECVAR '*' ]);
for i = 1:length(ELECCHANS)
  thisname = [ELECVAR '_' num2str(CHANORD(i))];
  eval(['ED(i,:) = ' thisname '(S1:S2);']);
  eval(['clear ' thisname]);
end

%for plotting this
figure
Ns = length(ED);
Nc = length(ELECCHANS);
Timevec = [S1:S2]./SR;
Step = 500;
for i = 1:Nc
    Ticks(i) = Step*Nc -(i-1)*Step;
    plot(Timevec,Step*Nc -(i-1)*Step + CHANGAIN(i)*ED(i,:),CHANCOL(i));
    hold on
end
set(gca,'ylim',[-500 (i+1)*Step])
set(gca,'xlim',[Timevec(1) Timevec(end)])
set(gca,'ytick',fliplr(Ticks))
set(gca,'yticklabel',flipud(num2str(CHANORD')))
xlabel('sec')
ylabel('electrode')
title(basename)

    
% Now plot the relevant stimulations    
    
% find the relevant stims
stimsamps = round(stim_1(2,:) * SR);
relstims =stimsamps(find(stimsamps <= S2 &  stimsamps >=S1));
relstims = relstims - S1; % relative to first sample here
% Find the relevant events
evsamps = round(evnt_1(2,:) * SR);
evvals  = evnt_1(1,:);
gi = find(evsamps <= S2 &  evsamps >=S1);
relevs = evsamps(gi);
relvals = evvals(gi);
relevs = relevs - S1; % relative to first sample here

%plot(T,X);
hold on
% mark the stimulations as lines
for i = 1:length(relstims)
    lh = line([Timevec(relstims(i)) Timevec(relstims(i))],[-500 0]);
    set(lh,'color','m','linewidth',2)
end
% Mark the events as lines too.
for i = 1:length(relevs)
    lh = line([Timevec(relevs(i)) Timevec(relevs(i))],[-500 0]);
    set(lh,'color','g','linewidth',2)
    text(Timevec(relevs(i)),-250,num2str(relvals(i)))
end

% thr = threshold(X);
% SpikeInds = detect_spikes_noGUI(X,thr);
% plot(T(SpikeInds),X(SpikeInds),'r.')
% set(gca,'xlim',[0 T2-T1])
% % calcualte the rate (in 0.5 second time bins)
% % data length
% dl = T2 - T1;
% for i = 1:(round(dl)-1)
%     b(i) = length(  find([T(SpikeInds) >=i  &  T(SpikeInds) < i+1]) );
% end
% sb = smooth(b);
% ph = plot(sb,'k');
% set(gca,'xlim',[0 T2-T1])
% 
% ax1 = gca;
% ax2 = axes('Position',get(ax1,'Position'),'XAxisLocation','top','YAxisLocation','right','Color','none','XColor','k','YColor','k');
% hl2 = plot(sb,'k','Parent',ax2);
% set(ax2,'Position',get(ax1,'Position'),'XAxisLocation','top','YAxisLocation','right','Color','none','XColor','k','YColor','k');
% set(ax2,'ylim',[0 30]); % Obviously this value ma have to be changed.
return

