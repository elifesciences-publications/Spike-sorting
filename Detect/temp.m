
DSi = [ 1 2 4 6 7 8 11 13 15 19 20 21 22 30 33 34 35 36 37 38 48];
%DSi = [  ];


% Go over all dense spikes
dind = 1;
done = 0;
if ~isempty(DSi)
    while  ~done
        not_this_done = 1;
        k = 1;
        these_guys = [];
        these_guys(k) = DSi(dind);       
        while dind < length(DSi) & not_this_done            
            dind = dind + 1;        
            if (DSi(dind) - these_guys(k)) == 1
                k = k + 1;   
                these_guys(k) = DSi(dind);
            else
                not_this_done = 0;             
            end
        end
        if these_guys(k) == DSi(end)
            done = 1;
        end
        % Take care of deleting these guys:
        disp(these_guys)
    end
end

