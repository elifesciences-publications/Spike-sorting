function [sex strain stuff] = get_name_details(do_odors); 

for i = 1:length(do_odors)
    us = findstr(do_odors{i},'_');
    if length(us) >= 3 & ~strcmp(do_odors{i}(1),'A') % which is artificial urine
        strain{i}   = do_odors{i}(1:us(1)-1);
        sex{i}      = do_odors{i}(us(1)+1:us(2)-1);
        stuff{i}    = do_odors{i}(us(2)+1:us(3)-1);
    elseif length(us) >= 3 & strcmp(do_odors{i}(1),'A') % which is artificial urine
        strain{i}   = 'con';
        sex{i}      = 'con';
        stuff{i}    = 'con'; 
    elseif length(us) == 2
        sex{i} = 'con';
        strain{i} = 'con';
        stuff{i} = 'con';
    else
        sex{i} = '';
        strain{i} = '';
        stuff{i} = '';
    end
end

return