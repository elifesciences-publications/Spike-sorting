function  plot_spikes3(blocks,spike_times,spike_trials,timevec,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,u_name,block_tag,ntrials,DD,PSTH,axes_handles,legend_on);
% This version just shows a subset of blocks

rel_trials = find(ismember(block_tag,blocks));

block_tag = block_tag(rel_trials);
ntrials = length(block_tag);
maxtrial = max(rel_trials);

rel_events    = find(ismember(event_trials,rel_trials));
event_names   = event_names(rel_events);
event_times   = event_times(rel_events);
event_trials  = event_trials(rel_events);


overlap = overlap(rel_trials);
rel_spikes = find(ismember(spike_trials,rel_trials));
spike_times = spike_times(rel_spikes);
spike_trials = spike_trials(rel_spikes);

RPi = ismember(prev_event_trials,rel_trials);
prev_event_names = prev_event_names(RPi);
prev_event_trials = prev_event_trials(RPi);
prev_event_times = prev_event_times(RPi);

co = 'mrgbcymrgbcymrgbcymrgbcy';
mo = '+o*xsd^vph+o*xsd^vph';

uni_names = unique(event_names);

xlims = [timevec];
%xlims = get(gca,'xlim')
ylims = [-1 ntrials+1];

PLOT_EVENTS = 1;
PLOT_OVERLAP = 0;

if DD
    axes(axes_handles(1))
    set(gcf,'paperorientation','landscape');    
    set(gcf,'paperposition', [0.2500    0.2500   10.5000    8.0000]);
    % Plot the events
    if PLOT_EVENTS
        for i = 1:length(uni_names)
            these = strmatch(uni_names{i},event_names);
            ph2 = plot(event_times(these),maxtrial - event_trials(these),'s');
            hold on
            set(ph2,'color',co(i),'markerfacecolor',co(i));
            legendstr{i} = uni_names{i};
        end
        if legend_on
            legend(legendstr)
        end
    end
    % PLOT SPIKES - I use a trick - to make multiple lines into a single
    % plot - which does nto connect across lines - a nice trick may I say,
    % the saves a lot of time and memory
    if length(spike_trials) > 1 
        Y(1,:) = maxtrial - spike_trials-0.3;
        Y(2,:) = maxtrial - spike_trials+0.3;
        Y(3,:) = nan(1,length(Y));

        X(1,:) = spike_times;
        X(2,:) = spike_times;
        X(3,:) = nan(1,length(X));

        nX = reshape(X,1,prod(size(X)));
        nY = reshape(Y,1,prod(size(Y)));
        ph = plot(nX,nY,'k');
        hold on
    else
        plot(spike_times, maxtrial - spike_trials,'ko');
    end
    
    % plot lines to indicate the block limits
    set(gca,'xlim',xlims);
   % set(gca,'ylim',ylims);
    ll = xlims(2); % - (xposs(2)-xposs(1))/20;
    blocks = unique(block_tag);
    for i = 1:length(blocks)
        these = find(block_tag == blocks(i));
        lh = line([ll ll],[ntrials - these(end)-0.3 0.3 + ntrials - these(1)]);
        text(ll+abs(ll)/20,ntrials - mean(these),num2str(blocks(i)));
        set(lh,'linewidth',5)
        if ~rem(i,2)
            set(lh,'color','g')
        end
    end
    for i = 1:length(blocks) -1
        these = find(block_tag == blocks(i));
        lh2 = line([xlims],[(ntrials -these(end))-0.5 (ntrials - these(end))-0.5]);
        set(lh2,'linewidth',2,'color','r')
    end

    set(gca,'ytick',[1:5:ylims(2)])
    set(gca,'yticklabel',[],'YAxisLocation','right')
    set(gca,'ytick',[])
    set(gca,'position',[0.16 0.11 0.8 0.815])
    ylabel('blocks/trials');
    xlabel('time (seconds)')
    title([u_name])
    box on
        
    for ei = 1:length(prev_event_names)
        evstr = [prev_event_names{ei} '/' num2str(round(prev_event_times(ei))) ' s              '];
        th = text(xlims(1),maxtrial - prev_event_trials(ei) - 0.3,evstr);
        set(th,'horizontalalignment','right')
        set(th,'verticalalignment','baseline')
        set(th,'interpreter','none','fontsize',6)
        set(th,'color','b');%,'fontweight','bold')
    end
       
    if PLOT_OVERLAP
        for j = 1:length(overlap)
            if isnan(overlap(j))
                ostr = '';
            else
                if overlap(j) > 0
                    ostr = ['+' num2str(round(overlap(j))) '  '];
                else
                    ostr = [num2str(round(overlap(j))) '  '];
                end
            end
            th = text(xlims(1),ntrials - j - 0.3,ostr);
            set(th,'horizontalalignment','right')
            set(th,'verticalalignment','baseline')
            set(th,'interpreter','none','fontsize',8)
            if overlap(j) < 0
                set(th,'color','r','fontweight','bold');
            else
                set(th,'color','k');
            end
        end
    end
    
    % I know, I know, I plot them again, but this is because I want them to overrride the spikes. 
    % Plot the events
    if PLOT_EVENTS
        for i = 1:length(uni_names)
            these = strmatch(uni_names{i},event_names);
            ph2 = plot(event_times(these),maxtrial - event_trials(these),'s');
            hold on
            set(ph2,'color',co(i),'markerfacecolor',co(i));
            set(ph2,'markersize',8)
            legendstr{i} = uni_names{i};
        end
    end
end

if PSTH
    axes(axes_handles(2))
    % axh2 = axes('position',get(axh1,'position'),'color','none','yaxislocation','right');
    % set(axh2,'color','none','yaxislocation','right');
    BinSize = 1; % in seconds
    spike_time_vec = [min(spike_times) max(spike_times)];
    [N X] = hist(spike_times,[spike_time_vec(1):BinSize:spike_time_vec(end)]);
    N = N / (ntrials * BinSize);
    bh = bar(X,N,'hist');
    yh = ylabel('rate (Hz)');
    xlabel('time (seconds)');
    set(gca,'xlim',xlims);
    set(gca,'ytick',get(gca,'ylim'))  
    title([u_name])
    box on
end

return
