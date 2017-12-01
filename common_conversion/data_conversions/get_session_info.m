function [datadir,combined_datadir,blocks,PC_block,groups] = get_session_info(exp_date,site);
%  maxSN  is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%
%
% The complete list of channels is given here
% groups(1).chans = 1 + [13 15 10 14];
% groups(1).chans = 1 + [0   2  1  5];
% groups(1).chans = 1 + [6   3  7  4];
% groups(1).chans = 1 + [12  9 11  8];


% Change this if changes required ...
groups(1).chans = [1:4:32];
groups(2).chans = [2:4:32];
groups(3).chans = [3:4:32];
groups(4).chans = [4:4:32];
% These are channels that were not recorded since they
% contained no relevant data.yoram
skipchans = [];
for i = 1:length(groups)
    groups(i).chans = setdiff(groups(i).chans,skipchans);
end
groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/'];
datadir = ['C:\Users\Joe\Desktop\yoramsample\mat\'];


combined_datadir = ['C:\Users\Joe\Desktop\yoramsample\results\mat\site1\'];
blocks = [1];
PC_block = [1];




% switch exp_date
% 
%      case '11sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     
%     
%     case '10sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     
%      case '09sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%      case '05sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1 3:9];
%                 PC_block = 1;
%         end
%     
%      
%     case '04sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     case '02sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:7];
%                 PC_block = 1;
%         end
%     
%      case '01sep08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
% 
%     
%     
%     case '21aug08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:7];
%                 PC_block = 1;
%         end
% 
% 
%      case '19aug08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     
%     case '15aug08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%      case '13aug08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%       case '12jun08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     case '10jun08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     case '01aug08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     
%     case '31jul08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     
%     
%      case '29jul08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1 3:9];
%                 PC_block = 1;
%         end
% 
%     
%     
%     case '24jul08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
% 
%     
%      case '23jul08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
%     
%     case '18jul08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;
%         end
% 
% 
%      case '23jun08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:7];
%                 PC_block = 1;    
%         end
% 
%     
%     case '16jun08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;    
%         end
% 
%         
%     case '01may08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:8];
%                 PC_block = 1;    
%         end
% 
%         
%     case '06jun08'
%         switch site
%             case 1
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
%                 blocks = [1:5];
%                 PC_block = 1;
%             case 2
%                 combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site2/'];
%                 blocks = [6:10];
%                 PC_block = 6;
%         end
% 
%     case '29may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29may08/mat/site1/';
%                 blocks = [1:5];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/29may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29may08/mat/site2/';
%                 blocks = [6:10];
%                 PC_block = 6;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%         end
% 
% 
% 
%     case '13jun08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/13jun08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/13jun08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '27may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/27may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/27may08/mat/site1/';
%                 blocks = [1:5];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/27may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/27may08/mat/site2/';
%                 blocks = [6:10];
%                 PC_block = 6;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%         end
% 
% 
%     case '22may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22may08/mat/site1/';
%                 blocks = [1 3 5 6];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/22may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22may08/mat/site2/';
%                 blocks = [7:11];
%                 PC_block = 7;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 3
%                 datadir = '/home/yoram/DATA/TDTDATA/22may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22may08/mat/site3/';
%                 blocks = [12 13 14 15 18 19];
%                 PC_block = 12;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%         end
% 
%     case '20may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/20may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/20may08/mat/site1/';
%                 blocks = [1:5];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '08may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/08may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/08may08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '05may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/05may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/05may08/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/05may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/05may08/mat/site2/';
%                 blocks = [8:10];
%                 PC_block = 8;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '02may08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/02may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/02may08/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/02may08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/02may08/mat/site2/';
%                 blocks = [8:10];
%                 PC_block = 8;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
% 
%     case '30apr08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/30apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/30apr08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/30apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/30apr08/mat/site2/';
%                 blocks = [9:10];
%                 PC_block = 9;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
% 
% 
%     case '24apr08'
%         switch site
% 
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/24apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/24apr08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/24apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/24apr08/mat/site2/';
%                 blocks = [9:11];
%                 PC_block = 9;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '22apr08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22apr08/mat/site1/';
%                 blocks = [2:8];
%                 PC_block = 2;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '18apr08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/18apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/18apr08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '15apr08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/15apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/15apr08/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '03apr08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/03apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/03apr08/mat/site1/';
%                 blocks = [1:6 8:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '01apr08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/01apr08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/01apr08/mat/site1/';
%                 blocks = [1:9 11:13];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '28mar08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/28mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/28mar08/mat/site1/';
%                 blocks = [1:3 5:9];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '27mar08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/27mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/27mar08/mat/site1/';
%                 blocks = [1:9];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '25mar08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/25mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/25mar08/mat/site1/';
%                 blocks = [1:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '`'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/20mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/20mar08/mat/site1/';
%                 blocks = [1:10 12];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '07mar08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/07mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/07mar08/mat/site1/';
%                 blocks = [1:6];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '29feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29feb08/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '06mar08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/06mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/06mar08/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '28feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/28feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/28feb08/mat/site1/';
%                 blocks = [1:14];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '05mar08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/05mar08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/05mar08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '07feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/07feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/07feb08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '15feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/15feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/15feb08/mat/site1/';
%                 blocks = [1:9];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/15feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/15feb08/mat/site2/';
%                 blocks = [10:14];
%                 PC_block = 10;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%         end
% 
% 
% 
% 
% 
%     case '19feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/19feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/19feb08/mat/site1/';
%                 blocks = [1:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '08feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/08feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/08feb08/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/08feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/08feb08/mat/site2/';
%                 blocks = [8:11];
%                 PC_block = 8;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '01feb08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/01feb08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/01feb08/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '31jan08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/31jan08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/31jan08/mat/site1/';
%                 blocks = [1:13];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '29jan08'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29jan08/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29jan08/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% 
%     case '21nov06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/21nov06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/21nov06/mat/site1/';
%                 blocks = [1:6];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '22nov06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22nov06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22nov06/mat/site1/';
%                 blocks = [1:9];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '31aug07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/31aug07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/31aug07/mat/site1/';
%                 blocks = [1:13];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '18jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/18jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/18jun07/mat/site1/';
%                 blocks = [1:7];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '03jul07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/03jul07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/03jul07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '19jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/19jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/19jun07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
% 
%     case '21jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/21jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/21jun07/mat/site1/';
%                 blocks = [1:8];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '04apr07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/04apr07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/04apr07/mat/site1/';
%                 blocks = [1:2 4:13];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '25jul07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/25jul07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/25jul07/mat/site1/';
%                 blocks = [1 3 4 5 6 7 8 9 10 11 14 15 16];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '23jul07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/23jul07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/23jul07/mat/site1/';
%                 blocks = [2:9];
%                 PC_block = [2];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '22aug07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22aug07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22aug07/mat/site1/';
%                 blocks = [1:15];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '30jul07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/30jul07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/30jul07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '29jul07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29jul07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29jul07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '29aug07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29aug07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29aug07/mat/site1/';
%                 blocks = [1:13];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
%     case '22jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22jun07/mat/site1/';
%                 blocks = [1 3:13];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '26jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/26jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/26jun07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '14jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/14jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/14jun07/mat/site1/';
%                 blocks = [1:3 5:12];
%                 PC_block = [1];
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '11jun07'
%         switch site
% 
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/11jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/11jun07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
% 
% 
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/11jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/11jun07/mat/site2/';
%                 blocks = [12:23];
%                 PC_block = 12;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '20mar07'
%         switch site
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/20mar07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/20mar07/mat/site2/';
%                 blocks = [7:16];
%                 PC_block = 7;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '14mar07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/14mar07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/14mar07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '22mar07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22mar07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22mar07/mat/site1/';
%                 blocks = [1:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '05jul07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/05jul07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/05jul07/mat/site1/';
%                 blocks = [1:16];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '27jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/27jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/27jun07/mat/site1/';
%                 blocks = [1:14];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '13jun07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/13jun07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/13jun07/mat/site1/';
%                 blocks = [1:9];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '10apr07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/10apr07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/10apr07/mat/site1/';
%                 blocks = [1:14];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.yoram
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '29feb07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29feb07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29feb07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '02mar07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/02mar07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/02mar07/mat/site1/';
%                 blocks = [1:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '22feb07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/22feb07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/22feb07/mat/site1/';
%                 blocks = [1 3:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '20feb07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/20feb07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/20feb07/mat/site1/';
%                 blocks = [1:11];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '16feb07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/16feb07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/16feb07/mat/site1/';
%                 blocks = [1:9];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
% 
% 
%         % In some cases this day is erroneously designated as 19jan06
%         % Also, the day contains another 3 blocks, but these are for mroe
%         % "experimental tests" that are not part of the main experiment, and so
%         % to save time and space I simply igmore them here
%     case '19jan07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/19jan07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/19jan07/mat/site1/';
%                 blocks = [1:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '18jan07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/18jan07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/18jan07/mat/site1/';
%                 blocks = [1:14];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '16jan07'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/16jan07/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/16jan07/mat/site1/';
%                 blocks = [1 3:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
%     case '17nov06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/17nov06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/17nov06/mat/site1/';
%                 blocks = [1:10];
%                 PC_block = 1;
%                 %maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 % These are channels that were not recorded since they
%                 % contained no relevant data.
%                 skipchans = [12 16 24 28 32 17 19 25 29 ];
%                 for i = 1:length(groups)
%                     groups(i).chans = setdiff(groups(i).chans,skipchans);
%                 end
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
% 
% 
%     case '03oct06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/03oct06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/03oct06/mat/site1/';
%                 blocks = [1:15];
%                 PC_block = 1;
%                 maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = [1:4:32];
%                 groups(2).chans = [2:4:32];
%                 groups(3).chans = [3:4:32];
%                 groups(4).chans = [4:4:32];
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/18apr06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/18apr06/mat/site2/';
%                 blocks = [16:19];
%                 PC_block = 4;
%                 maxSN = 15;
%                 groups(1).chans = 1 + [13 15 14];
%                 groups(2).chans = 1 + [ 2   5];
%                 groups(3).chans = 1 + [6   3  7  4];
%                 groups(4).chans = 1 + [12  9 11 ];
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
% 
%     case '18apr06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/18apr06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/18apr06/mat/site1/';
%                 blocks = [1:3];
%                 PC_block = 1;
%                 maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = 1 + [13 15 10 14];
%                 groups(2).chans = 1 + [   2    5];
%                 groups(3).chans = 1 + [6   3  7  4];
%                 groups(4).chans = 1 + [12  9 11  8];
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/18apr06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/18apr06/mat/site2/';
%                 blocks = [4:7];
%                 PC_block = 4;
%                 maxSN = 15;
%                 groups(1).chans = 1 + [13 15 14];
%                 groups(2).chans = 1 + [ 2   5];
%                 groups(3).chans = 1 + [6   3  7  4];
%                 groups(4).chans = 1 + [12  9 11 ];
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
%     case '26may06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/26may06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/26may06/mat/site1/';
%                 blocks = [1:4];
%                 PC_block = 1;
%                 maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 groups(1).chans = 1 + [13 15 14];
%                 groups(2).chans = 1 + [0   2  1  5];
%                 groups(3).chans = 1 + [6   3  7  4];
%                 groups(4).chans = 1 + [ 9 11  8];
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/26may06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/26may06/mat/site2/';
%                 blocks = [5:6];
%                 PC_block = 5;
%                 maxSN = 15;
%                 groups(1).chans = 1 + [];
%                 groups(2).chans = 1 + [ 2   5];
%                 groups(3).chans = 1 + [6   3  7  4];
%                 groups(4).chans = 1 + [ 9 11 ];
%                 groups(1).name = '1'; groups(2).name = '2'; groups(3).name = '3'; groups(4).name = '4';
%         end
%     case '29may06'
%         switch site
%             case 1
%                 datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
%                 blocks = [1:5];
%                 PC_block = 1;
%                 maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 for i = 1:16
%                     groups(i).chans = i;;
%                     groups(i).name  = num2str(i);
%                 end
%             case 2
%                 datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
%                 combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site2/';
%                 blocks = [6:8];
%                 PC_block = 6;
%                 maxSN = 15;  % This is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%                 for i = 1:16
%                     groups(i).chans = i;
%                     groups(i).name  = num2str(i);
%                 end
%         end
% end