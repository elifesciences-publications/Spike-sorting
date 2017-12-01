function mat2buz_contin_pershank(datadir,shank,sites);
% Interlace data from several files to generate data compatible with the
% Neuroscope format - this includes data files as well as event files.
% All files in the direcoty will be processed if they comply with the
% settings given here.

% takepart = 0;

% Outfile name
lastsep = max(find(datadir == filesep));
    
outfile = [datadir filesep datadir(lastsep+1:end) '_group' num2str(shank) '.dat'];

% Specify unique string codes for all electrode files:
contin_var_string{1} = 'Elec';

% Number of repetitions of each (you may want to replicate some events due to NeuroScope peculiarities)

% Do you have to sort by their numerical order ?
must_sort(1) = 1;
must_sort(2) = 0;
must_sort(3) = 0;


% find the upsample freqs by loading the info mat.
% infofile = [datadir filesep 'info.mat'];
% load infofile

all_cont_vars = [];
% Load all continuous channels
for i = 1:length(contin_var_string)
    % GEt relevant files
    thesefiles = dir([datadir  filesep '*' contin_var_string{i} '*.*']);

    for fn = 1:length(thesefiles)
        % find occurence of the word chan
        cI = findstr('chan_',thesefiles(fn).name);
        dI = findstr('.',thesefiles(fn).name);
        numcode(fn) = str2num(thesefiles(fn).name(cI+5:dI-1));
    end
    
    k = 1;
  
 
    %sites = shank-1 + [1:4:29];
    relinds = find(ismember(numcode,sites));
    realfiles = thesefiles(relinds);
    realcodes = numcode(relinds);
    
            
    

        
    % Load the files
    for j = 1:length(realfiles);
        load([datadir filesep realfiles(j).name]);
    end
    % make a list of variale names
    these_vars{i} = whos(['*' contin_var_string{i} '*' ]);    
    % sort them by their numbers    
    [tmp Inx]  = sort(realcodes);
    for fn = 1:length(these_vars{i})
        TMP(fn) = these_vars{i}(Inx(fn));
    end
    these_vars{i} = TMP;

    clear realcodes realfiles numcode TMP;
end

% Make a list of the variable names
vn = 1;
for i = 1:length(these_vars)
    for j = 1:length(these_vars{i})
        all_names{vn} = these_vars{i}(j).name;
        vn = vn+1;
    end
end

% % Truncate them to have the same length
% minlength = 10^20;
% for i = 1:length(all_names)
%     minlength = min(minlength,eval(['length(' all_names{i} ');']));
% end
% for i = 1:length(all_names)
%     eval([ all_names{i} ' = ' all_names{i} '(1:' num2str(minlength) ');' ]);
% end

% and write them into a single matrix
eval(['all_vars = ' all_names{1} ';'])
eval(['clear ' all_names{1} ';'])
pack
for i = 2:length(all_names)
    eval(['all_vars = [all_vars ; ' all_names{i} '];']);
    eval(['clear ' all_names{i} ';']);
    pack
end

% and reshape the them into a single column vector with interlacing
% elements as required by NeuroScope.
all_vars = reshape(all_vars,1,prod(size(all_vars)));
fid = fopen(outfile,'w');
COUNT = fwrite(fid,all_vars,'integer*2');
%COUNT = fwrite(fid,all_vars);
fclose(fid);

return
