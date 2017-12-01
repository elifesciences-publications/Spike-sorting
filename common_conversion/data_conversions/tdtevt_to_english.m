function english_name = tdtevt_to_english(event_code);
switch event_code
    case 'evnt_1_0'
        english_name = 'clean';
    case 'evnt_1_1'
        english_name = 'blank';
    case 'evnt_1_20'
        english_name = 'BC F U';
    case 'evnt_1_21'
        english_name = 'BC M U';
    case 'evnt_1_30'
        english_name = 'b6 M U';
    case 'evnt_1_31'
        english_name = 'b6 F U';
    case 'evnt_1_40'
        english_name = 'CBA M U';
    case 'evnt_1_41'
        english_name = 'CBA F U';
    case 'evnt_1_50'
        english_name = '129 M U';
    case 'evnt_1_51'
        english_name = '129 F U';
    case 'evnt_1_60'
        english_name = 'FVB M U';
    case 'evnt_1_61'
        english_name = 'FVB F U';
    case 'evnt_1_10'
        english_name = 'mix M U';
    case 'evnt_1_11'
        english_name = 'mix F U';
    case 'evnt_1_1011'
        english_name = 'mix M+F U';
    case 'stim_1_1'
        english_name = 'stim on';
    case 'stof_1_1'
        english_name = 'stim off';
    otherwise
        english_name = event_code;
end

