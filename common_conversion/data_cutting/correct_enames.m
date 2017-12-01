function [enames, etypes] = correct_names(enames,etypes,expdate,session);
% These corrections are required because of inconsistencies including some
% foolish mistakes in data reporting








switch lower(expdate)
    case '15may09'
        switch session
            case 1
                enames{2}{30} = 'MOS Ringers';
                enames{2}{48} = 'MOS Female Urine';
                enames{2}{57} = 'MOS Male Urine';
                enames{2}{66} = 'MOS Predator Urine';
                enames{3}{3}  = 'MOS Female Urine';
                enames{3}{30}  = 'MOS Predator Urine';
                enames{3}{48}  = 'MOS Ringers';
                enames{3}{66}  = 'MOS Male Urine';
                enames{4}{3}   = 'MOS Predator Urine';
                enames{4}{12}  = 'MOS Ringers';
                enames{4}{30}  = 'MOS Male Urine';
                enames{4}{48}  = 'MOS Female Urine';
                enames{5}{21}  = 'MOS Male Urine';
                enames{5}{39}  = 'MOS Predator Urine';
                enames{5}{48}  = 'MOS Female Urine';
                enames{5}{57}  = 'MOS Ringers';
                % We need to do this otherwise these fake events are listed
                % as odor applied events
                for i = 1:length(enames)
                    fake_inds = strmatch('fake',enames{i});
                    if ~isempty(fake_inds)
                        for fi = 1:length(fake_inds)
                            etypes{i}{fake_inds(fi)} = 'fake';
                        end
                    end
                end

            case 2
                enames{2}{30} = 'MOS Ringers';
                enames{2}{48} = 'MOS Female Urine';
                enames{2}{57} = 'MOS Male Urine';
                enames{2}{66} = 'MOS Predator Urine';
                enames{3}{3}  = 'MOS Female Urine';
                enames{3}{30}  = 'MOS Predator Urine';
                enames{3}{48}  = 'MOS Ringers';
                enames{3}{66}  = 'MOS Male Urine';
                enames{4}{3}   = 'MOS Predator Urine';
                enames{4}{12}  = 'MOS Ringers';
                enames{5}{12}  = 'MOS Male Urine';
                enames{5}{30}  = 'MOS Female Urine';
                enames{6}{21}  = 'MOS Male Urine';
                enames{6}{39}  = 'MOS Predator Urine';
                enames{6}{48}  = 'MOS Female Urine';
                enames{6}{57}  = 'MOS Ringers';
                enames{7}{3}  = 'MOS Ringers';
                enames{7}{21}  = 'MOS Male Urine';
                enames{7}{48}  = 'MOS Predator Urine';
                enames{7}{57}  = 'MOS Female Urine';

                % We need to do this otherwise these fake events are listed
                % as odor applied events
                for i = 1:length(enames)
                    fake_inds = strmatch('fake',enames{i});
                    if ~isempty(fake_inds)
                        for fi = 1:length(fake_inds)
                            etypes{i}{fake_inds(fi)} = 'fake';
                        end
                    end
                end

        end

    case '20may09'
        switch session
            case 2
                enames{2}{30} = 'MOS Ringers';
                enames{2}{48} = 'MOS Female Urine';
                enames{2}{57} = 'MOS Male Urine';
                enames{2}{66} = 'MOS Predator Urine';

                enames{3}{3}  = 'MOS Female Urine';
                enames{3}{30}  = 'MOS Predator Urine';
                enames{3}{48}  = 'MOS Ringers';
                enames{3}{66}  = 'MOS Male Urine';

                enames{4}{3}   = 'MOS Predator Urine';
                enames{4}{12}  = 'MOS Ringers';
                enames{4}{30}  = 'MOS Male Urine';
                enames{4}{48}  = 'MOS Female Urine';

                enames{5}{21}  = 'MOS Male Urine';
                enames{5}{39}  = 'MOS Predator Urine';
                enames{5}{48}  = 'MOS Female Urine';
                enames{5}{57}  = 'MOS Ringers';

                enames{6}{11}   = 'MOS Ringers';
                enames{6}{29}  = 'MOS Male Urine';
                enames{6}{53}  = 'MOS Predator Urine';
                enames{7}{3}  = 'MOS Female Urine';
                % We need to do this otherwise these fake events are listed
                % as odor applied events
                for i = 1:length(enames)
                    fake_inds = strmatch('fake',enames{i});
                    if ~isempty(fake_inds)
                        for fi = 1:length(fake_inds)
                            etypes{i}{fake_inds(fi)} = 'fake';
                        end
                    end
                end
        end
end

return