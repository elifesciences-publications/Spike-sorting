function [OK] = pre_process_JFB(tasks,groups,do_groups,datadir,combined_datadir,blocks,PC_block,...
DT,Tb,Ta,SR,Npcs,IBI,ThreshFact,acDT,ArtRatio,DO_TIME);
% this file, called by call_process.m organizes the crucial stages of data
% processing - after the data has been converted by call_mat2buz

OK = 0;

if ~(exist(combined_datadir) == 7)
        mkdir(combined_datadir);
end

         %%Process log file JFB CHANGE
         temp_slashes=findstr(datadir,filesep); %%JFB edit
         temp_slashes=temp_slashes(end-2:end-1); %%JFB edit
         exp_name=datadir(temp_slashes(1)+1:temp_slashes(2)-1); %%JFB edit
         log_file_path=[datadir,exp_name,'_process_log.txt']; %%JFB edit
         %%%%%%%%%%%% write the log file %%%%%%%%%%%
         log_fid = fopen(log_file_path,'a+') %%open the log file and append data to the end
         fprintf(log_fid, '\n\n\n%s',['--------------------------Begin PreProcess----------------------------']); %%JFB edit
         
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


         
%%%%%%%%%%%%%%%%%%%



% Data must be checked before starting
if tasks(1) % CHECK
    disp(['checking data completeness'])
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Data Completeness check:'],['Begun :',datestr(now)]); %%JFB edit

    passed = check_elecdata_completeness(datadir,combined_datadir,groups,do_groups,blocks);
    if ~passed     
        fprintf(log_fid, '\n\t\t%s',['FAILED :']);
        fclose(log_fid);
        return
    end
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit
end

disp(['processing ' datadir ' combined results in ' combined_datadir])


if tasks(2) % DETECT

    tic
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Detect Spikes:'],['Begun :',datestr(now)]); %%JFB edit

    disp(['detecting'])
    detect(datadir,combined_datadir,SR,groups,do_groups,blocks,DT,Tb,Ta,ThreshFact,acDT,ArtRatio);
    disp([' detection took ' num2str(toc/60) ' mins'])
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit

    
end
pack


if tasks(3) % EXTRACT
    tic
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Extract Waveforms:'],['Begun :',datestr(now)]); %%JFB edit

    disp(['extracting'])
    extract_perchan(datadir,combined_datadir,groups,do_groups,blocks,Tb,Ta,SR,IBI);
    disp([' extraction took ' num2str(toc/60) ' mins']);
    
    % Combine the spike files that were generated in this stage - this is
    % for the Klusters program
    disp(['combining spike files'])
    make_combined_spk_files_from_perchan(datadir,combined_datadir,groups,do_groups,blocks,Tb,Ta,SR,IBI);
    disp([' combining spike files took ' num2str(toc/60) ' mins'])
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit

    
end
pack


if tasks(4) %CALCULATE_PCS
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Calculate PCs:'],['Begun :',datestr(now)]); %%JFB edit

    
    % Peak sample for spike detection
    Si = 1/(SR/1000); % sampling interval (ms)
    Sb = round(Tb/Si); % samples before
    PeakSamp = Sb + 1;

    tic
    disp(['calculating PCs'])
    OK = calculate_pcs_perchan(datadir,combined_datadir,groups,do_groups,PC_block,blocks,PeakSamp)
    disp([' PC calculation took ' num2str(toc/60) ' mins'])
    
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit

end
pack

if tasks(5) %PROJECT
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Project spikes and extract features:'],['Begun :',datestr(now)]); %%JFB edit
    
     % Peak sample for spike detection
    Si = 1/(SR/1000); % sampling interval (ms)
    Sb = round(Tb/Si); % samples before
    PeakSamp = Sb + 1;
    
    
    tic
    disp(['projecting spikes and extracting other features'])
    OK = project_perchan(combined_datadir,groups,do_groups,blocks,Npcs,PeakSamp,DO_TIME);
    disp([' projection took ' num2str(toc/60) ' mins'])
    
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit

end
pack


if tasks(6) % Classify
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Classify spikes with KlustaKwik:'],['Begun :',datestr(now)]); %%JFB edit

    tic
    disp('starting classification using KlustaKwik');
    for i = 1:length(do_groups)      

        
        %NOT GOOD YET - CONSTRUCT RIGHT STRING !!!!
        
        % build the feature string:
        FeatStr = [];
        for j = 1:(length(groups(do_groups(i)).chans)*Npcs)
            FeatStr = [FeatStr '1'];
        end
        
%         % These are added for the time, approximation error
%         for j = 1:2
%             FeatStr = [FeatStr '0'];
%         end
% 
%          % These are added for the up and down values for each channel
%         for j = 1:(length(groups(do_groups(i)).chans)*2)
%             FeatStr = [FeatStr '0'];
%         end
        
        eval(['! KlustaKwik ' combined_datadir 'group' groups(do_groups(i)).name filesep 'combined' groups(do_groups(i)).name ' 1' ' -MinClusters 8 -MaxClusters 16 -UseFeatures ' FeatStr ]);
      
    end
    disp([' clustering took ' num2str(toc/60) ' mins']); 
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit

end


    fprintf(log_fid, '\n\n%s',['---------------------------End PreProcess-----------------------------']);  %%JFB edit
    fclose(log_fid);    %%JFB edit
   
    
 


return
        

