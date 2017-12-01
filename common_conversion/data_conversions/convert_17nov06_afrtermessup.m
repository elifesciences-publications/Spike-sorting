% a script to load and rename the 17 of Nov sorting day i which I induced some mess

% These were the original discrepancies
% OK did not find a database entry for 2203 on 17nov06 session 1
% did not find a database entry for 2304 on 17nov06 session 1
% Ok did not find a database entry for 3204 on 17nov06 session 1
% OK did not find a database entry for 3205 on 17nov06 session 1
% OK did not find a database entry for 3206 on 17nov06 session 1
% OK did not find a database entry for 3207 on 17nov06 session 1
% OK did not find a database entry for 3208 on 17nov06 session 1
% OK did not find a database entry for 3303 on 17nov06 session 1
% OK did not find a database entry for 3304 on 17nov06 session 1
% OK did not find a database entry for 3305 on 17nov06 session 1
% OK did not find a database entry for 3306 on 17nov06 session 1
% OK - did not find a database entry for 4302 on 17nov06 session 1 



clear
load('c:\data\offline_sorted\AllSpikes_17nov06_1');

Nfiles = length(SpikeClass)

AllClasses = [];
for i = 1:Nfiles
    AllClasses = [AllClasses SpikeClass{i}'];
end

UniqueClasses = unique(AllClasses);

for i = 1:length(UniqueClasses)
    N(i) = length(find(AllClasses == UniqueClasses(i)));
    disp([num2str(UniqueClasses(i)) ' -> ' num2str(N(i))])
end

% Conclusion 1:
% Everything that was 4302 is now 4301
% 3301 and 3302 are now 3301
% 3303-3306 are now 3302
% 3203,4,5,6,7,8 are now 3203
% 2203 is 2202
% 2302 and 2303 are now 2302
% 2304 is 2303

% NOw do the transformation
% SpikeClass2 = SpikeClass;
for i = 1:Nfiles
    Class = SpikeClass{i};
    Rels = find(Class == 4302);     Class(Rels) = 4301;
    
    Rels = find(Class == 3302);     Class(Rels) = 3301;   
    
    Rels = find(Class == 3303);     Class(Rels) = 3302;    
    Rels = find(Class == 3304);     Class(Rels) = 3302;    
    Rels = find(Class == 3305);     Class(Rels) = 3302;    
    Rels = find(Class == 3306);     Class(Rels) = 3302;    
    
    Rels = find(Class == 3204);     Class(Rels) = 3203;        
    Rels = find(Class == 3205);     Class(Rels) = 3203;            
    Rels = find(Class == 3206);     Class(Rels) = 3203;                
    Rels = find(Class == 3207);     Class(Rels) = 3203;                    
    Rels = find(Class == 3208);     Class(Rels) = 3203;                    

    Rels = find(Class == 2203);     Class(Rels) = 2202;                

    Rels = find(Class == 2303);     Class(Rels) = 2302;                    
    
    Rels = find(Class == 2304);     Class(Rels) = 2303;  
    
    SpikeClass{i} = Class;
end


% AllClasses2 = [];
% for i = 1:Nfiles
%     AllClasses2 = [AllClasses2 SpikeClass2{i}'];
% end
% 
% UniqueClasses2 = unique(AllClasses2);
% 
% for i = 1:length(UniqueClasses2)
%     N2(i) = length(find(AllClasses2 == UniqueClasses2(i)));
%     disp([num2str(UniqueClasses2(i)) ' -> ' num2str(N2(i))])
% end

save('c:\data\offline_sorted\AllSpikes_17nov06_1','SpikeClass','SpikeTimes');
    