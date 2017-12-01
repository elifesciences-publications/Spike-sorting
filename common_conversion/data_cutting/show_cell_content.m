function show_cell_content(var)
% Just a funciton to help me see the elements of a cell array


for i = 1:length(var)   
    disp([num2str(i) ': ' var{i}])
end


return