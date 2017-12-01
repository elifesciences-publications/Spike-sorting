function make_per_units_displays(sessionstr,spike_trials,spike_times,Tb,Ta,BinSize,CutTimes,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,units_ord,block_tag);

co = 'mrgbcy';
uni_names = unique(union(event_names,prev_event_names));
totntrials = length(block_tag);

% Create matrices with spike counts per trial
BinSize = 0.5;
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
% Clip the maximum values to MaxRate
MaxRate = 30;
for u = 1:length(SC)
    SC{u}(find(SC{u} > MaxRate)) = MaxRate;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:length(timevec)-1
    TimeVecCen(j) = mean([timevec(j) timevec(j+1)]);
end

[Ntrials Nbins ] = size(SC{1});
Nunits = length(SC);


figure
set(gcf,'name',['per unit display ' sessionstr ])
[Cs Rs] = best_subplot_dims(length(units));
for u = 1:length(units)
    %figure(fh1)
    ah(u) = subplot(Cs,Rs,units_ord(u));
    imagesc(SC{(u)})
    title(['channel ' num2str(units(u))])
    if u == 1
         title([sessionstr ' channel ' num2str(units(u))])
    end
    hold on
    %%%%%%
    for i = 1:length(uni_names)
        these = strmatch(uni_names{i},event_names);
        for k = 1:length(these)
            thisX = Nbins * (event_times(these(k)) + Tb)/(Tb+Ta);
            rh = rectangle('position',[thisX-0.5 event_trials(these(k))-0.5 1 1]);
            %theseX = 0.5 + Nbins * (event_times(these) + Tb)/(Tb+Ta);
            set(rh,'facecolor',co(i),'edgecolor',co(i))
        end
        % Since I cannot show overlap value in such a small space, I will show the overlap color       
        for j = 1:length(overlap)
            if isnan(overlap(j))
                ostr = '';
            else
                if overlap(j) < 0
                    rh = rectangle('position',[0.5 j-0.5 2 1],'facecolor','r','edgecolor','r','curvature',[1 1]);
%                 else
%                     rh = rectangle('position',[0.5 j-0.5 1 1],'facecolor','r');
                end
            end
           
        end
        ll = Nbins+0.5;
        blocks = unique(block_tag);
        for i = 1:length(blocks)
            these = find(block_tag == blocks(i));
            lh = line([ll ll],[these(end)+0.5 these(1)-0.5]);
            text(ll+abs(ll)/20,mean(these),num2str(blocks(i)));
            set(lh,'linewidth',2)
            if ~rem(i,2)
                set(lh,'color','r')
            end
        end

    end
    
    xticks = [1:20:Nbins];
    set(gca,'xtick',xticks);
    set(gca,'ytick',[])
    set(gca,'fontsize',6)
    set(gca,'xticklabel',num2str(round(TimeVecCen(xticks))'));    
    colormap gray
    C = colormap;
    colormap(flipud(C))
    
end




return


