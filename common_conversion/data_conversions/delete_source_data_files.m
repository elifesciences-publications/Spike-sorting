function delete_source_data_files(datadir);

ButtonName=questdlg(['Are you sure you want to delete Source files in ' datadir ' ?'],'Data processing','No','Yes','No');

switch ButtonName,
    case 'No',
        return
end % switch

% Get all Block directories
D = dir([datadir 'Block*']);

% Go into one by one
for i = 1:length(D)

    F = dir([datadir D(i).name filesep D(i).name '_Elec_chan*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_LFPs_chan*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_Tick*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_brrt*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_brrh*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_Swep*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_hart*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_hrrt*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_stof*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end
    F = dir([datadir D(i).name filesep D(i).name '_stim*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_stct*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_evsn*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end
    F = dir([datadir D(i).name filesep D(i).name '_tmev*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end

    F = dir([datadir D(i).name filesep D(i).name '_evtr*.mat']);
    for k = 1:length(F)
        disp(['deleting file ' datadir D(i).name filesep F(k).name])
        delete([datadir D(i).name filesep F(k).name])
    end



end


return
