function mat2buz_event(datadir);

% Interlace data from several files to generate data compatible with the
% Neuroscope format - this includes data files as well as event files.

% All files in the direcoty will be processed if they comply with the
% settings given here.

% Should be made to run over all Block subdirectories.


% Outfile name
lastsep = max(find(datadir == filesep));
outfile = [datadir filesep datadir(lastsep+1:end) '.tdt.evt'];


% Specify event codes
%event_strings{1} = 'Tick';
event_strings{1} = 'stim';
event_strings{2} = 'evnt';
event_strings{3} = 'stof';
% event_strings{1} = 'Tick';
% event_strings{2} = 'hart';
% event_strings{3} = 'odor';
% event_strings{4} = 'vlon';

% event_table{1} = [];
% event_table{2} = [];

% This will have to be a a day specific thing which is saved in some ASCII
% file. Skip it for now.
% event_table{3}{1,1} = ;

% Load all continuous channels
for i = 1:length(event_strings)
    % Load them
    thesefiles = dir([datadir   filesep '*' event_strings{i} '*.*']);
    for j = 1:length(thesefiles);
         load([datadir filesep thesefiles(j).name])
    end
end

k = 1;
for i = 1:length(event_strings)
    tmp = whos(['*' event_strings{i} '*' ]);
    if ~isempty(tmp)
        var_names{k} = tmp.name;
        eval(['vars{k}      = ' tmp.name ';']);
        k = k + 1;
    end
end


k = 1;
% Insert their codes
for i = 1:length(vars)
    for j = 1:size(vars{i},2)
        event_time(k)       = 1000* vars{i}(2,j); % in ms
        event_name{k} = [var_names{i} '_' num2str(vars{i}(1,j))];
        k = k +1;
    end
end

% Sort them
[event_time I] = sort(event_time);
event_name = event_name(I);


% and reshape the them into a single column vector with interlacing
% elements as required by NeuroScope.
fid = fopen(outfile,'w');
for k = 1:length(event_name)
    fprintf(fid,'%1.2f  %s\n',event_time(k), event_name{k});
end
fclose(fid);

return
