function [names,times,types,blocks] = handle_event_exceptions_JFB(expdate,session,names,times,types,blocks);

switch lower(expdate)
      
    %%YSQ OTXR data
      case '16may14'
        switch session
            case 1
%                disp('no changes needed')
%                 [names,times,types,blocks] = insert_event(9,  1167.4799+20, 'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

               [names,times,types,blocks] = delete_eventS(4,[92 ,202],names,times,types,blocks); %%mremove messed ringer's entry missed trial
               [names,times,types,blocks] = delete_eventS(7,[20 ,133],names,times,types,blocks); %%mremove messed ringer's entry missed trial

        end
        
        
        
   %%YSQ OTXR data
      case '07may14'
        switch session
            case 1
                 [names,times,types,blocks] = insert_event(9,  1167.4799+20, 'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
        end
        
        

   case '26mar13'
        switch session
            case 1
                disp('no changes needed')
            case 2
%               [names,times,types,blocks] = delete_eventS(9,[153 ,154],names,times,types,blocks); %%mremove messed ringer's entry missed trial
%                 [names,times,types,blocks] = insert_event(9,  153.906       ,'odor applied'     ,'*VNS* Ringers_1F_2ul' ,names,times,types,blocks); 
%                 
%                 [names,times,types,blocks] = delete_eventS(9,[595 , 596],names,times,types,blocks); %%mremove female missed trial
%                 [names,times,types,blocks] = insert_event(9,  595.7643       ,'odor applied'     ,'*VNS* Female Urine_100F_2ul' ,names,times,types,blocks); 
% 
                

        end
     
   case '19mar13'
        switch session
            case 1
                disp('no changes needed')
            case 2
              
                %% switch two stimuli to the correct order--> JFB mistake
                %% during expt...
                [names,times,types,blocks] = delete_eventS(9,[153 ,154],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = insert_event(9,  153.906       ,'odor applied'     ,'*VNS* Ringers_1F_2ul' ,names,times,types,blocks); 
                
                [names,times,types,blocks] = delete_eventS(9,[595 , 596],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = insert_event(9,  595.7643       ,'odor applied'     ,'*VNS* Female Urine_100F_2ul' ,names,times,types,blocks); 

                

        end
    
    
   case '11jan13'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(6,  1228.7813 + 20 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
                
                %% switch two stimuli to the correct order--> JFB mistake
                %% during expt...
                [names,times,types,blocks] = delete_eventS(6,[1138 ,1139],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = insert_event(6,  1138.7734       ,'odor applied'     ,'*VNS* Female Urine_100F_2ul' ,names,times,types,blocks); 
                
                [names,times,types,blocks] = delete_eventS(7,[154 , 155],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = insert_event(7,  154.1349       ,'odor applied'     ,'*VNS* Ringers_1F_2ul' ,names,times,types,blocks); 

                

        end

    
   case '09nov12'
        switch session
            case 1
                st_clean_time = 614.807;                matlab_crash_block = 10;
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end
        
   case '31oct12'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(5,[285 , 395],names,times,types,blocks); %%mremove female missed trial
                st_clean_time = 1013.2415;                matlab_crash_block = 6;
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

            case 2

        end
    case '27sep12'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(3,[20 , 21],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = delete_eventS(3,[283 , 284],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = insert_event(3,  20.6851      ,'odor applied'     ,'*VNS* Ringers_1F_2ul' ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(3,  283.9909      ,'odor applied'     ,'*VNS* Female Urine_100F_2ul' ,names,times,types,blocks); 

            case 2
                [names,times,types,blocks] = insert_event(7,  1167.3541 + 20 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end
        
    case '26oct12'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(2,[0 , 543],names,times,types,blocks); %%mremove female missed trial
                [names,times,types,blocks] = insert_event(5,  776.5143 + 20 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

            case 2
                  [names,times,types,blocks] = delete_eventS(7,[70 , 71],names,times,types,blocks); %%mremove female missed trial
        end
        
        
        
        
    case '27jul12'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(2,[610 , 721],names,times,types,blocks); %%mremove female missed trial
            case 2
                disp('no errors')
        end
        
     case '09aug12'
        switch session
            case 1
                disp('no errors')
            case 2
                [names,times,types,blocks] = insert_event(8,  769.5376 + 20 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
        end
       

        

        
        
        
        
        
        
    case '25jan12'
        switch session
            case 2
                st_clean_time = 486.7772;
                matlab_crash_block = 6;
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 


        end

    
     case '24jan12'
        switch session
            case 2
                [names,times,types,blocks] = delete_eventS(8,[945 , 1056],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = delete_eventS(9,[552 , 1064],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)


        end
        
        
        
    case '18jan12'
        switch session
            case 1

            case 2
                st_clean_time = 487.5274;
                matlab_crash_block = 6;
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end

    case '14dec11'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(2,[295 , 296],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = insert_event(2,  295.585      ,'odor applied'     ,'*VNS* Ringers_1F_2ul' ,names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(2,[426 , 427],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = insert_event(2,  426.5112       ,'odor applied'     ,'*VNS* Male Urine_100F_2ul' ,names,times,types,blocks); 

            case 2
                st_clean_time = 481.8491;
                matlab_crash_block = 6;
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(matlab_crash_block,  st_clean_time + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end

    case '12dec11'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(3,[55 , 165],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)

            case 2
                [names,times,types,blocks] = insert_event(7,  376.9777 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  376.9777 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  376.9777 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end

    case '08dec11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2
                [names,times,types,blocks] = insert_event(7,  753.5432 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  753.5432 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  753.5432 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end

    case '07dec11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2
                disp('No fixes necessary')
            case 3
                [names,times,types,blocks] = insert_event(10,  487.8297 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(10,  487.8297 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(10,  487.8297 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

        end
    
    
    
    
    case '02dec11'
        switch session
            case 1
                disp('No fixes necessary')
        end
        
        
    case '01dec11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2
                [names,times,types,blocks] = insert_event(6,  485.1741 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  485.1741 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  485.1741 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
                
            case 3
                disp('No fixes necessary')
        end
   
    
    case '30nov11'
        switch session
            case 1
                disp('No fixes necessary')
        end

        
    case '15nov11'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(4,[682 , 683],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = insert_event(4,  682.8435      ,'odor applied'     ,'*VNS* Male Urine_100F_2ul' ,names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(4,[815 , 816],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = insert_event(4,  815.6488       ,'odor applied'     ,'*VNS* Predator Urine_100F_2ul' ,names,times,types,blocks); 
            case 2
                [names,times,types,blocks] = delete_eventS(11,[419 , 530],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = delete_eventS(11,[988 , 1099],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
                [names,times,types,blocks] = delete_eventS(11,[1134 , 1244],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
        end

    case '10nov11'
        switch session
            case 1

            case 2
                disp('No fixes necessary')
            case 3
                [names,times,types,blocks] = insert_event(10,  1038.4119 + 21 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 


        end

     case '03nov11'
        switch session
            case 1
                disp('No fixes necessary')

            case 2
                [names,times,types,blocks] = delete_eventS(8,[0 , 140],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)
            %% pred application was not recorded because of matlab crash 
                [names,times,types,blocks] = insert_event(7,  485.6916 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  485.6916 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  485.6916 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
            case 3


        end
   
    
    
    case '02nov11'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(4,[682 , 794],names,times,types,blocks); %%mremove second to last ringers application (this was missed and repeated)

            case 2
                [names,times,types,blocks] = insert_event(9,  375.4258 + 20 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
   
            case 3
             %% Ringers application was not recorded because of matlab crash 
                [names,times,types,blocks] = insert_event(13,  216.6599 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(13,  216.6599 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(13,  216.6599 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
                
                [names,times,types,blocks] = delete_eventS(13,[877 , 988],names,times,types,blocks); %%mremove first male application (this was missed and repeated)


        end

    case '20oct11'
        switch session
            case 1
                % duplication of predator
                [names,times,types,blocks] = delete_eventS(2,[155 , 265],names,times,types,blocks); %%mitake: applied female, repeated ringers
                [names,times,types,blocks] = delete_eventS(2,[844 , 955],names,times,types,blocks); %%mitake: applied female, repeated ringers

             %% pred application was not recorded because of matlab crash 
                [names,times,types,blocks] = insert_event(5,  214.58 + 30  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5,  214.58 + 31  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5,  214.58 + 50 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 
            case 2
                disp('No fixes necessary')

        end

    case '18oct11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2
             %% pred application was not recorded because of matlab crash 
               [names,times,types,blocks] = insert_event(7,  420       ,'odor applied'     ,'*VNS* Ringers_1F_2ul' ,names,times,types,blocks); 
                 [names,times,types,blocks] = insert_event(7,  420 + 20  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  420 + 21  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  420 + 60  ,'start clean'      ,'start clean'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  420 + 90  ,'stimulation'      ,'stimulation'          ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  420 + 91  ,'stimulation off'  ,'stimulation off'      ,names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(7,  420 + 110 ,'stop clean'       ,'stop clean'           ,names,times,types,blocks); 

              end

        case '29sep11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2
                disp('No fixes necessary')
            case 3

             %% pred application was not recorded because of matlab crash 
                [names,times,types,blocks] = insert_event(17,  721,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(17,  721 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(17,  721 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(17,  721 + 60 ,'start clean','start clean',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(17,  721 + 90 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(17,  721 + 91 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(17,  721 + 110 ,'stop clean','stop clean',names,times,types,blocks); 

              end

         case '26sep11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2

             %% pred application was 3 seconds early 
                [names,times,types,blocks] = delete_eventS(9,[1047 , 1048],names,times,types,blocks); %%mitake: applied female, repeated ringers
                [names,times,types,blocks] = insert_event(9,  1043 ,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks); 
              end

       case '21sep11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2

                %% matlab snd crash fix all ringer's was not recorded..
                [names,times,types,blocks] = insert_event(6,  435,'odor applied','*VNS* Ringers_1F_2ul',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  435 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  435 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  435 + 60 ,'start clean','start clean',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  435 + 90 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  435 + 91 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  435 + 110 ,'stop clean','stop clean',names,times,types,blocks); 
                
                %% delete missed predator application: event was repeated
                [names,times,types,blocks] = delete_eventS(8,[416.7 526.5],names,times,types,blocks); %%mitake: applied female, repeated ringers
        end


        case '20sep11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(6,  888 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  888 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  888 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
                
                
        end


        case '13sep11'
        switch session
            case 1
                disp('No fixes necessary')
            case 2

                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(6,  1025.5 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  1025.5 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6,  1025.5 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
                                [names,times,types,blocks] = delete_eventS(9,[287.2 397.8],names,times,types,blocks); %%mitake: applied female, repeated ringers

                
        end
        
        
  
        case '05aug11'
        switch session
            case 1
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(5, 215.276 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 215.276 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 215.276 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
            case 2
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(9, 911.06 + 20 ,'stop clean','stop clean',names,times,types,blocks); 
                
                [names,times,types,blocks] = insert_event(10, 349.856 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(10, 349.856 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(10, 349.856 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
                
        end

       case '21jul11'
        switch session
            case 1
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(5, 81.64 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 81.64 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 81.64 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                

        end
   
    
    
       case '19jul11'
        switch session
            case 1
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(5, 81.71 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 81.71 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 81.71 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
        end


       case '06jun11'
        switch session
            case 1
                %% the following is to fix two stimuli that were switched
                [names,times,types,blocks] = delete_eventS(3,[402.6 402.7],names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(3, 402.6261 ,'odor applied','*VNS* Est Female Urine_100F_2ul',names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(3,[534.2 534.3],names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(3, 534.277 ,'odor applied','*VNS* Female Urine_100F_2ul',names,times,types,blocks);
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(5, 251.2439 -21,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 251.2439 -20,'stimulation off','stimulation off',names,times,types,blocks); 

            case 2
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(9, 1016.1707 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(9, 1016.1707 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(9, 1016.1707 + 41 ,'stop clean','stop clean',names,times,types,blocks); 

        end
   
    
       case '03jun11'  %% Yoram used another mouse for sites 1 and 2 on this day. (2 mice 1 day)
        switch session
            case 3
                %% matlab snd crash fix
                [names,times,types,blocks] = insert_event(15, 351.6728 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(15, 351.6728 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(15, 351.6728 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
            case 4
                %% the following two were mistakes due to the stimulator
                % malfunctioning. The stimulator malfunctioned much of
                % this expt
                [names,times,types,blocks] = delete_eventS(18,[690 802],names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(19,[839 952],names,times,types,blocks); 

        end
   
    
      case '17may11'
        switch session
            case 1
                'no changes needed'
            case 2
                  [names,times,types,blocks] = insert_event(7, 1035 + 20 ,'stop clean','stop clean',names,times,types,blocks); 
                  [names,times,types,blocks] = delete_eventS(8,[166 277],names,times,types,blocks); 
        end
     
      case '19may11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(3, 1298.2281 + 20 ,'stop clean','stop clean',names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(2,[550 660],names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(2,[911 912],names,times,types,blocks); 
                
                [names,times,types,blocks] = insert_event(2, 911.5788-12,'odor applied','*VNS* Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(5,[86 89],names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(5,[146 256],names,times,types,blocks); 
                
                
                
%                 [names,times,types,blocks] = insert_event(6, 1188.8368 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
%                 [names,times,types,blocks] = insert_event(6, 1188.8368 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
%                 [names,times,types,blocks] = insert_event(6, 1188.8368 + 41 ,'start clean','start clean',names,times,types,blocks); 
%                 [names,times,types,blocks] = insert_event(6, 1188.8368 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
%                 [names,times,types,blocks] = insert_event(6, 1188.8368 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
%                 [names,times,types,blocks] = insert_event(6, 1188.8368 + 41 ,'stop clean','stop clean',names,times,types,blocks); 

%              43  block: 2 time: 911.5788 *VNS* Male Urine_100F_2ul
% 44  block: 2 time: 932.1027 stimulation
% 45  block: 2 time: 933.694 stimulation off
% 46  block: 2 time: 972.1427 start clean
% 47  block: 2 time: 999.035 stimulation
% 48  block: 2 time: 1000.6197 stimulation off
% 49  block: 2 time: 1021.0691 stop clean
%   
% %                 [names,times,types,blocks] = delete_eventS(5,[408 518],names,times,types,blocks); 
             case 2
                'no changes needed'
        end
  
    
      case '05may11'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(6, 1188.8368 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6, 1188.8368 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6, 1188.8368 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
             case 3
                 [names,times,types,blocks] = delete_eventS(11,[964 1027],names,times,types,blocks); 
             case 4
                [names,times,types,blocks] = insert_event(16, 777.8504 + 20 ,'stop clean','stop clean',names,times,types,blocks); 
        end


    case '20apr11'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(6, 496.6025 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6, 496.6025 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6, 496.6025 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
             case 3
                [names,times,types,blocks] = insert_event(11, 897.3615 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(11, 897.3615 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(11, 897.3615 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
               

        end

     case '24mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(6, 212.4375 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6, 212.4375 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(6, 212.4375 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
                [names,times,types,blocks] = insert_event(10, 81.6456 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(10, 81.6456 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(10, 81.6456 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
        end

     case '23mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5, 343.6838 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 343.6838 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5, 343.6838 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
                
                [names,times,types,blocks] = insert_event(9, 345.3534 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(9, 345.3534 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(9, 345.3534 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
        end


     case '11mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(4, 605.4109 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(4, 605.4109 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(4, 605.4109 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
        end

    
    case '09mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5,477.7868 + 20 ,'stimulation','stimulation',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5,477.7868 + 21 ,'stimulation off','stimulation off',names,times,types,blocks); 
                [names,times,types,blocks] = insert_event(5,477.7868 + 41 ,'stop clean','stop clean',names,times,types,blocks); 
        end
    
    
    case '23feb11'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(5,[821 933],names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(9,[155 247],names,times,types,blocks); 
                [names,times,types,blocks] = delete_eventS(10,[36 147],names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1290.505 - 20 ,'odor applied','*VNS* CBA Est Female Urine_100F_2ul',names,times,types,blocks);                
        end
     
    
    
    
    case '07dec10'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(8, 1198.5056  +20,'stop clean','stop clean',names,times,types,blocks);
                
             case 3
                [names,times,types,blocks] = insert_event(13, 982.3979  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13, 1127.284  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 117.7824  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 263.6281  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 410.023  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 631.4958  +40,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 706.4968  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 853.7258  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 1002.452  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14, 1150.5348  +20,'stop clean','stop clean',names,times,types,blocks);
            end
        
        
    
     case '09dec10'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(9, 1076.336  +20,'stop clean','stop clean',names,times,types,blocks);
         end

     case '10nov10'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(7, 1069.4893  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9, 389.1444  +20,'stop clean','stop clean',names,times,types,blocks);
        end

     case '29oct10'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(4, 1042.5255  +20,'stop clean','stop clean',names,times,types,blocks);
        end

        
        

        
      case '20oct10'
        switch session
            case 2
                %% last minute decision: gave cpd308@10 instead of MFP
                [names,times,types,blocks] = insert_event(12, 264.2049  +20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(10, 325.1692,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10, 325.1692,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                    [names,times,types,blocks] = delete_event(10, 463.413,names,times,types,blocks);
                    [names,times,types,blocks] = insert_event(10, 463.413,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                        [names,times,types,blocks] = delete_event(10, 880.7123,names,times,types,blocks);
                        [names,times,types,blocks] = insert_event(10, 880.7123,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                            [names,times,types,blocks] = delete_event(11, 301.6238,names,times,types,blocks);
                            [names,times,types,blocks] = insert_event(11, 301.6238,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                                [names,times,types,blocks] = delete_event(11, 582.8165,names,times,types,blocks);
                                [names,times,types,blocks] = insert_event(11, 582.8165,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                                    [names,times,types,blocks] = delete_event(11, 1149.5307,names,times,types,blocks);
                                    [names,times,types,blocks] = insert_event(11, 1149.5307,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                                        [names,times,types,blocks] = delete_event(11, 1594.458,names,times,types,blocks);
                                        [names,times,types,blocks] = insert_event(11, 1594.458,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);
                                            [names,times,types,blocks] = delete_event(12, 21.7422,names,times,types,blocks);
                                            [names,times,types,blocks] = insert_event(12, 21.7422,'odor applied','*VNS* CPD308 10um_100F_2ul',names,times,types,blocks);

               
        end
       
     case '10sep10'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(3,[416 658],names,times,types,blocks);                
        end
        
        
        
   
    case '28jul10'
        switch session
            case 1
                
                [names,times,types,blocks] = insert_event(5, 1242.4584  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6, 700.5601  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 427.4805  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 580.8227  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 735.5953  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 892.0466  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 1049.7744  +20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    case '20apr10'
        switch session
            case 2
                disp('Handle 20apr10')
                [names,times,types,blocks] = insert_event(6,  1231.7231 +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,  860.6553 +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9, 426.6774 +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9, 579.6816  +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9, 734.315  +20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
        
    case '13jul10'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5,  1388.1953 +20,'stop clean','stop clean',names,times,types,blocks);
                
        end
        
        
    case '21jul10'
        switch session
            case 1                
                [names,times,types,blocks] = insert_event(5,957.0626+20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(7,871.3264+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,581.6984+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,736.431+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,890.9962+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,128.1917+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,286.29+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,445.9125+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,769.6813+20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(9,1182.2039 - 30 ,'odor applied','*VNS* Pup odor_100F_2ul',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(10,51.4771 - 30 ,'odor applied','*VNS* Ringers_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,133.5769 + 20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(10,218.8125 - 30 ,'odor applied','*VNS* Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,301.1518 + 20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(10,471.7456 + 20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(10,560.7546 - 30 ,'odor applied','*VNS* Peromyscus Male_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,645.0483 + 20,'stop clean','stop clean',names,times,types,blocks);
                
        end
        
        
        
        
%     case '01oct09'
%         switch session
%             case 2
%                 [names,times,types,blocks] = delete_event(13,712.6941 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(13,737.2552 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(13,744.9532 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(12,360.0708 ,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(12,360.0708 ,'odor applied','*VNS* Ringers_1F_2ul',names,times,types,blocks);
%         end
%         
%         
        
        
        
        %%%%%%%%%%%%%%%%%  Sep 09 %%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '14sep09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(2,83.852+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,155.562+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,717.5737+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,523.3492+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1283.0959+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1470.6148+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '10sep09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(8, 1339.2616+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
%     case '09sep09'
%         switch session
%             case 2
%         end
%         
        
        
%     case '08sep09'
%         switch session
%             case 1
%         end
%         
%     case '04sep09'
%         switch session
%             case 3
%         end
%         
        
        
%     case '02sep09'
%         switch session
%             case 1
%                 [names,times,types,blocks] = delete_event(2, 1034.8227,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1055.6906  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2, 1061.0612 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1091.0514  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2, 1118.1852 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2, 1119.777  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,  1138.7342 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1140.3264 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2, 1161.1849 ,names,times,types,blocks);
%         end
        
        
        
%     case '01sep09'
%         switch session
%             case 3
%         end
%         
        
        
        
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%   Aug 09 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     case '20aug09'
%         switch session
%             case 1
%                 [names,times,types,blocks] = delete_event(2,151.0481 ,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(2,151.0481 ,'odor applied','*VNS* Female Urine_100F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,593.4057 ,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(2,593.4057 ,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,490.1464 ,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(3,490.1464 ,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,632.4183 ,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(3,632.4183 ,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
%                 
%             case 2
%                 [names,times,types,blocks] = delete_event(8,527.3665,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(8,527.3665,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,678.1828,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(8,678.1828,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,890.6644 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,924.5125 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,956.0458 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,957.6113 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9, 979.321 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9, 980.737  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,1003.6837 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,1020.4451  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(9,1045.36  ,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(8,45.973+40,'start clean','start_clean',names,times,types,blocks);
%         end
%         
%         
%         
%         
        
        %%%%%%%%%% Jul 09 %%%%%%%%%%%%%%%%%%%%%
        
        
        
    case '14jul09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5, 1220.9376+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,188.8285,names,times,types,blocks);
        end
        
        
    case '10jul09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(6, 1306.4781+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6, 1306.4781+21.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6, 1306.4781+41,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '02jul09'
        switch session
            case 1
        end
        
        
        
        
        
        
        
        
        %%%%%%%%%%%%% Jun 09 %%%%%%%%%%%%%%%%%%
        
        
    case '30jun09'
        switch session
            case 2
                % switch events
                [names,times,types,blocks] = delete_event(6,796.9911,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,796.9911,'odor suction','*MOS* Ringers_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,941.28,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,941.28,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
        end
        
        
    case '22jun09'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(8, 1240.3139+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 1620.8761+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '18jun09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(4,1205.4088+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '16jun09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(7, 1246.2655+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8, 345.2307+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
%     case '11jun09'
%         switch session
%             case 3
%                 [names,times,types,blocks] = delete_event(15,383.1734 ,names,times,types,blocks);
%         end
%         
        
        
    case '05jun09'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2,70.621,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2, 70.621,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,966.8072,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,1002.5917,names,times,types,blocks);
        end
        
        
%     case '04jun09'
%         switch session
%             case 1
%                 %     switch events
%                 [names,times,types,blocks] = delete_event(3,39.2685,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(3,39.2685,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,322.507,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(3,322.507,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(7,685.9726+20,'stop clean','stop clean',names,times,types,blocks);
%         end
%         
%         
%         
        
        
        %%%%%%%%%%%%%%  MAY 09  %%%%%%%%%%%%%%%%%%%%
        
        
%     case '20may09'
%         switch session
%             case 2
%                 [names,times,types,blocks] = insert_event(10,360.5184+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1103.1483+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,711.6182+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,906.5626+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1292.0465+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(8,1199.8921+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,155.8991+20,'stop clean','stop clean',names,times,types,blocks);

%         end
        
%     case '15may09'
%         switch session
%             case 1
%                 
%             case 2
%                 [names,times,types,blocks] = insert_event(13,1408.4366+20,'stop clean','stop clean',names,times,types,blocks);
%         end
%         
%         
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%% APRIL 09 %%%%%%%%%%%%%%%%%%%
%     case '14apr09'
%         switch session
%             case 2
%                 % Two truncated stop clean events
%                 [names,times,types,blocks] = insert_event(11,1096.8851+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(12,980.1978+20,'stop clean','stop clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(13,621.303+20,'stop clean','stop clean',names,times,types,blocks);
%                 
%                 % And another truncated event
%                 [names,times,types,blocks] = insert_event(13,1011.4329+20,'stimulation','stimulation',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6+20,'stimulation','stimulation',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
%                 
%                 % THese are start clean event that were lost, and are best
%                 % defined relative to the next stimulation event
%                 [names,times,types,blocks] = insert_event(13,594.0206-40,'start clean','start clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(13,818.4703-40,'start clean','start clean',names,times,types,blocks);
%         end
        
        
        
%     case '10apr09'
%         switch session
%             case 1
%                 % Add events aftyer this air pulse - nothing was sabved
%                 % after it
%                 % 604  block: 9 time: 1524.3745 one air pulse - 3 sec
%                 [names,times,types,blocks] = insert_event(9,1524.3745 + 38,'start clean','start clean',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20,'stimulation','stimulation',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6+20,'stimulation','stimulation',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
%                 
%                 % wrong trial
%                 [names,times,types,blocks] = delete_event(8,29.923,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,52.7028,names,times,types,blocks);
%                 [names28jul,times,types,blocks] = delete_event(8,54.2943,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,60.7429,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,95.2745,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,124.2712,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,125.8627,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,146.1883,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,147.7791,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,170.078,names,times,types,blocks);
%                 
%                 
%                 % wrong trial
%                 [names,times,types,blocks] = delete_event(8,1721.9485,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1746.6422,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1748.2367,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1755.3707,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1791.3406 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1821.9876,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1823.5817,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1844.8651,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1846.3492,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(8,1869.2767,names,times,types,blocks);
%                 
%                 
%         end
        
        
        %
        %
        %     case '07apr09'
        %         switch session
        %             case 1
        %
        %                 % delete one trial
        %                 [names,times,types,blocks] = delete_event(4,177.5009 ,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4, 199.2436,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,200.775 ,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,206.505 ,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,239.91,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,267.7033 ,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,269.2946 ,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,288.651,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,290.2409 ,names,times,types,blocks);
        %                 [names,times,types,blocks] = delete_event(4,311.2904 ,names,times,types,blocks);
        %
        %                 % Truncated stop clean events
        %                 [names,times,types,blocks] = insert_event(7,721.1576+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(7,911.5186+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(7,1299.2321+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(9,616.7375+20,'stop clean','stop clean',names,times,types,blocks);
        %
        %
        %
        %                 [names,times,types,blocks] = insert_event(8,163.8354 +20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(8,568.214 +20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(8,978.9324+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(8,1189.5759+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(8,1402.8402+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(9,175.9892+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(9,394.3691+20,'stop clean','stop clean',names,times,types,blocks);
        %
        %                 [names,times,types,blocks] = insert_event(9,841.1768+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(9,1067.9439+20,'stop clean','stop clean',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(9,1300.7444+20,'stop clean','stop clean',names,times,types,blocks);
        %
        %                 [names,times,types,blocks] = insert_event(9,1173.5389+13,'one air pulse - 3 sec','one air pulse - 3 sec',names,times,types,blocks);
        %                 [names,times,types,blocks] = insert_event(9,813.5238-40,'start clean','start clean',names,times,types,blocks);
        %
        %         end
        %
        %
        
        
%     case '03apr09'
%         switch session
%             case 1
%                 
%                 
%                 %     switch
%                 
%                 [names,times,types,blocks] = delete_event(2,716.1288,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(2,716.1288,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,869.8305,names,times,types,blocks);
%                 [names,times,types,blocks] = insert_event(2,869.8305,'odor applied','*VNS+MOS* Female Urine_100F_2ul',names,times,types,blocks);
%                 
%                 % delete one trial
%                 [names,times,types,blocks] = delete_event(2,1135.5103 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1156.4275 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1158.0245  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1162.0765 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1197.8836 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1225.0198 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2, 1226.6132,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1245.572 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2,1247.1603 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(2, 1267.959 ,names,times,types,blocks);
%                 
%                 
%                 % delete one trial
%                 [names,times,types,blocks] = delete_event(3, 651.2943,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,673.1543 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3, 674.7438,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,679.1797 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,715.6857 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3, 743.4451,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3, 744.9781,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3,764.3331 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3, 765.9235,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(3, 787.0025,names,times,types,blocks);
%                 
%                 
%                 % Delete one trial
%                 [names,times,types,blocks] = delete_event(4,682.4208  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,705.4981 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,707.0881 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,712.3849  ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,759.4317 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4, 789.9008 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,791.4891 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4, 811.6129 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,813.2027 ,names,times,types,blocks);
%                 [names,times,types,blocks] = delete_event(4,834.8053 ,names,times,types,blocks);
%                 
%                 
%                 
%         end
        
        
        
     otherwise
        disp('file not found in handle_event_exceptions_JFB')
       
        
        
        
        
        
        
        
        
end






















function  [names,times,types,blocks] = insert_event(new_block,new_time,new_type,new_name,names,times,types,blocks);

% Find the previous event:
sameblock = find(blocks == new_block);
these_times = times(sameblock);
if new_time < these_times(1)
    new_pos = sameblock(1);
elseif new_time > these_times(end)
    new_pos = sameblock(end) + 1;
else
    [ignore new_pos ] = max(find(these_times < new_time));
    new_pos = sameblock(new_pos) + 1;
end

tmp_names(1:new_pos-1) = names(1:new_pos-1);
tmp_times(1:new_pos-1) = times(1:new_pos-1);
tmp_types(1:new_pos-1) = types(1:new_pos-1);
tmp_blocks(1:new_pos-1) = blocks(1:new_pos-1);

tmp_names{new_pos} = new_name;
tmp_times(new_pos) = new_time;
tmp_types{new_pos} = new_type;
tmp_blocks(new_pos) = new_block;

remaining = length(times(new_pos:end));

tmp_names(new_pos+1:new_pos+remaining) = names(new_pos:end);
tmp_times(new_pos+1:new_pos+remaining) = times(new_pos:end);
tmp_types(new_pos+1:new_pos+remaining) = types(new_pos:end);
tmp_blocks(new_pos+1:new_pos+remaining) = blocks(new_pos:end);

names = tmp_names;
times = tmp_times;
types = tmp_types;
blocks = tmp_blocks;

return







% Delete a range of events within a certain time range in a given block
function  [names,times,types,blocks] = delete_eventS(new_block,new_timeS,names,times,types,blocks);

ei = find(blocks == new_block);
del_times = find(times > new_timeS(1) & times < new_timeS(2));
eis = intersect(ei,del_times);

if isempty(eis)
    disp('events not found for deletion - handle event exceptions');
    return
end

names(eis) = [];
times(eis) = [];
types(eis) = [];
blocks(eis) = [];


return












function  [names,times,types,blocks] = delete_event(new_block,new_time,names,times,types,blocks);

% Find the event:
ei = find(blocks == new_block & round(times*100) == round(new_time*100));
if isempty(ei)
    ei = find(blocks == new_block & round(times*1000) == round(new_time*1000));
end
if isempty(ei)
    ei = find(blocks == new_block & round(times*10000) == round(new_time*10000));
end


if isempty(ei)
    disp('event not found for deletion - handle event exceptions');
    return
end

names(ei) = [];
times(ei) = [];
types(ei) = [];
blocks(ei) = [];

return



