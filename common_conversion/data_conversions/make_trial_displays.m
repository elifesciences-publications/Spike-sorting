function make_trial_displays(SC,TimeVecCen,CutTimes,TbTa,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,block_tag);


co = 'mrgbcy';
uni_names = unique(union(event_names,prev_event_names));


tbc = zeros(100,1); % i will never have so many blocks within a tank
for i = 1:length(block_tag)
    thisblock = block_tag(i);
    tbc(thisblock) = tbc(thisblock)+1;
    if isnan(overlap(i))
        ostr = '';
    elseif overlap(i) > 0
        ostr = ['+' num2str(round(overlap(i))) 's'];
    else
        ostr = [num2str(round(overlap(i))) 's'];
    end
    timestr = [num2str(round(CutTimes{thisblock}(tbc(thisblock)))) 's'];
    titstr{i} = [ostr ' (' timestr  ') B' num2str(thisblock) '/T' num2str(tbc(thisblock)) ];
end

% Pass events
% Block times,
% Plot event within blocks as lines
% Plot events outside blocks in separate subplots
% Arrange channels into groups
% Currect times on X axis


[Ntrials Nbins ] = size(SC{1});
Nunits = length(SC);

% rearrange the matrices so each represents one trial
for i = 1:Ntrials
    ThisMat = [];
    for j = 1:Nunits
        ThisMat = [ThisMat ; SC{j}(i,:)];
    end
    TrialMat{i} = ThisMat;
end

% Start plotting the trial matrix -
% 20 plots per figure

figure

% Plot the legend
subplot(4,5,1)
set(gca,'xlim',[-1 1],'ylim',[0 length(uni_names)+1],'color','w','xtick',[],'ytick',[],'box','on');
for i = 1:length(uni_names)
    th = text(0,length(uni_names)+1-i,uni_names{i});
    set(th,'interpreter','none','fontweight','bold','horizontalalignment','center','verticalalignment','middle','color',co(i))
end
title('event legend')



% Plot the actual trials

k = 2;
for i = 1:length(TrialMat)
    
    % If there is a previous event for this trial, do show it:
    prevevents = find(prev_event_trials == i);
    if ~isempty(prevevents)
        tstr = [];
        for pi = 1:length(prevevents)
            tstrs = [prev_event_names{prevevents(pi)} ' @ ' num2str(round(prev_event_times(prevevents(pi)))) ' s'];
            subplot(4,5,k)
            set(gca,'xlim',[-1 1],'ylim',[-1 1],'color','w','xtick',[],'ytick',[],'box','on');
            th = text(0,0,tstrs);
            this_col = co(strmatch(prev_event_names{prevevents(pi)},uni_names,'exact'));
            set(th,'interpreter','none','fontweight','bold','horizontalalignment','center','verticalalignment','middle','color',this_col)
            k = k + 1;
            if k == 21
                k = 1;
                figure
            end
        end
    end
    
    subplot(4,5,k)
    imagesc(TrialMat{i})
    %cb = colorbar;
    %set(cb,'location','west');
    th = title(titstr{i});
    if overlap(i) < 0
        set(th,'color','r')
    end
    k = k + 1;
    if k == 21
        k = 1;
        figure
    end
    colormap gray
    set(gca,'ytick',[1:Ntrials])
    set(gca,'yticklabel',num2str(units'))
    xticks = [1:20:Nbins];
    set(gca,'xtick',xticks);
    set(gca,'fontsize',6)
    set(gca,'xticklabel',num2str(round(TimeVecCen(xticks))'));

    % Plot the events on it as lines
    eis = find(event_trials == i);
    these_times = event_times(eis);
    these_names = event_names(eis);
    for r = 1:length(these_names)
        this_col = co(strmatch(these_names{r},uni_names,'exact'));
        thisx = 0.5 + Nbins * (these_times(r) + TbTa(1))/sum(TbTa);
        lh = line([thisx thisx],[0 Ntrials]);
        set(lh,'color',this_col,'linewidth',1)
    end
end


% For each plot, show the information








return