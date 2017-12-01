function [down_SL,up_SL,up_start,down_start] = get_response_segment_lengths(a,up_thresh,down_thresh);
% Returns lengths of continuous segment that are above and below given threshold as well as starting indices of these times
% THere is a debug option for showing the results
% For EXAMPLE
% a = [1 2 3 4 3 2 1 1 1 1 2 3 4 5 4 3 2 1  1 1 1 1 1 2 3 4 3 2 1 1 1 1 2 3 4 5 4 3 2 1  1 1 1 1 ];
% up_thresh = 3.2;
% down_thresh = 2.1;


down_SL      = [];
up_SL           = [];
down_start   = [];
up_start        = [];

DEBUG = 0;

thresh = up_thresh;
% This funny thing here it to take care of say all samples being above threshold
a1 = [-1 a];
up   = find((diff(a1) & a1(2:end) > thresh) & a1(1:end-1) <= thresh);
down = find((diff(a1) & a1(2:end) <= thresh) & a1(1:end-1) > thresh);
up = up -1;
down = down -1;

% Finding positive responses
k = 1;
for i = 1:length(up)
    next_down = min(find(down > up(i)));
    if ~isempty(next_down)
        up_segment{k} = [up(i)+1:down(next_down)];
        up_SL(k)     = length(up_segment{k});
        up_start(k)  = up(i)+1;
        k = k + 1;
    elseif i == length(up)
        up_segment{k} = [up(i)+1:length(a)];
        up_SL(k)   = length(up_segment{k});
        up_start(k)  = up(i)+1;        
        k = k + 1;
    end
end


thresh = down_thresh;
% This funny thing here it to take care of say all samples being above
% threshold
a2 = [inf a];
up   = find((diff(a2) & a2(2:end) >= thresh) & a2(1:end-1) < thresh);
down = find((diff(a2) & a2(2:end) < thresh) & a2(1:end-1) >= thresh);
up = up -1;
down = down -1;

% Finding negative responses
k = 1;
for i = 1:length(down)
    next_up = min(find(up > down(i)));
    if ~isempty(next_up)
        down_segment{k} = [down(i)+1:up(next_up)];
        down_SL(k)   = length(down_segment{k});
        down_start(k)  = down(i)+1;        
        k = k + 1;
    elseif i == length(down) % If this is the last down segment
        down_segment{k} = [down(i)+1:length(a)];
        down_SL(k)   = length(down_segment{k});
        down_start(k)  = down(i)+1;                
        k = k + 1;
    end
end

if  DEBUG
        
    close
    figure; plot(a)
    hold on
    plot(a,'*')

    for i = 1:length(up_SL)
        hold on
        plot(up_segment{i},a(up_segment{i}),'r')
        plot(up_segment{i},a(up_segment{i}),'r*')
    end
    for i = 1:length(down_SL)
        hold on
        plot(down_segment{i},a(down_segment{i}),'g')
        plot(down_segment{i},a(down_segment{i}),'g*')        
    end
    lh = line([1 length(a)],[up_thresh up_thresh])
    set(lh,'color','r')
    lh = line([1 length(a)],[down_thresh down_thresh])
    set(lh,'color','g')
    
    
    title([num2str(down_thresh) '  ' num2str(up_thresh)])
    
end



return
