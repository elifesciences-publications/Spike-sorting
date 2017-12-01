function clean_data_files(datestr);
% Delete all files with 
% _Elec_
% _LFPs_

CLEAR_ELEC = 0;
CLEAR_LFP = 1;


% The site does not matter here so I use a value of 1
[datadir,combined_datadir,blocks,PC_block,groups] = get_session_info(datestr,1);


dirs = dir([datadir filesep 'Block-*'])

mstr{1} = ['Are you sure you want to remove all'];
if CLEAR_ELEC & CLEAR_LFP
    mstr{2} = 'Elec and LFPs files in directory';
elseif   CLEAR_ELEC
    mstr{2} = 'Elec files in directory';
else
    mstr{2} = 'LFP files in';
end
mstr{3} = datadir;
mstr{4} = ' for blocks:'
for i = 1:length(dirs)
    mstr{i+4} = dirs(i).name;
end

ButtonName=questdlg(mstr,'delete files','cancel','continue','cancel');
switch ButtonName,
    case 'cancel',
        return
end % switch


fc = 1;
bytes = 0;
for i = 1:length(dirs)
    if CLEAR_ELEC
    thesefiles = dir([datadir filesep  dirs(i).name filesep '*_Elec_*']);
    for j = 1:length(thesefiles)
        eval(['!rm -f ' datadir filesep  dirs(i).name filesep thesefiles(j).name]);
        fc = fc + 1;
        bytes = bytes + thesefiles(i).bytes;
    end
    end
    
    if CLEAR_LFP
    thesefiles = dir([datadir filesep  dirs(i).name filesep '*_LFPs_*']);
    for j = 1:length(thesefiles)
        eval(['!rm -f ' datadir filesep  dirs(i).name filesep thesefiles(j).name]);
        fc = fc + 1;
        bytes = bytes + thesefiles(i).bytes;
    end
    end
end

msgbox(['Deleted a total of ' num2str(fc) ' files totalling ' num2str(bytes/1000000) ' megabytes']);


return















return

