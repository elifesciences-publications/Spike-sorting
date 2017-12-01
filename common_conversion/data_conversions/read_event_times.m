function [etimes eclass] = read_event_times(datadir,block);
% read the event times and classes from the tdt text files

spiketime_file_name = [datadir 'Block-' num2str(block) filesep 'Block-' num2str(block) '.tdt.evt']
fid = fopen(spiketime_file_name,'rt');
k = 1;
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    etimes(k) = str2num(tline(1:min(find(isspace(tline)))));
    % the function below is reduandant with the new naming scheme (where Matlab communicates with TDT directly)
    eclass{k} = tdtevt_to_english(tline(max(find(isspace(tline)))+1:end));
    k = k + 1;
end
fclose(fid);

if ~exist('etimes')
    etimes = [];
    eclass = [];
end

etimes = etimes/1000; % convert times to seconds - they are given in ms in the text file to
% conform with the Neuroscope specifications

return








        
        
        
        
        