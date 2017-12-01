function [sorted_spikes , hh_widths ] = temp_width(spikes,toplot);
% Sort the spikes according to their widths (half widths at half height)
% Spikes is a matrix where each row is one spike, and each column is a sample
% Accepts the NormShapes input generated by [Source,Shapes,Ns,NormShapes] = make_spikeshape_struct;
% YBS - 17apr02


[abs_maxs abs_maxinds] = max(abs(spikes),[],2);

[maxs         maxinds] = max(spikes,[],2);

% Find which spike have a positive peak, and which have a negative peak. 
pos_peak = [maxs == abs_maxs];

% Spikes that have a negative peak are reversed to have a positive peak:
spikes(find(~pos_peak),:) = -spikes(find(~pos_peak),:);


% For each spike get the half widths at half height
for i = 1:length(maxs)
    thismax = abs_maxs(i);   
    peakind = abs_maxinds(i);   
    % Find first drop to half height after peak:
    firstdrop(i) = peakind + min(find(spikes(i,peakind:end) < thismax/2));
    
    if isempty(firstdrop(i))
        firstdrop(i) = size(spikes,2);
    end
    
    % Find first rise to half height before peak:
    firstrise(i) = min(find  (     spikes(i,1:peakind)       > thismax/2));
    
    if isempty(firstrise(i))
        firstrise(i) = 1;
    end
    
    % get the widths:
    hh_widths(i) = firstdrop(i) - firstrise(i);
end


[sorted inds] = sort(hh_widths);
sorted_spikes = spikes(inds,:);
firstrise     = firstrise(inds);
firstdrop     = firstdrop(inds);
hh_widths     = hh_widths(inds);

Ylims = 1.1* [min(min(spikes)) max(max(spikes))];
Xlims =      [0                size(spikes,2)];

if toplot
    figure
    takeinds = [1:10:size(spikes,1)];
    if takeinds(end) ~= size(spikes,1)
        takeinds = [takeinds size(spikes,1)];
    end
    for k = 1:length(takeinds)
        ti = takeinds(k);
        hold off
        plot(sorted_spikes(ti,:));
        hold on
        plot([firstrise(ti):firstdrop(ti)],sorted_spikes(ti,firstrise(ti):firstdrop(ti)),'r');
        title([num2str(ti) ' of ' num2str(size(spikes,1))]);
        set(gca,'xlim',Xlims,'ylim',Ylims);
        pause
    end
    R = input('continue ?');
end

    
    

return
