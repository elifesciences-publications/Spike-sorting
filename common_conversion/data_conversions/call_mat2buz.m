% Specify the parent directory where the data is:
% All subdirectories are assumed to contain blocks and start with the
% letter B


% clear datadirs;
% datadir = '/home/yoram/DATA/TDTDATA/03oct06/mat';
% datadir = '/home/yoram/DATA/TDTDATA/17nov06/mat';

site = 1;
datestr = '17nov06';
datestr = '18jan07';
datestr = '11jan07';
datestr = '29feb07';
datestr = '19jan07';
datestr = '10apr07';
datestr = '16jan07';
datestr = '13jun07';
datestr = '22feb07';
datestr = '16feb07';
datestr = '20feb07';
datestr = '02mar07';
datestr = '27jun07';
datestr = '05jul07';
datestr  = '22mar07';
datestr  = '14mar07';
datestr  = '20mar07'; site = 2;




[datadir,combined_datadir,blocks,PC_block,groups] = get_session_info(datestr,site);

do_blocks = [7:8]
%do_blocks = [1:2];
shanks = 4;


% Get all child directories
A  = dir(datadir);
k = 1;
for i = 1:length(A)
    if A(i).isdir & A(i).name(1) == 'B'
        datadirs{k} = [datadir  A(i).name];
        k = k + 1;
    end
end

% sort them according to the block numbers
for i = 1:length(datadirs)
    hyphen_place = findstr('-',datadirs{i});
    blocknums(i) = str2num(datadirs{i}(hyphen_place+1:end));
end
[blocknums inds] = sort(blocknums);
datadirs = datadirs(inds);


% for i = 1:length(datadirs)
%     hyphen_pos = findstr('-',datadirs{i})
%     tmp = datadirs{i};
%     dirblocks(i) = str2num(tmp(hyphen_pos+1:end))
% end

for i = 1:length(datadirs)
    if ismember(blocknums(i),do_blocks)
        for s = 1:length(shanks)
            disp([datadirs{i} '' ' shank ' num2str(shanks(s))])
            mat2buz_contin_pershank(datadirs{i},shanks(s),groups(shanks(s)).chans);
            %     disp([datadirs{i} ' part 2'])
            %      mat2buz_contin(datadirs{i},2);
            %         disp([datadirs ' events'])
            %         mat2buz_event(datadirs{i});
        end
    end
end

% % Use this part to copy the XML files and 
% xml_file = '/home/yoram/DATA/TDTDATA/_part1.xml';
% nrs_file = '/home/yoram/DATA/TDTDATA/_part1.nrs';
% A  = dir(datadir);
% k = 1;
% for i = 1:length(A)
%     if A(i).isdir & A(i).name(1) == 'B'
%         datadirs{k} = [datadir filesep A(i).name];  
%         copyfile(xml_file,[datadirs{k} filesep A(i).name '_part1.xml']);
%         %copyfile(nrs_file,[datadirs{k} filesep A(i).name '_part1.nrs']);
%         k = k + 1;
%     end
% end