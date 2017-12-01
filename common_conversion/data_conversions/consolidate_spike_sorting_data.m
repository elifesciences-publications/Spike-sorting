% Consolidate essential spike sorting data into one directory

basedir = '/home/yoram/DATA/TDTDATA/';
destdir = '/home/yoram/DATA/TDTDATA/Essential_Sorting_Data';

dirs = dir(basedir)

for i = 1:length(dirs)
    dirname = dirs(i).name;
    if ~isempty(str2num(dirname(1))) % meaning it starts with a numeroal, i.e. a date
        disp(['will look for data in ' dirname]);
        datedir = [basedir dirname filesep 'mat'];
        sitedirs = dir([datedir filesep 'site*']);
        if ~isempty(sitedirs)
            for k = 1:length(sitedirs)
                disp([' and will look for data in ' sitedirs(k).name]);
                fullsitename = [datedir filesep sitedirs(k).name];
                fulldestsitedir = [destdir filesep dirname filesep sitedirs(k).name];
                if ~(exist(fulldestsitedir,'dir') == 7)
                    mkdir(fulldestsitedir)
                end

                matfiles = dir([fullsitename filesep '*.mat'])
                for msn = 1:length(matfiles)
                    thismatfile = [fullsitename filesep matfiles(msn).name];
                    eval(['!cp ' thismatfile ' ' fulldestsitedir])
                end




                groupnames = dir([fullsitename filesep 'group*'])
                for l = 1:length(groupnames)
                    fullgroupname = [fullsitename filesep groupnames(l).name];
                    disp(['  will look for data in ' fullgroupname]);
                    relfiles = dir([fullgroupname filesep '*.res.*']);
                    for m = 1:length(relfiles)
                        fullname = [fullgroupname filesep relfiles(m).name];
                        thisdestdir =  [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name ];
                        if ~(exist(thisdestdir,'dir') == 7)
                            mkdir(thisdestdir)
                        end
                        destfile = [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name filesep relfiles(m).name];
                        disp(['will copy '  fullname  ' to ' thisdestdir '  ...']);
                        eval(['!cp ' fullname ' ' thisdestdir])
                    end

                    relfiles = dir([fullgroupname filesep '*.fet.*']);
                    for m = 1:length(relfiles)
                        fullname = [fullgroupname filesep relfiles(m).name];
                        thisdestdir =  [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name ];
                        if ~(exist(thisdestdir,'dir') == 7)
                            mkdir(thisdestdir)
                        end
                        destfile = [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name filesep relfiles(m).name];
                        disp(['will copy '  fullname  ' to ' thisdestdir '  ...']);
                        eval(['!cp ' fullname ' ' thisdestdir])
                    end

                    relfiles = dir([fullgroupname filesep '*.xml.*']);
                    for m = 1:length(relfiles)
                        fullname = [fullgroupname filesep relfiles(m).name];
                        thisdestdir =  [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name ];
                        if ~(exist(thisdestdir,'dir') == 7)
                            mkdir(thisdestdir)
                        end
                        destfile = [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name filesep relfiles(m).name];
                        disp(['will copy '  fullname  ' to ' thisdestdir '  ...']);
                        eval(['!cp ' fullname ' ' thisdestdir])
                    end

                    relfiles = dir([fullgroupname filesep '*.*clu.*']);
                    for m = 1:length(relfiles)
                        fullname = [fullgroupname filesep relfiles(m).name];
                        thisdestdir =  [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name ];
                        if ~(exist(thisdestdir,'dir') == 7)
                            mkdir(thisdestdir)
                        end
                        destfile = [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name filesep relfiles(m).name];
                        disp(['will copy '  fullname  ' to ' thisdestdir '  ...']);
                        eval(['!cp ' fullname ' ' thisdestdir])
                    end


                    relfiles = dir([fullgroupname filesep '*.*model.*']);
                    for m = 1:length(relfiles)
                        fullname = [fullgroupname filesep relfiles(m).name];
                        thisdestdir =  [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name ];
                        if ~(exist(thisdestdir,'dir') == 7)
                            mkdir(thisdestdir)
                        end
                        destfile = [destdir filesep dirname filesep sitedirs(k).name filesep groupnames(l).name filesep relfiles(m).name];
                        disp(['will copy '  fullname  ' to ' thisdestdir '  ...']);
                        eval(['!cp ' fullname ' ' thisdestdir])
                    end

                end
            end
        end
    end
end
