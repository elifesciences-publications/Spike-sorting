function post_process(tasks,groups,do_groups,datadir,combined_datadir,blocks,IBI,SR,Ta,Tb,ybs_datestr,ybs_site);

%%%JFB edit 
%%input datestr was changed to ybs_datestr to avoid confusion with the
%%matlab function datestr

Si = 1/(SR/1000); % sampling interval (ms)
Sb = round(Tb/Si); % samples before
Sa = round(Ta/Si); % samples after
SpikeLen = Sb + Sa + 1;


         %%Process log file JFB CHANGE
         temp_slashes=findstr(datadir,filesep); %%JFB edit
         temp_slashes=temp_slashes(end-2:end-1); %%JFB edit
         exp_name=datadir(temp_slashes(1)+1:temp_slashes(2)-1); %%JFB edit
         log_file_path=[datadir,exp_name,'_process_log.txt']; %%JFB edit
         %%%%%%%%%%%% write the log file %%%%%%%%%%%
         log_fid = fopen(log_file_path,'a+') %%open the log file and append data to the end
         fprintf(log_fid, '\n\n\n%s',['--------------------------Begin PostProcess----------------------------']); %%JFB edit
         
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if tasks(1) %
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Classify noise:'],['Begun :',datestr(now)]); %%JFB edit

    tic
    disp(['classifying noise'])
    classify_noise(datadir,combined_datadir,groups,do_groups,SpikeLen);
    disp([' noise classification took ' num2str(toc/60) ' mins'])
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit


end

if tasks(2) %
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Reorder by amplitude:'],['Begun :',datestr(now)]); %%JFB edit

    tic
    disp(['reordering by amplitude'])
    reorder_by_amplitude(datadir,combined_datadir,groups,do_groups,SpikeLen);
    disp([' cluster reordering took ' num2str(toc/60) ' mins'])
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit
end


if tasks(3) %DIVIDE_COMBINED_CLUSTER_FILES
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Divide files:'],['Begun :',datestr(now)]); %%JFB edit
    tic
    disp(['dividing cluster files'])
    divide_combined_cluster_files(combined_datadir,datadir,groups,do_groups,blocks,IBI,SR)
    disp([' file division took ' num2str(toc/60) ' mins'])
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit
end


if tasks(4) %COMBINE AND REFORMAT
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Combine and reformat:'],['Begun :',datestr(now)]); %%JFB edit
    tic
    disp(['dividing cluster files'])
    combine_and_reformat_clusters(combined_datadir,datadir,groups,do_groups,blocks,IBI,SR,ybs_datestr,ybs_site)
    disp([' file division took ' num2str(toc/60) ' mins'])
    
    
    tic
    disp(['making spike lin file'])
    update_to_spike_lib(datadir,combined_datadir,groups,do_groups,SpikeLen);
    disp(['library file generation took ' num2str(toc/60) ' mins'])
    
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit


end


if tasks(5) %Delete original data files
    fprintf(log_fid, '\n\n\t%s\n\t\t%s',['Delete original files:'],['Begun :',datestr(now)]); %%JFB edit
    disp(['deleting original source files'])
    delete_source_data_files(datadir);
    fprintf(log_fid, '\n\t\t%s',['Finished :',datestr(now)]); %%JFB edit
end


    fprintf(log_fid, '\n\n%s',['---------------------------End PreProcess-----------------------------']);  %%JFB edit
    fclose(log_fid);    %%JFB edit
return


