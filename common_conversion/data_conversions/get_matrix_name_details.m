function [sex strains] = get_matrix_name_details(do_odors); 
% Get the matrix name details - meaning which strains are in the mixture, what is the sex - 
% The assumption is that this is urine

for i = 1:length(do_odors)
    us = findstr(do_odors{i},'_');
    if length(us) == 4 % Then this is one of the mixes - not just female or male urine
        tmp_strain   = do_odors{i}(1:us(1)-1);
        sex{i}      = do_odors{i}(us(1)+1:us(2)-1);
        % find plus sign
        ps = findstr(tmp_strain,'+');
        if isempty(ps)
        strains{i,1} = tmp_strain;
        strains{i,2} = '';
        strains{i,3} = '';
        elseif length(ps) == 1
        strains{i,1} = tmp_strain(1:ps-1);                        
        strains{i,2} = tmp_strain(ps+1:end);
        strains{i,3} = '';
        elseif length(ps) == 2
        strains{i,1} = tmp_strain(1:ps(1)-1);                        
        strains{i,2} = tmp_strain(ps(1)+1:ps(2)-1);
        strains{i,3} = tmp_strain(ps(2)+1:end);
        end                    
    elseif length(us) == 3 
        strains{i,1}   = '';
        strains{i,2}   = '';
        strains{i,3}   = '';
        sex{i}      = do_odors{i}(1:us(1)-1);;
    end
end

return