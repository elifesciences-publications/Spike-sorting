% make a list of all sessions in data base, report inconsistencies and
% missing data
clear

load('c:\data\session_info.mat');
session_info1 = session_info;
clear session_info;
load('c:\data\call_process_params.mat');
[session_info2] = convert_callprocessparams2sessioninfo(call_process_params);

% This is an MOB recording that is not corectly written - and makes
% problems when I try to make_amygdala data
for i = 1:length(session_info2)
    if strcmp(session_info2(i).date,'05jun09')
        thisone = i;
    end
end
session_info2(thisone) = [];

session_info1 = orderfields(session_info1);
session_info2 = orderfields(session_info2);

save('c:\data\session_info2','session_info2')


% make a unit list of all the sessions - a session is identified by its
% date and site

n1 = length(session_info1);
n2 = length(session_info2);

k = 1;
for i = 1:n1
    all_full_session_names{k} = [session_info1(i).date '_' num2str(session_info1(i).site)];
    all_session_sort_code = datenum(session_info1(i).date)+session_info1(i).site/10;
    all_source(k) = 1;
    all_session_info(k) = session_info1(i);
    k = k + 1;    
end


for i = 1:n2
    all_full_session_names{k} = [session_info2(i).date '_' num2str(session_info2(i).site)];
    all_session_sort_code = datenum(session_info2(i).date)+session_info2(i).site/10;
    all_source(k) = 2;
    all_session_info(k) = session_info2(i);
    
    
    
    
    k = k + 1;
end

% sort the sessions by the all_full_session_names
[tmp ind] = sort(all_session_sort_code);

for i = 1:length(all_full_session_names)
    disp(all_full_session_names{i});
end

% now go over all sessions again - choose the YBS sessions first, because
% Joe took some early sessions from YBS (that's me) and we therefore have
% duplicates.
un = unique(all_full_session_names);
k = 1;
for i = 1:length(un)
    these = strmatch(un{i},all_full_session_names);
    
    if length(these) == 2
        clear thissource;
        for j = 1:length(these)
            thissource(j) = all_source(these(j));
        end
        % find the one that is from me
        rel = find(thissource == 1);
        if ~(length(rel) == 1)
            disp(['session ' un{i} ' is represented ' num2str(length(these)) ' times - and it is not once from each source database']);
            return
        else
            session_info(k) = all_session_info(these(rel));
            k = k + 1;
        end
    elseif length(these) == 1
        session_info(k) = all_session_info(these);
        k = k + 1;
    else
        disp(['session ' un{i} ' is represented ' num2str(length(these)) ' times - and it is not once from each source database'])
        return
    end   
end


k = 1;
n = length(session_info);
for i = 1:n   
    full_session_names{k} = [session_info(i).date '_' num2str(session_info(i).site)];    
    k = k + 1;    
end

for i = 1:length(un)
    these = strmatch(un{i},full_session_names);
    if ~(length(these) == 1)
        disp(['session ' un{i} ' is not represented exactly once as it should be  - please correct problem'])
    end
end

% make a list of unique experiment types
for k = 1:length(session_info)
exp_types{k} = getfield(session_info(k),'experiment_type');
end
un_exp_types = unique(exp_types);
for k = 1:length(un_exp_types)
    these = strmatch(un_exp_types{k},exp_types);
    disp([un_exp_types{k} ' : n = ' num2str(length(these))])
end
 
for k = 1:length(session_info)
sex_types{k} = getfield(session_info(k),'mouse_sex');
end
un_sex_types = unique(sex_types);
for k = 1:length(un_sex_types)
    these = strmatch(un_sex_types{k},sex_types);
    disp([un_sex_types{k} ' : n = ' num2str(length(these))])
end
    
% Make a list of all the sessions:
for i = 1:length(session_info)
    disp([num2str(i) ' ' session_info(i).date ' site' num2str(session_info(i).site) ' sex: ' session_info(i).mouse_sex ' exp: ' session_info(i).experiment_type])
end


save ('c:\data\combined_session_info','session_info')

return
