function show_position;


figure
Ah = axes;
set(Ah,'xlim',[0 1],'ylim',[0 9],'xtick',[],'ytick',1:8,'box','on');

for i = 1:8
    line([0 1],[i i],'linewidth',2);
end
clh = line([0.2 0.3],[2 2],'color','r','linewidth',5);
xlabel('Time (within current file)');
ylabel('channel');
title('current position');

