function calculate_responses(MaxRate,sessionstr,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,BlockNames,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,units_ord,block_tag);
% Based on
% function make_per_units_displays(MaxRate,sessionstr,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,BlockNames,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,units_ord,block_tag);

BinSize = 0.2

units

SEP_FIGS = 0;

co = 'mrgbcymrgbcymrgb';
uni_names = unique(union(event_names,prev_event_names));
totntrials = length(block_tag);

% Create matrices with spike counts per trial
timevec = [-Tb:BinSize:Ta];
for u = 1:length(spike_trials) % Over all units
    for i = 1:totntrials
        trialspikes = spike_times{u}(spike_trials{u} == i);
        for j = 1:length(timevec)-1
            SC{u}(i,j) = length(find(trialspikes >= timevec(j) & trialspikes < timevec(j+1)));
        end
    end
    maxmax(u) = max(max(SC{u}));
end
% % Clip the maximum values to MaxRate
% for u = 1:length(SC)
%     SC{u}(find(SC{u} > MaxRate)) = MaxRate;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:length(timevec)-1
    TimeVecCen(j) = mean([timevec(j) timevec(j+1)]);
end

[Ntrials Nbins ] = size(SC{1});
Nunits = length(SC);


before_inds = 1:max(find(TimeVecCen < 0));

for u = 1:length(units)
    for j = 1:size(SC{u},1)
        mean_BL{u}(j) = mean(SC{u}(j,before_inds));
        std_BL{u}(j) =   std(SC{u}(j,before_inds));
    end
end

%Resp_Thresh = norminv(0.95,0,1);
disp('remember to change line 44 in calcualte responses once the statistic toolbox is available !!!!!!!!!!!!! ')
Resp_Thresh = 1.5;

load resp_map; % a colormap for this studd
for u = 1:length(units)
    Ptmp = zeros(size(SC{u}));
    Ntmp = zeros(size(SC{u}));
    for j = 1:size(SC{u},1)
        Pos_resp_bins = find(SC{u}(j,:) > mean_BL{u}(j)+ Resp_Thresh*std_BL{u}(j));
        Ptmp(j,Pos_resp_bins) = 1;
        
        Neg_resp_bins = find(SC{u}(j,:) < mean_BL{u}(j)- Resp_Thresh*std_BL{u}(j));
        Ntmp(j,Neg_resp_bins) = 1;

    end
    % Get rid of isolated responses (i.e. response bins whos neighbours are not responses)
    fResp = Ptmp;
    fResp(:,2:end) = fResp(:,2:end) + Ptmp(:,1:end-1);
    fResp(:,1:end-1) = fResp(:,1:end-1) + Ptmp(:,2:end);
    Ptmp(find(fResp <= 1)) = 0;
    
    fResp = Ntmp;
    fResp(:,2:end) = fResp(:,2:end) + Ntmp(:,1:end-1);
    fResp(:,1:end-1) = fResp(:,1:end-1) + Ntmp(:,2:end);
    Ntmp(find(fResp <= 1)) = 0;
    Ntmp(find(Ntmp)) = -1; % now reverse the sign

    tmp = Ptmp+Ntmp;
    Resp{u} = tmp;    
end

if ~SEP_FIGS
    figure
end

set(gcf,'name',['RESPONSES per unit display ' sessionstr ])
set(gcf,'paperorientation','landscape')
%[Cs Rs] = best_subplot_dims(length(units));
Cs = 8;
Rs = 4;
for k = 1:32
        sh = subplot(Cs,Rs,k);
        set(sh,'xtick',[],'ytick',[])
        box on
end

for u = 1:length(units)
    if SEP_FIGS
        figure
    else
   %     ah(u) = subplot(Cs,Rs,units_ord(u));
         ah(u) = subplot(Cs,Rs,units(u));
    end
    imagesc(Resp{(u)},[-1 1])
       
    th = title(['ch ' num2str(units(u))]);
    set(th,'fontsize',6)
    if u == 1
         title([sessionstr ' channel ' num2str(units(u))])
    end
    
    %imagesc(SC{(u)})
    %title(['channel ' num2str(units(u))])
    if u == 1
        title([sessionstr ' channel ' num2str(units(u))])
    end
    hold on
    %%%%%%
    if SEP_FIGS
        for i = 1:length(uni_names)
            these = strmatch(uni_names{i},event_names);
            ph2 = plot(0,0,'.');
            hold on
            set(ph2,'color',co(i),'markerfacecolor',co(i));
            set(ph2,'markersize',8)
            legendstr{i} = uni_names{i};
        end
        legend(legendstr)
    end

    for i = 1:length(uni_names)
        these = strmatch(uni_names{i},event_names);
        for k = 1:length(these)
            thisX = Nbins * (event_times(these(k)) + Tb)/(Tb+Ta);
            rh = rectangle('position',[thisX-0.5 event_trials(these(k))-0.5 1 1]);
            %theseX = 0.5 + Nbins * (event_times(these) + Tb)/(Tb+Ta);
            set(rh,'facecolor',co(i),'edgecolor',co(i))
        end
    end


    if SEP_FIGS
        for ei = 1:length(prev_event_names)
            evstr = [prev_event_names{ei} ' @   ' num2str(round(prev_event_times(ei))) ' s              '];
            th = text(0, prev_event_trials(ei) + 0.5,evstr);
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
            th = text(0,j + 0.5,ostr);
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

    ll = Nbins+0.5;
    blocks = unique(block_tag);
    for i = 1:length(blocks)
        these = find(block_tag == blocks(i));
        lh = line([ll ll],[these(end)+0.5 these(1)-0.5]);
        th = text(ll+abs(ll)/20,mean(these),num2str(blocks(i)));
        set(th,'fontsize',6)
        set(lh,'linewidth',2)
        if ~rem(i,2)
            set(lh,'color','g')
        end
    end

    for i = 1:length(blocks) -1
        these = find(block_tag == blocks(i));
        lh2 = line([0 ll],[these(end)+0.5 these(end)+0.5]);
        set(lh2,'linewidth',1,'color','r')
    end

    xticks = [1:20:Nbins];
    set(gca,'xtick',xticks);
    set(gca,'ytick',[])
    set(gca,'fontsize',6)
    set(gca,'xticklabel',num2str(round(TimeVecCen(xticks))'));
%     colormap gray
%     C = colormap;
%     colormap(flipud(C))
    
    colormap(resp_map)
    
end

return


