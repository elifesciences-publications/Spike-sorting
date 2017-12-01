function newnames = addunderscorewhenneeded(oldnames);


for i = 1:length(oldnames)
    I = findstr('FU_',oldnames{i});
    if ~isempty(I)
        newnames{i} = [oldnames{i}(1:I-1) 'F_U_' oldnames{i}(I+3:end) ] ;
    else
        newnames{i} = oldnames{i};
    end
end
    
for i = 1:length(oldnames)
    I = findstr('MU_',oldnames{i});
    if ~isempty(I)
        newnames{i} = [oldnames{i}(1:I-1) 'M_U_' oldnames{i}(I+3:end) ] ;
    end
end

for i = 1:length(oldnames)
    I = findstr('PU_',oldnames{i});
    if ~isempty(I)
        newnames{i} = [oldnames{i}(1:I-1) 'P_U_' oldnames{i}(I+3:end) ] ;
    end
end

for i = 1:length(oldnames)
    I = findstr('AU_',oldnames{i});
    if ~isempty(I)
        newnames{i} = [oldnames{i}(1:I-1) 'A_U_' oldnames{i}(I+3:end) ] ;
    end
end

for i = 1:length(oldnames)
    I = findstr('EU_',oldnames{i});
    if ~isempty(I)
        newnames{i} = [oldnames{i}(1:I-1) 'E_U_' oldnames{i}(I+3:end) ] ;
    end
end
