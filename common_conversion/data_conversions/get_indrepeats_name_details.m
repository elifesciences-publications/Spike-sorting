function [sex strain ind] = get_indrepeats_name_details(do_odors);
% get name details for the individual repeats experiments

for i = 1:length(do_odors)
    us = findstr(do_odors{i},'_');
    if length(us) == 4 % Then this is one of the mixes - not just female or male urine
        tmp_strain   = do_odors{i}(1:us(1)-1);
        sex{i}      = do_odors{i}(us(1)+1:us(2)-1);
        % find plus sign
        h = findstr(tmp_strain,'-');
        if length(h) == 1
            strain{i} = tmp_strain(1:h-1);
            ind{i} = tmp_strain(h+1:end);
        else
            disp('error: unexpectedly did not find a hyphen in the stimulus name')
        end
    else
        disp('error: expecting too find 4 underscores in the stimulation name')
    end
end

return