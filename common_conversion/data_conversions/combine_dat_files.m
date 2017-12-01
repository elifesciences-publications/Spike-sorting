function combine_dat_files(datadir,outputdir,blocks,IBI,SR,Nchans,group)
% combine data files across blocks - required for Klusters trace viwe -
% maybe this is also the way to gow tih neurscope.

% NOTE -that when I do the spike time files - I do add a dead time between
% the two - I will make this to be 10 seconds - this should be consistent
% with the times I use in myprocessstart - hopefully. if file combination
% works this is the way it should always be done - 


% datadir = '/home/yoram/DATA/TDTDATA/03oct06/mat/';
% output_datadir = '/home/yoram/DATA/TDTDATA/03oct06/mat/site1/';

% outfile = [outputdir 'group' num2str(group) filesep 'group_' num2str(group) '_combined' ];
% for i = 1:length(blocks)
%     outfile = [outfile '_' num2str(blocks(i))];
% end
% outfile = [outfile '.dat']

outfile = [outputdir 'group' num2str(group) filesep 'combined' num2str(group) '.dat' ];

fid1 = fopen(outfile,'w');

for i = 1:length(blocks)
    thisdatfile = [datadir 'Block-' num2str(blocks(i)) filesep 'Block-' num2str(blocks(i)) '_group' num2str(group) '.dat' ];
    fid2 = fopen(thisdatfile,'rb');
    D = fread(fid2,'integer*2=>integer*2');
    fclose(fid2);
    fwrite(fid1,D,'integer*2');
    clear D
    if ~(round(SR*IBI*Nchans) == SR*IBI*Nchans)
        disp(['COMBINE DATA FILES: warning, file interval time is not an integer!!']);
        E = 100*(round(SR*IBI*Nchans) - SR*IBI*Nchans)/SR*IBI*Nchans;        
        disp(['Error is ' num2str(E) ' % !!']);
    end          
        
    PAD = zeros(1,round(SR*IBI*Nchans));
    % This is the padding inserted between blocks (which are not consecutive in time, and which must be consistent with
    % the spike timing that appears in the extract file)
    if i < length(blocks)
        fwrite(fid1,PAD,'integer*2');
        clear PAD
    end
end
fclose(fid1);


return
    
