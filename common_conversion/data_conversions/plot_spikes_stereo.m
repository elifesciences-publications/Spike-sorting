function    plot_spikes_stereo(spike_times1,spike_trials1,spike_times2,spike_trials2,timevec,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,u_name,block_tag,ntrials,DD,PSTH,axes_handles,legend_on);
% plot_spikes
% function plot_spikes(spike_times,u_name,event_times,event_names,block_tag);

co = 'mrgbcymrgbcy';
mo = '+o*xsd^vph';

uni_names = unique(event_names);

xlims = [timevec];
%xlims = get(gca,'xlim')
ylims = [-1 ntrials+1];

if DD
    axes(axes_handles(1))
    % Plot the events
    for i = 1:length(uni_names)
        these = strmatch(uni_names{i},event_names);
        ph2 = plot(event_times(these),ntrials - event_trials(these),'s');
        hold on
        set(ph2,'color',co(i),'markerfacecolor',co(i));
        legendstr{i} = uni_names{i};
    end
    if legend_on
        legend(legendstr)
    end
    % PLOT SPIKES - I use a trick - to make multiple lines into a single
    % plot - which does nto connect across lines - a nice trick may I say,
    % the saves a lot of time and memory
    if length(spike_trials1) > 1 
        Y(1,:) = ntrials - spike_trials1-0.3;
        Y(2,:) = ntrials - spike_trials1+0;
        Y(3,:) = nan(1,length(Y));

        X(1,:) = spike_times1;
        X(2,:) = spike_times1;
        X(3,:) = nan(1,length(X));

        nX = reshape(X,1,prod(size(X)));
        nY = reshape(Y,1,prod(size(Y)));
        ph = plot(nX,nY,'k');
    else
        plot(spike_times1, ntrials - spike_trials1,'ko');                       
    end

    
    if length(spike_trials2) > 1
        Y2(1,:) = ntrials - spike_trials2-0;
        Y2(2,:) = ntrials - spike_trials2+0.3;
        Y2(3,:) = nan(1,length(Y2));

        X2(1,:) = spike_times2;
        X2(2,:) = spike_times2;
        X2(3,:) = nan(1,length(X2));

        nX2 = reshape(X2,1,prod(size(X2)));
        nY2 = reshape(Y2,1,prod(size(Y2)));
        ph = plot(nX2,nY2,'r');
    else
        plot(spike_times2, ntrials - spike_trials2,'ro');
    end


    
    % plot lines to indicate the block limits

    set(gca,'xlim',xlims);
    set(gca,'ylim',ylims);
    ll = xlims(2); % - (xposs(2)-xposs(1))/20;
    blocks = unique(block_tag);
    for i = 1:length(blocks)
        these = find(block_tag == blocks(i));
        lh = line([ll ll],[ntrials - these(end)-0.3 0.3 + ntrials - these(1)]);
        text(ll+abs(ll)/20,ntrials - mean(these),num2str(blocks(i)));
        set(lh,'linewidth',5)
        if ~rem(i,2)
            set(lh,'color','r')
        end
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
        evstr = [prev_event_names{ei} ' @   ' num2str(round(prev_event_times(ei))) ' s              '];
        th = text(xlims(1),ntrials - prev_event_trials(ei) - 0.3,evstr);
        set(th,'horizontalalignment','right')
        set(th,'verticalalignment','baseline')
        set(th,'interpreter','none','fontsize',8)
        set(th,'color','b');%,'fontweight','bold')
    end
    
   
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
     
    % I know, I know, I plot them again, but this is because I want them to overrride the spikes. 
    % Plot the events
    for i = 1:length(uni_names)
        these = strmatch(uni_names{i},event_names);
        ph2 = plot(event_times(these),ntrials - event_trials(these),'s');
        hold on
        set(ph2,'color',co(i),'markerfacecolor',co(i));
        set(ph2,'markersize',8)
        legendstr{i} = uni_names{i};
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