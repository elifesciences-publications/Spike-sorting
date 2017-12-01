% Read Joe's - data files
function [session_info] = callprocessparams2sessioninfo(call_process_params);

N = length(call_process_params.filename)

%clear session_info
for i = 1:N
    session_info(i).date = call_process_params.filename{i};
    session_info(i).site = str2num(call_process_params.site{i}(5:end)); % Joe uses 'site1' whereas I use the number 1.
    session_info(i).experiment_type = call_process_params.experiment_type{i};
    session_info(i).experimenter = call_process_params.experimenter{i};
    session_info(i).target_goal = call_process_params.target_goal{i};
    session_info(i).most_likely_actual_goal = call_process_params.most_likely_actual_goal{i};
    session_info(i).mouse_sex = upper(call_process_params.sex{i}(1)); % Joe uses 'male' or 'female' whereas I use 'M' or 'F';
    session_info(i).mouse_estrus_stage = call_process_params.mouse_estrus_stage{i};
    session_info(i).mouse_strain = call_process_params.mouse_strain{i};
    session_info(i).mouse_age_weeks = call_process_params.mouse_age_weeks{i};
    
    if strcmp(call_process_params.stereotaxic{i}{1,1},'AP')
        session_info(i).AP = call_process_params.stereotaxic{i}{2,1};
    else
        disp('problem with format conversion in AP')
    end
    
    if strcmp(call_process_params.stereotaxic{i}{1,2},'ML')
        session_info(i).ML = call_process_params.stereotaxic{i}{2,2};
    else
        disp('problem with format conversion in ML')
    end
    
    if strcmp(call_process_params.stereotaxic{i}{1,3},'DV')
        session_info(i).Z = call_process_params.stereotaxic{i}{2,3};
    else
        disp('problem with format conversion in Z/DV')
    end
    
    session_info(i).coordinate_location = call_process_params.coordinate_location{i};
    if call_process_params.probe_angle{i} == 0
        session_info(i).probe_angle = call_process_params.probe_angle{i} + 90;  % Joe calls 0 what I cann 90
    end
    
    session_info(i).probe = call_process_params.probe{i};
    session_info(i).probe_type = call_process_params.probe_type{i};
    session_info(i).z_spacing = call_process_params.z_spacing{i};
    session_info(i).hor_sep = call_process_params.hor_sep{i};
    session_info(i).shanks = call_process_params.shanks{i};
    
    session_info(i).include = call_process_params.include{i};
    
    
    tmp_names = call_process_params.unit_info{i}.names;
    clear unit_names;
    for uni = 1:length(tmp_names)
        unit_names(uni) = str2num(tmp_names{uni});
    end
    
    
    session_info(i).unit_names =   unit_names';
    
    % we need to do a little conversion
    tmp_grades =  call_process_params.unit_info{i}.grades;
    clear unit_grades;
    for tg = 1:length(tmp_grades)
        switch lower(tmp_grades{tg})
            case 'c'
                unit_grades{tg} = 'contaminated single';
            case 's'
                unit_grades{tg} = 'single';
            case 'm'
                unit_grades{tg} = 'MUA';
            otherwise
                unit_grades{tg} = tmp_grades{tg};
        end
    end
    
    session_info(i).unit_grades =   unit_grades';
    session_info(i).unit_shapes =   call_process_params.unit_info{i}.shapes';
    session_info(i).unit_stability =   call_process_params.unit_info{i}.stability';
    
end




