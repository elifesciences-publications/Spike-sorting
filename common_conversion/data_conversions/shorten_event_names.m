function short_names = shorten_event_names(long_names);
% Abbreviate event names to save space on figrue displays












for i = 1:length(long_names)
    if strcmp(long_names{i},'start clean')
        short_names{i} = 'clS';
    elseif strcmp(long_names{i},'stop clean')
        short_names{i} = 'clE';
    elseif strcmp(long_names{i},'stimulation off')
        short_names{i} = 'stimS';
    elseif strcmp(long_names{i},'stimulation')
        short_names{i} = 'stimE';
    elseif ~isempty(findstr('Ringer''s',long_names{i}))
        short_names{i} =  long_names{i}(length('Ringer''s')+1 :end);
        short_names{i} = ['R' short_names{i}];
    elseif ~isempty(findstr('comment',long_names{i}))
        short_names{i} =  long_names{i}(length('comment')+1 :end);
        short_names{i} = ['com' short_names{i}];


    elseif strcmp('MOS Ringers',long_names{i})
        short_names{i} = ['MOS Ringers'];
    elseif strcmp('*VNS* Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['VNS-M_U_100F_2ul'];
    elseif strcmp('MOS Male Urine',long_names{i})
        short_names{i} = ['MOS-M_U_10F_x'];
    elseif strcmp('*VNS* Ringers_1F_2ul',long_names{i})
        short_names{i} = ['VNS Ringers'];
    elseif strcmp('*VNS* Predator Urine_100F_2ul',long_names{i})
        short_names{i} = ['VNS-P_U_100F_2ul'];
    elseif strcmp('MOS Predator Urine',long_names{i})
        short_names{i} = ['MOS-P_U_10F_x'];
    elseif strcmp('MOS Female Urine',long_names{i})
        short_names{i} = ['MOS-F_U_10F_x'];
    elseif strcmp('*VNS* Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['VNS-F_U_100F_2ul'];
     
    elseif strcmp('*MOS* Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['MOS-M_U_10F_x'];
    elseif strcmp('*MOS* Predator Urine_100F_2ul',long_names{i})
        short_names{i} = ['MOS-P_U_10F_x'];
    elseif strcmp('*MOS* Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['MOS-F_U_10F_x'];        
    elseif strcmp('*VNS+MOS* Predator Urine_100F_2ul',long_names{i})
        short_names{i} = ['MOSVNS-P_U_F_x'];
    elseif strcmp('*VNS+MOS* Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['MOSVNS-F_U_F_x'];
    elseif strcmp('*VNS+MOS* Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['MOSVNS-M_U_F_x'];
     elseif strcmp('*VNS+MOS* Ringers_1F_2ul',long_names{i})
        short_names{i} = ['MOSVNS-R_1F_x'];        
        
        
    elseif strcmp('HIGHLOW C57 M4 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['HIGHLOWC57-4_M_U_100F_2ul'];
    elseif strcmp('HIGHLOW BC M1 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['HIGHLOWBC-1_M_U_100F_2ul'];
    elseif strcmp('HIGH BC M1 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['HIGHBC-1_M_U_100F_2ul'];
    elseif strcmp('LOW BC M1 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['LOWBC-1_M_U_100F_2ul'];
    elseif strcmp('HIGH C57 M4 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['HIGHC57-4_M_U_100F_2ul'];
    elseif strcmp('LOW C57 M4 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['LOWC57-4_M_U_100F_2ul'];
    elseif strcmp('HIGH CBA M3 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['HIGHCBA-3_M_U_100F_2ul'];
    elseif strcmp('LOW CBA M3 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['LOWCBA-3_M_U_100F_2ul'];

    elseif strcmp('BC M1 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['BC-1_M_U_100F_2ul'];
    elseif strcmp('BC M1B Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['BC-1B_M_U_100F_2ul'];
    elseif strcmp('BC M2 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['BC-2_M_U_100F_2ul'];

    elseif strcmp('C57 M2 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['C57-2_M_U_100F_2ul'];
    elseif strcmp('C57 M2B Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['C57-2B_M_U_100F_2ul'];
    elseif strcmp('C57 M4 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['C57-4_M_U_100F_2ul'];

    elseif strcmp('CBA M1 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['CBA-1_M_U_100F_2ul'];
    elseif strcmp('CBA M1B Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['CBA-1B_M_U_100F_2ul'];
    elseif strcmp('CBA M3 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['CBA-3_M_U_100F_2ul'];

    elseif strcmp('B6+CBA Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['B6+CBA_M_U_100F_2ul'];
    elseif strcmp('BC Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['BC_M_U_100F_2ul'];
    elseif strcmp('BC+CBA Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['BC+CBA_M_U_100F_2ul'];
    elseif strcmp('BC+B6 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['BC+B6_M_U_100F_2ul'];
    elseif strcmp('F Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['FVB_M_U_100F_2ul'];
    elseif strcmp('F+B6 Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['FVB+B6_M_U_100F_2ul'];
    elseif strcmp('F+BC Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['FVB+BC_M_U_100F_2ul'];
    elseif strcmp('F+CBA Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['FVB+CBA_M_U_100F_2ul'];
    elseif strcmp('Mixed Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['F_U_100F_2ul'];
    elseif strcmp('BC+B6+CBA Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['M_U_100F_2ul'];
    elseif strcmp('BC+B6+CBA Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['F_U_100F_2ul'];
    elseif strcmp('BC+B6+CBA Male Saliva_1F_2ul',long_names{i})
        short_names{i} = ['M_S_1F_2ul'];
    elseif strcmp('BC+B6+CBA Female Saliva_1F_2ul',long_names{i})
        short_names{i} = ['F_S_1F_2ul'];
    elseif strcmp('High Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['H-F_U_100F_2ul'];
    elseif strcmp('High Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['H-M_U_100F_2ul'];
    elseif strcmp('High Predator Urine_100F_2ul',long_names{i})
        short_names{i} = ['H-P_U_100F_2ul'];
    elseif strcmp('Low Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['L-F_U_100F_2ul'];
    elseif strcmp('Low Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['L-M_U_100F_2ul'];
    elseif strcmp('Low Predator Urine_100F_2ul',long_names{i})
        short_names{i} = ['L-P_U_100F_2ul'];
    elseif strcmp('Male+Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['M+F_U_100F_2ul'];
    elseif strcmp('Predator+Female Urine_100F_2ul',long_names{i})
        short_names{i} = ['P+F_U_100F_2ul'];
    elseif strcmp('Predator+Male Urine_100F_2ul',long_names{i})
        short_names{i} = ['P+M_U_100F_2ul'];
    elseif strcmp('Predator Urine_100F_2ul',long_names{i})
        short_names{i} = ['P_U_100F_2ul'];



    elseif ~isempty(findstr('B6 Female Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('B6 Female Urine')+1 :end);
        short_names{i} = ['B6_F_U' short_names{i}];
    elseif ~isempty(findstr('B6 Male Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('B6 Male Urine')+1 :end);
        short_names{i} = ['B6_M_U' short_names{i}];
    elseif ~isempty(findstr('B6 MALE Urine',long_names{i})) % in some versions I have this name in full caps, this should be changed
        short_names{i} =  long_names{i}(length('B6 Male Urine')+1 :end);
        short_names{i} = ['B6_M_U' short_names{i}];
    elseif ~isempty(findstr('BALBC Female Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('BALBC Female Urine')+1 :end);
        short_names{i} = ['BC_F_U' short_names{i}];
    elseif ~isempty(findstr('BALBC Male Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('BALBC Male Urine')+1 :end);
        short_names{i} = ['BC_M_U' short_names{i}];
    elseif ~isempty(findstr('FVB Female Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('FVB Female Urine')+1 :end);
        short_names{i} = ['FVB_F_U' short_names{i}];
    elseif ~isempty(findstr('FVB Male Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('FVB Male Urine')+1 :end);
        short_names{i} = ['FVB_M_U' short_names{i}];
    elseif ~isempty(findstr('CBA Female Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('CBA Female Urine')+1 :end);
        short_names{i} = ['CBA_F_U' short_names{i}];
    elseif ~isempty(findstr('CBA Male Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('CBA Male Urine')+1 :end);
        short_names{i} = ['CBA_M_U' short_names{i}];
    elseif ~isempty(findstr('CBA MALE Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('CBA Male Urine')+1 :end);
        short_names{i} = ['CBA_M_U' short_names{i}];
    elseif ~isempty(findstr('Estrus Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('Estrus Urine')+1:end);
        short_names{i} = ['E_U' short_names{i}];
    elseif ~isempty(findstr('Artificial Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('Artificial Urine')+1 :end);
        short_names{i} = ['A_U' short_names{i}];
    elseif ~isempty(findstr('predator urine',long_names{i}))
        short_names{i} =  long_names{i}(length('predator Urine')+1 :end);
        short_names{i} = ['P_U' short_names{i}];
    elseif ~isempty(findstr('Volatile MIX',long_names{i}))
        short_names{i} =  long_names{i}(length('Volatile MIX')+1 :end);
        short_names{i} = ['VM' short_names{i}];

    elseif ~isempty(findstr('Female Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('Female Urine')+1 :end);
        short_names{i} = ['F_U' short_names{i}];
    elseif ~isempty(findstr('Male Urine',long_names{i}))
        short_names{i} =  long_names{i}(length('Male Urine')+1 :end);
        short_names{i} = ['M_U' short_names{i}];

    elseif ~isempty(findstr('B6 Female Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('B6 Female Saliva')+1 :end);
        short_names{i} = ['B6_F_S' short_names{i}];
    elseif ~isempty(findstr('B6 MALE Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('B6 MALE Saliva')+1 :end);
        short_names{i} = ['B6_M_S' short_names{i}];

    elseif ~isempty(findstr('BALBC Female Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('BALBC Female Saliva')+1 :end);
        short_names{i} = ['BC_F_S' short_names{i}];
    elseif ~isempty(findstr('BALBC Male Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('BALBC Male Saliva')+1 :end);
        short_names{i} = ['BC_M_S' short_names{i}];

    elseif ~isempty(findstr('CBA Female Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('CBA Female Saliva')+1 :end);
        short_names{i} = ['CBA_F_S' short_names{i}];
    elseif ~isempty(findstr('CBA Male Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('CBA Male Saliva')+1 :end);
        short_names{i} = ['CBA_M_S' short_names{i}];
        % This block is to take care of cases when I did not give the strain, it is for the 31 jan 08

    elseif ~isempty(strmatch('Castrated Preputial',long_names{i}))
        short_names{i} =  long_names{i}(length('Castrated Preputial')+1 :end);
        short_names{i} = ['CD1_C_Prep' short_names{i}];
    elseif ~isempty(strmatch('Castrated Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('Castrated Saliva')+1 :end);
        short_names{i} = ['CD1_C_Sal' short_names{i}];
    elseif ~isempty(strmatch('Female Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('Female Saliva')+1 :end);
        short_names{i} = ['CD1_F_Sal' short_names{i}];
    elseif ~isempty(strmatch('Male Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('Male Saliva')+1 :end);
        short_names{i} = ['CD1_M_Sal' short_names{i}];
    elseif ~isempty(strmatch('Female SMG Large',long_names{i}))
        short_names{i} =  long_names{i}(length('Female SMG Large')+1 :end);
        short_names{i} = ['CD1_F_SmgL' short_names{i}];
    elseif ~isempty(strmatch('Female SMG',long_names{i}))
        short_names{i} =  long_names{i}(length('Female SMG')+1 :end);
        short_names{i} = ['CD1_F_Smg' short_names{i}];
    elseif ~isempty(strmatch('Male SMG',long_names{i}))
        short_names{i} =  long_names{i}(length('Male SMG')+1 :end);
        short_names{i} = ['CD1_M_Smg' short_names{i}];
        % This is for cases when the strain is specified
    elseif ~isempty(findstr('Castrated Preputial',long_names{i}))
        short_names{i} =  long_names{i}(length('Castrated Preputial')+1 :end);
        short_names{i} = ['C_Prep' short_names{i}];
    elseif ~isempty(findstr('Castrated Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('Castrated Saliva')+1 :end);
        short_names{i} = ['C_Sal' short_names{i}];
    elseif ~isempty(findstr('Female Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('Female Saliva')+1 :end);
        short_names{i} = ['F_Sal' short_names{i}];
    elseif ~isempty(findstr('Male Saliva',long_names{i}))
        short_names{i} =  long_names{i}(length('Male Saliva')+1 :end);
        short_names{i} = ['M_Sal' short_names{i}];
    elseif ~isempty(findstr('Female SMG Large',long_names{i}))
        short_names{i} =  long_names{i}(length('Female SMG Large')+1 :end);
        short_names{i} = ['F_SmgL' short_names{i}];
    elseif ~isempty(findstr('Female SMG',long_names{i}))
        short_names{i} =  long_names{i}(length('Female SMG')+1 :end);
        short_names{i} = ['F_Smg' short_names{i}];
    elseif ~isempty(findstr('Male SMG',long_names{i}))
        short_names{i} =  long_names{i}(length('Male SMG')+1 :end);
        short_names{i} = ['M_Smg' short_names{i}];
    else
        short_names{i} = long_names{i};
    end

    s = findstr('_1ul',short_names{i});
    if ~isempty(s)
        short_names{i}(s:end) = [];
    end

    % THis is more of a specific correction for volatile odoratns
    s = findstr('vol',short_names{i});
    if ~isempty(s)
        short_names{i}(s+3:end) = [];
    end

end