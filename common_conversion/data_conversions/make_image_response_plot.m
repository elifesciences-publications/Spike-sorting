function make_image_response_plot(method,sessionstr,spike_trials,spike_times,Tb,Ta,CutTimes,BlockNames,event_times,event_trials,event_names,prev_event_times,prev_event_trials,prev_event_names,overlap,units,units_ord,block_tag);

%Tb = 40;
Ts = 3; % The time when stimulation ends
Ta1 = Ts+3;
Ta2 = Ts+6;
Ta3 = Ts+12;
Ta4 = Ts+20;

% Make a resvised list of the events, including those that occur within
% trials -
k = 1;
for i = 1:length(event_names)
    if isempty(strmatch('clean',event_names{i})) & isempty(strmatch('stimulation',event_names{i}))
        within_events{k} = event_names{i};
        within_times(k)  = event_times(i);
        within_trials(k)  = event_trials(i);
        if within_times(k) > 0
            within_trials(k) = within_trials(k) + 1;
        end
        k = k + 1;
    end
end
 
if exist('within_events')
    prev_event_names = [prev_event_names within_events]
    prev_event_trials = [prev_event_trials within_trials]

    [prev_event_trials inds] = sort(prev_event_trials);
    [prev_event_names] = prev_event_names(inds);
end

%co = 'mrgbcymrgbcymrgb';
%uni_names = unique(union(event_names,prev_event_names));
totntrials = length(block_tag);


% Create matrices with spike counts per trial
%BinSize = 0.5;
%timevec = [-Tb:BinSize:Ta];
for u = 1:length(spike_trials) % Over all units
    for i = 1:totntrials % over each trial
        trialspikes = spike_times{u}(spike_trials{u} == i);
        PostCounts1(u,i) = length(find(trialspikes > Ts & trialspikes <= Ta1))/(Ta1-Ts);
        PostCounts2(u,i) = length(find(trialspikes > Ts & trialspikes <= Ta2))/(Ta2-Ts);
        PostCounts3(u,i) = length(find(trialspikes > Ts & trialspikes <= Ta3))/(Ta3-Ts);
        PostCounts4(u,i) = length(find(trialspikes > Ts & trialspikes <= Ta4))/(Ta4-Ts);        
        PreCounts(u,i)  = length(find(trialspikes > -Tb  & trialspikes < 0))/Tb;
    end
end

switch method
    case 'minus baseline'
        resps1 = (PostCounts1 - PreCounts);
        resps2 = (PostCounts2 - PreCounts) ;
        resps3 = (PostCounts3 - PreCounts);
        resps4 = (PostCounts4 - PreCounts) ;                
    case 'minus baseline norm'
        resps1 = (PostCounts1 - PreCounts) ./PreCounts ;
        resps2 = (PostCounts2 - PreCounts) ./PreCounts ;
        resps3 = (PostCounts3 - PreCounts) ./PreCounts ;
        resps4 = (PostCounts4 - PreCounts) ./PreCounts ;
    case 'raw'
        resps1 = PostCounts1;
        resps2 = PostCounts2;
        resps3 = PostCounts3;
        resps4 = PostCounts4;
end
        
resps = max(max(resps1,resps2),max(resps3,resps4));

goodrespsH = max(PreCounts,resps);
goodrespsL = min(PreCounts,resps);
goodrespsH(find(isinf(goodrespsH))) = 0;
goodrespsL(find(isinf(goodrespsL))) = 0;

%resps = (PostCounts - PreCounts);
%resps = PostCounts;

% Normalize the ersponse of each unit across all trials
for i = 1:size(resps,1)
    resps(i,:) = resps(i,:)./max(resps(i,:));    
end

% Now, plot each of the responses, one by one
figure
for j = 1:36
   subplot(6,6,j)
   respcube = reshape(resps(:,j),4,8)';
   imagesc(respcube);  
end
colormap gray


for shank = 1:4
    
    did_leg = 0;
    
    figure
    set(gcf,'paperorientation','landscape');    
    set(gcf,'paperposition', [0.2500    0.2500   10.5000    8.0000]);
    set(gcf,'name',[sessionstr ' shank ' num2str(shank)],'numbertitle','off')
    
    %imagesc(resps)
    k = 1;
    xlims = [1 totntrials+1];
    for i = shank:4:32
        tu = find(units == i);
        subplot(8,1,k)

        %title(['chan ' num2str(i)])
        box on
        if ~isempty(tu)
            sh = stairs(resps(tu,:));
            set(sh,'color','b','linewidth',2);
            hold on
            sh = stairs(PreCounts(tu,:));
            set(sh,'color',[0.3 0.3 0.3],'linewidth',1);% ,'linestyle',':');                        
            
            %set(bh,'facecolor','c')
            ylims = [min(goodrespsL(tu,:)) max(goodrespsH(tu,:))*1.1 ];
            set(gca,'xlim',xlims,'ylim',ylims);
        else
            ylims = [0 1];
        end
        
        if k ==1
            title([sessionstr ' shank ' num2str(shank) ' Tb= ' num2str(Tb) ' Ts= ' num2str(Ts) ' method: ' method])
        end
        if ~isempty(tu) & ~did_leg            
            legend('resp','baseline')
            did_leg=1;
        end
        hold on

        set(gca,'xlim',xlims,'ylim',ylims);
        %  set(gca,'ylim',[-3 totntrials])
        if (~isempty(tu) | k == 8)
            for ei = 1:length(prev_event_names)
                lh = line([prev_event_trials(ei) prev_event_trials(ei)],[ylims ]);
                set(lh,'color','r','linewidth',2);
                if k == 8
                    if rem(ei,3) == 1
                        th = text(prev_event_trials(ei),ylims(1)-(abs(ylims(2)-ylims(1))*0.2),prev_event_names{ei});
                    elseif rem(ei,3) == 2
                        th = text(prev_event_trials(ei),ylims(1)-(abs(ylims(2)-ylims(1))*0.4),prev_event_names{ei});
                    else
                        th = text(prev_event_trials(ei),ylims(1)-(abs(ylims(2)-ylims(1))*0.6),prev_event_names{ei});
                    end
                                                
                    set(th,'interpreter','none','horizontalalignment','right')
                    set(th,'fontsize',8)
                end
            end

            blocks = unique(block_tag);
            for bi = 1:length(blocks)
                these = find(block_tag == blocks(bi));
                lh = line([these(1) these(end)+1],[ylims(1) ylims(1)]);
                set(lh,'linewidth',4);
                lh2 = line([these(end)+1 these(end)+1],[ylims]);
                set(lh2,'color','k','linewidth',0.5);
                
                if k == 8
                    th = text(mean(these),ylims(1),num2str(blocks(bi)));
                    set(th,'fontsize',6,'fontweight','bold')
                    set(lh,'linewidth',8);
                end
                if ~rem(bi,2)
                    set(lh,'color',[0.75 0.75 0.75]);
                else
                    set(lh,'color',[0.97 0.97 0.97]);
                end
            end
        end

        hold on
        % Plot again for the good looks
        if ~isempty(tu)
            sh = stairs(resps(tu,:));
            set(sh,'color','b','linewidth',2);
            hold on
            sh = stairs(PreCounts(tu,:));
            set(sh,'color',[0.3 0.3 0.3],'linewidth',1); %,'linestyle',':');                        
            
            %set(bh,'facecolor','c')
            ylims = [min(goodrespsL(tu,:)) max(goodrespsH(tu,:))*1.1 ];
            set(gca,'xlim',xlims,'ylim',ylims);

        end

        ylabel(['chan ' num2str(i)])
        k = k + 1;
        set(gca,'xtick',[]);
    end
end

return

