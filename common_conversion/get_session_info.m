function [datadir,combined_datadir,blocks,PC_block,groups,maxSN] = get_session_info(exp_date,site);
%  maxSN  is the best case scenario for S/N in any of the channels - any better values will be considered as artifact
%
%
% The complete list of channels is given here
% groups(1).chans = 1 + [13 15 10 14];
% groups(1).chans = 1 + [0   2  1  5];
% groups(1).chans = 1 + [6   3  7  4];
% groups(1).chans = 1 + [12  9 11  8];

%H:\tdt_tank_backups
%c:\tanks



global GLBL_WHICH_PC;

switch GLBL_WHICH_PC
    case 'LAPTOP'
        Cdisk = 'C:\DATA\data_lib\';
        Hdisk = Cdisk;
        Idisk = Cdisk;
    otherwise
        Cdisk = 'c:\tanks\';
        Hdisk = 'h:\tdt_tank_backups\';
        Idisk = 'i:\tdt_tank_backups\';
end


Nchan = 32;
for i = 1:Nchan
    groups(i).chans = i;
    groups(i).name  = num2str(i);
end

maxSN = inf;

switch exp_date
    
    
    case '28jun11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
            case 2
                blocks = [6:9];
                PC_block = [6];
        end
        
        
    case '24jun11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
            case 2
                blocks = [8:11];
                PC_block = [8];
        end
        
        
        
    case '17jun11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
            case 2
                blocks = [7:9];
                PC_block = [7];
        end
        
        
        
        
    case '09jun11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:6];
                PC_block = [1];
            case 2
                blocks = [7:11];
                PC_block = [7];
        end
        
        
    case '03jun11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
            case 2
                blocks = [6:10];
                PC_block = [6];
        end
        
    case '02jun11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:7];
                PC_block = [4];
        end
        
        
        
        
    case '04may11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:7];
                PC_block = [4];
        end
        
    case '03may11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
            case 2
                blocks = [5:8];
                PC_block = [5];
        end
        
    case '02may11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
            case 2
                blocks = [5:8];
                PC_block = [5];
        end
        
    case '21apr11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
            case 2
                blocks = [5:8];
                PC_block = [5];
        end
        
        
    case '19apr11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:5];
                PC_block = [1];
            case 2
                blocks = [6:9];
                PC_block = [6];
        end
        
    case '24mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 2
                blocks = [1:12];
                PC_block = [1];
        end
        
    case '22mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
        end
        
        
    case '17mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = [1];
        end
        
        
    case '14mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 3
                blocks = [5:11];
                PC_block = [1];
        end
        
        
        
        
    case '08mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
        
    case '07mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:11];
                PC_block = [1];
        end
        
        
        
        
    case '04mar11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
    case '21feb11'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:13];
                PC_block = [1];
        end
        
        
    case '24nov10'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1];
                PC_block = [1];
            case 2
                blocks = [2];
                PC_block = [2];
            case 3
                blocks = [3];
                PC_block = [3];
            case 4
                blocks = [4];
                PC_block = [4];
        end
        
        
        
    case '23nov10'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:6];
                PC_block = [4];
        end
        
        
    case '08dec10'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:6];
                PC_block = [4];
        end
        
        
    case '12nov10'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:7];
                PC_block = [4];
        end
        
        
        
    case '09nov10'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
        end
        
        
    case '02nov10'
        % NOTe the different format of calling this - because each block is
        % with different conditions
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
            case 2
                blocks = [5:8];
                PC_block = [5];
            case 3
                blocks = [9:11];
                PC_block = [9];
        end
        
    case '10aug10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks   = [1 2];
                PC_block = [1];
            case 2
                blocks   = [3 4];
                PC_block = [3];
            case 3
                blocks   = [5 6 7 8];
                PC_block = [5];
        end
        
    case '05aug10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5 10:13];
                PC_block = [1];
        end
        
    case '03aug10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3];
                PC_block = [1];
            case 2
                blocks = [4 5 6 7 ];
                PC_block = [4];
            case 3
                blocks = [8 9 10 11];
                PC_block = [8];
        end
        
        
    case '27jul10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [2 4 ];
                PC_block = [2];
            case 2
                blocks = [5 6 7 ];
                PC_block = [5];
            case 3
                blocks = [8 9 ];
                PC_block = [8];
        end
        
    case '22jul10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:8];
                PC_block = [1];
        end
        
        
        
    case '25jun10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4];
                PC_block = [4];
        end
        
        
    case '29jun10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1];
                PC_block = [1];
            case 2
                blocks = [2];
                PC_block = [2];
            case 3
                blocks = [3];
                PC_block = [3 4];
            case 4
                blocks = [5];
                PC_block = [5];
            case 5
                blocks = [6];
                PC_block = [6];
            case 6
                blocks = [7];
                PC_block = [7];
        end
        
        
    case '28jun10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1];
                PC_block = [1];
            case 2
                blocks = [2];
                PC_block = [2];
            case 3
                blocks = [3];
                PC_block = [3];
            case 4
                blocks = [4];
                PC_block = [4];
            case 5
                blocks = [5 6];
                PC_block = [5];
            case 6
                blocks = [7];
                PC_block = [7];
        end
        
    case '15jun10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 4];
                PC_block = [1];
        end
        
        
    case '30apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 4];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 2
                blocks = [5 6 7];
                PC_block = [5];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [8 9 10 11 12];
                PC_block = [8];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
    case '23apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 2 3 4 5];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 2
                blocks = [6 7];
                PC_block = [6];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [8 9 10 11 ];
                PC_block = [8];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 4
                blocks = [12 13 14];
                PC_block = [12];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
                
        end
        
        
        
        
        
        
        
        
    case '22apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 4 5 6 7];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 2
                blocks = [8 9 10 12  ];
                PC_block = [8];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 3
                blocks = [13 14 ];
                PC_block = [13];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
    case '16apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 2 3];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 2
                blocks = [4 5 ];
                PC_block = [4];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [6 7];
                PC_block = [6];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 4
                blocks = [9 10];
                PC_block = [9];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
        end
        
        
    case '14apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 2 3];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
                
            case 2
                blocks = [4 5 6];
                PC_block = [4];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [7 8 9];
                PC_block = [7];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 4
                blocks = [10:13];
                PC_block = [10];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
        
    case '09apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 2];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
                
            case 2
                blocks = [3:5];
                PC_block = [3];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [6 7];
                PC_block = [6];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 4
                blocks = [8 9];
                PC_block = [8];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 5
                blocks = [10 11];
                PC_block = [10];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 6
                blocks = [12 13];
                PC_block = [12];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
        end
        
        
        
        
        
    case '08apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 2];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
                
            case 2
                blocks = [3 4];
                PC_block = [3];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [5 6];
                PC_block = [6];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 4
                blocks = [7:14];
                PC_block = [7];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
        end
        
    case '05apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
        end
        
        
        
        
        
    case '01apr10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
        
    case '23mar10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 4];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 2
                blocks = [5:7];
                PC_block = [5];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [8:10];
                PC_block = [8];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
    case '18mar10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 2
                blocks = [4:6];
                PC_block = [4];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 3
                blocks = [7:9];
                PC_block = [7];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
        
    case '11mar10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:2];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 2
                blocks = [3:4];
                PC_block = [3];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
                
            case 3
                blocks = [5:11];
                PC_block = [5];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
        
    case '09mar10'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
            case 2
                blocks = [8:12];
                PC_block = [8];
                groups(1).chans = [1 2 5 6 9 10 13 14];
                groups(2).chans = [1 2 5 6 9 10 13 14] + 16;
                groups(3).chans = [1 2 5 6 9 10 13 14] + 2;
                groups(4).chans = [1 2 5 6 9 10 13 14] + 18;
        end
        
        
    case '17dec09'
        switch site
            case 1
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site1/'];
                blocks = [1];
                PC_block = [1];
            case 3
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site3/'];
                blocks = [3];
                PC_block = [3];
            case 4
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site4/'];
                blocks = [4];
                PC_block = [4];
            case 5
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site5/'];
                blocks = [5];
                PC_block = [5];
            case 6
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site6/'];
                blocks = [6];
                PC_block = [6];
            case 7
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site7/'];
                blocks = [7];
                PC_block = [7];
            case 8
                combined_datadir = ['/home/yoram/DATA/TDTDATA/' exp_date '/mat/site8/'];
                blocks = [8];
                PC_block = [8];
                
        end
        
    case '20nov09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:5];
                PC_block = [4];
            case 3
                blocks = [6:7];
                PC_block = [6];
        end
        
    case '19nov09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:2];
                PC_block = [1];
            case 2
                blocks = [3:4];
                PC_block = [3];
            case 3
                blocks = [5:6];
                PC_block = [5];
            case 4
                blocks = [7:8];
                PC_block = [7];
        end
        
        
        
    case '18nov09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 4];
                PC_block = [1];
            case 2
                blocks = [5:6];
                PC_block = [5];
        end
        
        
    case '17nov09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:5];
                PC_block = [4];
            case 3
                blocks = [6:7];
                PC_block = [6];
            case 4
                blocks = [8:9];
                PC_block = [8];
        end
        
        
        
        
    case '11nov09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:6];
                PC_block = [4];
        end
        
        
    case '10nov09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 4:7];
                PC_block = [1];
        end
        
        
        
    case '28oct09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
                
            case 2
                blocks = [5:7];
                PC_block = [5];
        end
        
        
    case '27oct09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 4 5];
                PC_block = [1];
                
            case 2
                blocks = [6:8];
                PC_block = [6];
        end
        
    case '23oct09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
                
            case 2
                blocks = [5:8];
                PC_block = [5];
        end
        
        
        
        
    case '20oct09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
        end
        
        
        
    case '29sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '01oct09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
            case 2
                blocks = [6:13];
                PC_block = [6];
        end
        
        
        
    case '09sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:9];
                PC_block = [4];
        end
        
        
        
        
        
    case '09sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
            case 2
                blocks = [4:9];
                PC_block = [4];
        end
        
        
    case '08sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
    case '04sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
                
            case 2
                blocks = [4:6];
                PC_block = [4];
            case 3
                blocks = [7:9];
                PC_block = [7];
        end
        
        
        
    case '02sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = [1];
        end
        
        
        
    case '01sep09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:5];
                PC_block = [1];
                
            case 2
                blocks = [6:9];
                PC_block = [6];
                
        end
        
        
    case '20aug09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
                
            case 2
                blocks = [6:9];
                PC_block = [6];
                
        end
        
        
    case '15jul09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
                
            case 2
                blocks = [4:5];
                PC_block = [4];
            case 3
                blocks = [6:9];
                PC_block = [6];
        end
        
        
    case '08jul09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 3
                blocks = [6:10];
                PC_block = [6];
        end
        
        
        
        
    case '30jun09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3];
                PC_block = [1];
                
            case 2
                blocks = [4:8];
                PC_block = [4];
                
        end
        
        
    case '23jun09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '11jun09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 2
                blocks = [4:9];
                PC_block = [4];
        end
        
        
        
        
    case '18jun09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
    case '04jun09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
    case '27may09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1];
                PC_block = [1];
        end
        
    case '26may09_test'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [2];
                PC_block = [2];
        end
        
        
    case '20may09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 2
                blocks = [4:10];
                PC_block = [4];
        end
        
        
    case '15may09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:2 4:6];
                PC_block = [1];
            case 2
                blocks = [7:13];
                PC_block = [7];
        end
        
        
        
        
    case '03apr09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6];
                PC_block = [1];
            case 2
                blocks = [8:9];
                PC_block = [8];
        end
        
        
    case '07apr09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:9];
                PC_block = [1];
        end
        
        
        
        
    case '10apr09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4 6:9];
                PC_block = [1];
        end
        
        
        
    case '14apr09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1,5];
                PC_block = [1];
                
            case 2
                blocks = [6:13];
                PC_block = [6];
        end
        
        
        
    case '05mar09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
                
            case 2
                blocks = [5:8];
                PC_block = [5];
        end
        
        
    case '04mar09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
        end
        
        
        
    case '27feb09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
        end
        
        
        
    case '24feb09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
        end
        
        
        
    case '17feb09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
        end
        
        
    case '13feb09'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [2:5];
                PC_block = [2];
            case 2
                blocks = [6:9];
                PC_block = [6];
        end
        
        
        
    case '09dec08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
        end
        
        
        
    case '05dec08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
        
        
    case '04dec08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:12];
                PC_block = [1];
        end
        
        
        
    case '28nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5 11:17];
                PC_block = [1];
        end
        
    case '26nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3 5:13];
                PC_block = [1];
        end
        
        
    case '25nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4 6:15];
                PC_block = [1];
        end
        
        
        
    case '21nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '20nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '18nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
    case '14nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '13nov08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6 8:11];
                PC_block = [1];
        end
        
        
        
    case '10oct08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
    case '27may08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = [1];
            case 2
                blocks = [6:10];
                PC_block = [6];
        end
        
    case '22may08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 5 6];
                PC_block = [1];
            case 2
                blocks = [7:11];
                PC_block = [7];
            case 3
                blocks = [12 13 14 15 18 19];
                PC_block = [12];
        end
        
        
    case '11sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '10sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
    case '09sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '05sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:9];
                PC_block = [1];
        end
        
        
    case '04sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '02sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '01sep08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '21aug08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '19aug08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '15aug08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '13aug08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '01aug08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '31jul08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
    case '24jul08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '23jul08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '18jul08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '23jun08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
    case '16jun08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '12jun08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '10jun08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '13jun08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
    case '08may08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
        
    case '05may08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
        
    case '02may08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '01may08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
        
    case '30apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
    case '24apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '22apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [2:8];
                PC_block = [2];
        end
        
        
        
        
    case '18apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
    case '15apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
    case '03apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6 8:11];
                PC_block = [1];
        end
        
        
    case '01apr08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9 11:13];
                PC_block = [1];
        end
        
        
    case '28mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3 5:9];
                PC_block = [1];
        end
        
        
        
    case '27mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = [1];
        end
        
        
    case '25mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
        end
        
        
        
    case '20mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10 12];
                PC_block = [1];
        end
        
        
        
    case '07mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6];
                PC_block = [1];
        end
        
        
    case '29feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '28feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:14];
                PC_block = [1];
        end
        
        
        
        
    case '06mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
    case '05mar08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
    case '15feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = [1];
            case 2
                blocks = [10:14];
                PC_block = [10];
        end
        
        
    case '07feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '08feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '01feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
    case '19feb08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
        end
        
        
    case '31jan08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11 13];
                PC_block = [1];
        end
        
        
        
    case '29jan08'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
        
    case '31aug07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:13];
                PC_block = [1];
        end
        
        
    case '29aug07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:13];
                PC_block = [1];
        end
        
        
    case '23aug07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:13];
                PC_block = [1];
        end
        
    case '22aug07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:15];
                PC_block = [1];
        end
        
    case '30jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
    case '29jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
    case '26jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
    case '25jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3 4 5 6 7 8 9 10 11 14 15 16];
                PC_block = [1];
        end
        
        
    case '23jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [2:9];
                PC_block = [2];
        end
        
    case '22jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '03jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '05jul07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:16];
                PC_block = [1];
        end
        
        
    case '27jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Block 14 contains spont activity with a chance of
                % anesthetisa level
                blocks = [1:13];
                PC_block = [1];
        end
        
        
    case '19jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '26jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
    case '22jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:13];
                PC_block = [1];
        end
        
        
        
    case '21jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
        
        
        
    case '18jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '14jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:3 5:12];
                PC_block = [1];
        end
        
        
        
    case '13jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = [1];
        end
        
    case '11jun07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
            case 2
                blocks = [12:23];
                PC_block = [12];
        end
        
        
    case '08jun07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6];
                PC_block = [1];
            case 2
                blocks = [7:15];
                PC_block = [7];
        end
        
        
        
    case '10apr07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Block 14 is experimental
                blocks = [1:14];
                PC_block = [1];
        end
        
    case '09apr07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Block 14 is experimental
                blocks = [1:12];
                PC_block = [1];
        end
        
        
    case '06apr07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Block 14 is experimental
                blocks = [1 3:12];
                PC_block = [1];
        end
        
    case '04apr07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Block 14 is experimental
                blocks = [1:2 4:13];
                PC_block = [1];
        end
        
    case '28mar07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6];
                PC_block = [1];
        end
        
    case '27mar07_LC'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:12];
                PC_block = [1];
        end
        
        
    case '23mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
    case '22mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
        end
        
    case '20mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6];
                PC_block = [1];
            case 2
                blocks = [7:8 10:16];
                PC_block = [7];
        end
        
        
    case '15mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = [1];
        end
        
        
    case '14mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5 8:11];
                PC_block = [1];
        end
        
    case '08mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
    case '02mar07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                %Block 10 is a non standard experiment block
                blocks = [1:9];
                %blocks = [1:10];
                PC_block = [1];
        end
        
        
    case '29feb07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '22feb07'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 3:11];
                PC_block = [1];
        end
        
    case '21feb07'
        datadir = [Idisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = [1];
        end
        
    case '20feb07'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Blocks 12 and 13 are non standard
                %blocks = [1:13];
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '16feb07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Block 9 is an experimental block
                blocks = [1:8];
                %blocks = [1:9];
                PC_block = [1];
        end
        
    case '14feb07'
        datadir = [Cdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = [1];
            case 2
                blocks = [5:6];
                PC_block = [5];
            case 3
                blocks = [7:9];
                PC_block = [7];
        end
        
        
    case '09feb07' % Which is actually 2007
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = [1];
        end
        
        
    case '19jan06' % Which is actually 2007
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                % Blocks after 10 are for non standard stimulus
                % presentations
                blocks = [1:10];
                %blocks = [1:13];
                PC_block = [1];
        end
        
        
    case '18jan07'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                disp('we also have block 14 for 18jan07, but it is not a standard protocol')
                blocks = [1:13];
                PC_block = [1];
        end
        
        
    case '16jan07'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                disp('there are more blocks in 16jan07, but these are not standard')
                blocks = [1 3:10];
                %blocks = [1 3:15];
                PC_block = [1];
        end
        
        
        
    case '12jan07'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
        
    case '11jan07'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:11];
                PC_block = [1];
        end
        
        
    case '09jan06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = [1];
        end
        
    case '05jan06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:4];
                PC_block = 1;
        end
        
        
    case '24nov06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = 1;
            case 2
                blocks = [ 6 8:11];
                PC_block = 6;
        end
        
    case '22nov06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:9];
                PC_block = 1;
        end
        
        
    case '21nov06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:6];
                PC_block = 1;
            case 2
                blocks = [7 8 9 10 15 16];
                PC_block = 7;
        end
        
    case '17nov06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:10];
                PC_block = 1;
        end
        
        
    case '15nov06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:5];
                PC_block = 1;
        end
        
        
    case '31oct06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1 2 4 6 8];
                PC_block = 1;
            case 2
                blocks = [9:12];
                PC_block = 9;
        end
        
        
    case '25oct06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = 1;
        end
        
    case '27oct06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [4:8];
                PC_block = 4;
        end
        
        
    case '11oct06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:12];
                PC_block = 1;
        end
        
        
    case '05oct06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [2:11];
                PC_block = 2;
            case 2
                blocks = [13:19];
                PC_block = 13;
        end
        
    case '03oct06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:15];
                PC_block = 1;
            case 2
                blocks = [16:19];
                PC_block = 16;
        end
        
        
    case '29sep06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = 1;
            case 2
                blocks = [8:13];
                PC_block = 8;
        end
        
    case '21sep06'
        
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:7];
                PC_block = 1;
            case 2
                blocks = [8:14];
                PC_block = 8;
        end
        
    case '22sep06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        combined_datadir = [datadir 'site' num2str(site) filesep];
        switch site
            case 1
                blocks = [1:8];
                PC_block = 1;
            case 2
                blocks = [9:15];
                PC_block = 9;
        end
        
    case '13apr06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\13apr06\mat\';
                    combined_datadir = 'D:\13apr06\mat\site1\';
                else
                end
                blocks = [1:7];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
    case '18apr06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\18apr06\mat\';
                    combined_datadir = 'D:\18apr06\mat\site1\';
                else
                end
                blocks = [1:3];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'D:\18apr06\mat\';
                    combined_datadir = 'D:\18apr06\mat\site2\';
                else
                end
                blocks = [4:7];
                PC_block = 4;
                ;
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
    case '20apr06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\20apr06\mat\';
                    combined_datadir = 'D:\20apr06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:8];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '21apr06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\21apr06\mat\';
                    combined_datadir = 'D:\21apr06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:6];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
    case '26may06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\26may06\mat\';
                    combined_datadir = 'D:\26may06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:4];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'D:\26may06\mat\';
                    combined_datadir = 'D:\26may06\mat\site2\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [5:6];
                PC_block = 5;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
    case '29may06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\29may06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\29may06\mat\site1\';
                else
                    datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:5];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\29may06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\29may06\mat\site2\';
                else
                    datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site2/';
                end
                blocks = [6:8];
                PC_block = 6;
                
                for i = 1:16
                    groups(i).chans = i;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '30may06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\30may06\mat\';
                    combined_datadir = 'D:\30may06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1 4 5 6];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
                
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'D:\30may06\mat\';
                    combined_datadir = 'D:\30may06\mat\site2\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [8:11];
                PC_block = 8;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
    case '21jun06'
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\21jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\21jun06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1 2 3 5 6];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\21jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\21jun06\mat\site2\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [7:9];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
    case '22jun06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                datadir = [Hdisk exp_date filesep 'mat' filesep];
                combined_datadir = [datadir 'site' num2str(site) filesep];
                blocks = [1:2];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                datadir = [Hdisk exp_date filesep 'mat' filesep];
                combined_datadir = [datadir 'site' num2str(site) filesep];
                blocks = [3:4];
                PC_block = 3;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 3
                datadir = [Hdisk exp_date filesep 'mat' filesep];
                combined_datadir = [datadir 'site' num2str(site) filesep];
                blocks = [5:6];
                PC_block = 5;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
                
            case 4
                datadir = [Hdisk exp_date filesep 'mat' filesep];
                combined_datadir = [datadir 'site' num2str(site) filesep];
                blocks = [7:10];
                PC_block = 7;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '23jun06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\23jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\23jun06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:2];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
                
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\23jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\23jun06\mat\site2\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [3:4];
                PC_block = 3;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
                
            case 3
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\23jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\23jun06\mat\site3\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [5:7];
                PC_block = 5;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
                
        end
        
    case '09jun06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'D:\09jun06\mat\';
                    combined_datadir = 'D:\09jun06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:2];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'D:\09jun06\mat\';
                    combined_datadir = 'D:\09jun06\mat\site2\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [3:5];
                PC_block = 3;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '16jun06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\16jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\16jun06\mat\site1\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:5];
                PC_block = 1;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\16jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\16jun06\mat\site2\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [6:8];
                PC_block = 6;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 3
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\16jun06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\16jun06\mat\site3\';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [9:10];
                PC_block = 9;
                
                for i = 1:16
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '23aug06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\23aug06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\23aug06\mat\site1';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:8 10];
                PC_block = 1;
                
                skip_channels = [1 2 3 4];
                k = 1;
                for i = 1:32
                    if ~ismember(i,skip_channels)
                        groups(k).chans = i;;
                        groups(k).name  = num2str(i);
                        k = k +1;
                    end
                end
        end
        
        
    case '24aug06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\24aug06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\24aug06\mat\site1';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:6];
                PC_block = 1;
                
                skip_channels = [1 2 3 4 5 6 9 13 17 21 26 29 10 6 10 14];
                for i = 1:32
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\24aug06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\24aug06\mat\site2';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [7:13];
                PC_block = 7;
                
                skip_channels = [1:4];
                for i = 1:32
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 3
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\24aug06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\24aug06\mat\site3';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [14:15];
                PC_block = 14;
                
                skip_channels = [1:4];
                for i = 1:32
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '29aug06'
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\29aug06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\29aug06\mat\site1';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [1:5];
                PC_block = 1;
                
                skip_channels = [2 5 6 7 8 9 10 13 14 17 18 20 21 22 25 26 28 29 30];
                for i = 1:32
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'H:\tdt_tank_backups\29aug06\mat\';
                    combined_datadir = 'H:\tdt_tank_backups\29aug06\mat\site2';
                else
                    %                     datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/';
                    %                     combined_datadir = '/home/yoram/DATA/TDTDATA/29may06/mat/site1/';
                end
                blocks = [6:10];
                PC_block = 6;
                
                skip_channels = [18,20 25,26,28,9,8,12,22,27,31,32,16];
                for i = 1:32
                    groups(i).chans = i;;
                    groups(i).name  = num2str(i);
                end
        end
        
        
    case '31aug06'
        for i = 1:32
            groups(i).chans = i;;
            groups(i).name  = num2str(i);
        end
        switch site
            % Although these are different sites, for the preliminary look
            % goal is does not matter
            case 1
                if strcmp(PC,'tdt')
                    
                    datadir = 'h:\tdt_tank_backups\31aug06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\31aug06\mat\site1';
                end
                blocks = [1:5 ];
                PC_block = 1;
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'h:\tdt_tank_backups\31aug06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\31aug06\mat\site2'
                end
                blocks = [8:12];
                PC_block = 6;
        end
        
    case '06sep06'
        
        for i = 1:32
            groups(i).chans = i;;
            groups(i).name  = num2str(i);
        end
        switch site
            case 1
                if strcmp(PC,'tdt')
                    %                     datadir = 'h:\tdt_tank_backups\06sep06\mat\';
                    %                     combined_datadir = 'h:\tdt_tank_backups\06sep06\mat\site1';
                    datadir = 'h:\tdt_tank_backups\06sep06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\06sep06\mat\site1';
                end
                blocks = [1:18];
                PC_block = 1;
        end
    case '08sep06'
        for i = 1:32
            groups(i).chans = i;;
            groups(i).name  = num2str(i);
        end
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir =  'h:\tdt_tank_backups\08sep06\mat\';
                    combined_datadir =  'h:\tdt_tank_backups\08sep06\mat\site1';
                end
                blocks = [1:4];
                PC_block = 1;
        end
        switch site
            case 2
                if strcmp(PC,'tdt')
                    datadir =  'h:\tdt_tank_backups\08sep06\mat\';
                    combined_datadir =  'h:\tdt_tank_backups\08sep06\mat\site2';
                end
                blocks = [6:11];
                PC_block = 6;
        end
        
    case '13sep06'
        for i = 1:32
            groups(i).chans = i;;
            groups(i).name  = num2str(i);
        end
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'h:\tdt_tank_backups\13sep06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\13sep06\mat\site1';
                end
                blocks = [1:2];
                PC_block = 1;
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'h:\tdt_tank_backups\13sep06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\13sep06\mat\site2';
                end
                blocks = [3:8];
                PC_block = 3;
            case 3
                if strcmp(PC,'tdt')
                    datadir = 'h:\tdt_tank_backups\13sep06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\13sep06\mat\site3';
                end
                blocks = [9:10];
                PC_block = 10;
        end
        
    case '14sep06'
        for i = 1:32
            groups(i).chans = i;;
            groups(i).name  = num2str(i);
        end
        switch site
            case 1
                if strcmp(PC,'tdt')
                    datadir = 'h:\tdt_tank_backups\14sep06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\14sep06\mat\site1';
                end
                blocks = [1:4 6:7 9:11];
                PC_block = 1;
            case 2
                if strcmp(PC,'tdt')
                    datadir = 'h:\tdt_tank_backups\14sep06\mat\';
                    combined_datadir = 'h:\tdt_tank_backups\14sep06\mat\site2';
                end
                blocks = [13 14];
                PC_block = 13;
        end
        
    case '15sep06'
        datadir = [Hdisk exp_date filesep 'mat' filesep];
        
        switch site
            case 1
                combined_datadir = [datadir 'site' num2str(site)];
                blocks = [1:11];
                PC_block = 1;
        end
        
end
