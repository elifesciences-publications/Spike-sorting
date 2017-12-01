function [names,times,types,blocks] = handle_event_exceptions(expdate,session,names,times,types,blocks);


switch expdate
            
    case '24mar11'
        switch session
            case 2                             
                             
                [names,times,types,blocks] = delete_eventS(7,[946 1056],names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(10,81.6456+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,81.6456+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,81.6456+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
                
                
                [names,times,types,blocks] = insert_event(6,212.4375+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,212.4375+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,212.4375+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
                
                
        end
    
      case '22mar11'
        switch session
            case 1
                                           
                [names,times,types,blocks] = insert_event(5,81.2624+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,81.2624+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(9,81.2956+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,81.2956+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                                                                              
        end


    

    case '17mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5,81.5438+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,81.5438+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);              
                
                [names,times,types,blocks] = insert_event(8,476.3546+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,476.3546+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
               
                
                
             %   [names,times,types,blocks] = insert_event(10,213.2798+20,'stimulation','stimulation',names,times,types,blocks);
             %   [names,times,types,blocks] = insert_event(10,213.2798+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
        end


    
     case '14mar11'
        switch session
            case 3
                [names,times,types,blocks] = insert_event(6,748.0524+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,748.0524+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(10,213.2798+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,213.2798+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                
       
                
         %       [names,times,types,blocks] = insert_event(5,81.01982+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
                
         %       [names,times,types,blocks] = insert_event(9,344.1357+20,'stimulation','stimulation',names,times,types,blocks);
         %       [names,times,types,blocks] = insert_event(9,344.1357+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);                              
                
        end
    
    
    
    case '04mar11'
        switch session
            case 1
                
  

              %  [names,times,types,blocks] = delete_event(7,502.5783,names,times,types,blocks);
              %  [names,times,types,blocks] = insert_event(7,523.049+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                
                
      %          [names,times,types,blocks] = delete_event(7,633.6514,names,times,types,blocks);
      %          [names,times,types,blocks] = insert_event(7,654.2087+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                
         %       [names,times,types,blocks] = delete_event(7,764.8884,names,times,types,blocks);
         %       [names,times,types,blocks] = insert_event(7,785.4402+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                                                
                
                [names,times,types,blocks] = insert_event(4,475.7851+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,475.7851+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,475.7851+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
%                
                 [names,times,types,blocks] = insert_event(7,868.0105+20,'stimulation','stimulation',names,times,types,blocks);
                 [names,times,types,blocks] = insert_event(7,868.0105+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);            
                 [names,times,types,blocks] = insert_event(7,868.0105+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);



            %     [names,times,types,blocks] = insert_event(7,474.3924+20,'stimulation','stimulation',names,times,types,blocks);
            %     [names,times,types,blocks] = insert_event(7,474.3924+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                 % This was a very brief clean below
            %     [names,times,types,blocks] = insert_event(7,474.3924+20+1.6+4,'stop clean','stop clean',names,times,types,blocks);
        end


    case '08mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5,81.0198+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,81.0198+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,81.01982+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(9,344.1357+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,344.1357+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);                              
                
        end
        
    case '07mar11'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(5,764.9357 +20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    
    
    case '21feb11'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(12,289.1316,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(12,289.1316,'odor applied','*VNS* Bobcat urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,181.7816,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,181.7816,'odor applied','*VNS* Rat Urine_100F_2ul',names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(8,6.5447,names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(6,216.7852+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,216.7852+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,216.7852+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
        end
                             
    
    case '08dec10'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(5,1384.1354 +20,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '02nov10'
        switch session
            case 2
                [names,times,types,blocks] = delete_eventS(5,[468 579],names,times,types,blocks);
                
        end
        
    case '12nov10'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(6,1201.8819+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '02nov10'
        switch session
            case 1
                [names,times,types,blocks] = delete_eventS(2,[95 205],names,times,types,blocks);
                
            case 2
                [names,times,types,blocks] = delete_eventS(6,[714 738],names,times,types,blocks);
                
            case 3
                [names,times,types,blocks] = insert_event(10,1289.5973+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1464.9332+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '22jul10'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(3,1126.821,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,1126.821,'odor applied','*VNS* CBA Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1380.2297,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,1380.2297,'odor applied','*VNS* C57 Male Urine_100F_2ul',names,times,types,blocks);
        end
        
        
    case '23apr10'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2,81.9798,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,69.0256,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,69.0256,'odor applied','*VNS* Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,306.1015,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,306.1015,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
                
                
            case 3
                [names,times,types,blocks] = insert_event(10, 1142.9909+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '22apr10'
        switch session
            case 1
                %    [names,times,types,blocks] = insert_event(7,704.5986+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(5,[290 412],names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(4,[335 450],names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(7,[20 141],names,times,types,blocks);
            case 2
                [names,times,types,blocks] = insert_event(10,501.8638+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1119.3862+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1282.3854+20,'stop clean','stop clean',names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(9,139.3694,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,845.1872,names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_eventS(10,[1360 1451],names,times,types,blocks);
        end
        
        
        
    case '14apr10'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2,250.9404,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,252.5047,names,times,types,blocks);
            case 2
                [names,times,types,blocks] = insert_event(5,1224.0361+20,'stop clean','stop clean',names,times,types,blocks);
            case 4
                [names,times,types,blocks] = insert_event(11,1053.9085 -20,'start clean','start clean',names,times,types,blocks);
                
        end
        
        
    case '08apr10'
        switch session
            case 4
                [names,times,types,blocks] = insert_event(12,1216.7052+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1022.4765+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1201.5815+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14,149.627+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14,380.5625 +20,'stop clean','stop clean',names,times,types,blocks);
                
                
                [names,times,types,blocks] = insert_event(14,1365.1656-20,'odor applied','*VNS* CBA Est Female Urine_100F_2ul',names,times,types,blocks);
                
        end
        
        
    case '05apr10'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(7,1060.5259+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,759.8518+20,'stop clean','stop clean',names,times,types,blocks);
                
                
                % change event identity
                [names,times,types,blocks] = delete_event(2,487.3914,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,487.3914,'odor applied','*VNS* CBA Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,260.0539,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,260.0539,'odor applied','*VNS* C57 Male Urine_100F_2ul',names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(7,73.6908,names,times,types,blocks);
                
                
                % THis never happened, having to insert an application
                % event, not good
                [names,times,types,blocks] = insert_event(9,1137.7759+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1224.2745-20,'odor applied','*VNS* CBA Est Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1331.5457+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,52.2652-20,'odor applied','*VNS* BC Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,247.9492-20,'odor applied','*VNS* BC Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,497.4316-20,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,605.8918+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,697.7178-20,'odor applied','*VNS* CBA Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,808.2484+20,'stop clean','stop clean',names,times,types,blocks);
                
                
                [names,times,types,blocks] = insert_event(9,519.506+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,595.2041+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,773.7376+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,952.8851+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1133.403+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,151.6076+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,334.7893+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,356.0357 +20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(9,654.9103-20,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
        end
        
        
    case '01apr10'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(7,704.5986+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(9,[590 740]  ,names,times,types,blocks);
        end
        
        
    case '09mar10'
        switch session
            case 1
                % Delete a range of events - a newly introduced function
                % that takes care of the need to include each element
                % separately
                [names,times,types,blocks] = delete_eventS(2,[535 671]  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(2,[1170 1310]  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_eventS(4,[20 157]  ,names,times,types,blocks);
            case 2
                % change event identity
                [names,times,types,blocks] = delete_event(10,346.9269,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,346.9269,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
        end
        
    case '01oct09'
        switch session
            case 2
                [names,times,types,blocks] = delete_event(13,712.6941 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,737.2552 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,744.9532 ,names,times,types,blocks);
                
                
                
                [names,times,types,blocks] = delete_event(12,360.0708 ,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(12,360.0708 ,'odor applied','*VNS* Ringers_1F_2ul',names,times,types,blocks);
        end
        
        
        
    case '11jun09'
        switch session
            case 3
                [names,times,types,blocks] = delete_event(15,383.1734 ,names,times,types,blocks);
        end
        
    case '02sep09'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2, 1034.8227,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1055.6906  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2, 1061.0612 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1091.0514  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2, 1118.1852 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2, 1119.777  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,  1138.7342 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1140.3264 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2, 1161.1849 ,names,times,types,blocks);
        end
        
        
    case '20aug09'
        switch session
            
            case 1
                [names,times,types,blocks] = delete_event(2,151.0481 ,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,151.0481 ,'odor applied','*VNS* Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,593.4057 ,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,593.4057 ,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
                
                
                
                [names,times,types,blocks] = delete_event(3,490.1464 ,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,490.1464 ,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,632.4183 ,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,632.4183 ,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
                
            case 2
                
                % switch events
                [names,times,types,blocks] = delete_event(8,527.3665,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,527.3665,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,678.1828,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,678.1828,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(9,890.6644 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,924.5125 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,956.0458 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,957.6113 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9, 979.321 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9, 980.737  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,1003.6837 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,1020.4451  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,1045.36  ,names,times,types,blocks);
                
                
                
                
                
                [names,times,types,blocks] = insert_event(8,45.973+40,'start clean','start_clean',names,times,types,blocks);
        end
        
    case '08jul09'
        switch session
            case 3
                
                [names,times,types,blocks] = delete_event(7,943.6231,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,943.6231,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,1083.9622,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,1083.9622,'odor suction','*MOS* Predator Urine_10F_2ul',names,times,types,blocks);
        end
        
    case '30jun09'
        switch session
            case 2
                % switch events
                [names,times,types,blocks] = delete_event(6,796.9911,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,796.9911,'odor suction','*MOS* Ringers_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,941.28,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,941.28,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
        end
        
        
    case '30jun09'
        switch session
            case 2
                % switch events
                [names,times,types,blocks] = delete_event(6,796.9911,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,796.9911,'odor suction','*MOS* Ringers_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,941.28,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,941.28,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
        end
        
        
        
        
    case '18jun09'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(4,1205.4088+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '04jun09'
        switch session
            case 1
                %     switch events
                [names,times,types,blocks] = delete_event(3,39.2685,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,39.2685,'odor suction','*MOS* Male Urine_10F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,322.507,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,322.507,'odor suction','*MOS* Female Urine_10F_2ul',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(7,685.9726+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '20may09'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(10,360.5184+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1103.1483+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,711.6182+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,906.5626+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1292.0465+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1199.8921+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,155.8991+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '15may09'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(13,1408.4366+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
        %
        %     case '15may09'
        %         switch session
        %             case 2
        %                 [names,times,types,blocks] = insert_event(13,1408.4366+20,'stop clean','stop clean',names,times,types,blocks);
        %         end
        
        
        
    case '03apr09'
        switch session
            case 1
                
                
                %     switch
                
                [names,times,types,blocks] = delete_event(2,716.1288,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,716.1288,'odor applied','*VNS* Predator Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,869.8305,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,869.8305,'odor applied','*VNS+MOS* Female Urine_100F_2ul',names,times,types,blocks);
                
                % delete one trial
                [names,times,types,blocks] = delete_event(2,1135.5103 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1156.4275 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1158.0245  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1162.0765 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1197.8836 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1225.0198 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2, 1226.6132,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1245.572 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1247.1603 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2, 1267.959 ,names,times,types,blocks);
                
                
                % delete one trial
                [names,times,types,blocks] = delete_event(3, 651.2943,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,673.1543 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3, 674.7438,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,679.1797 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,715.6857 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3, 743.4451,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3, 744.9781,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,764.3331 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3, 765.9235,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3, 787.0025,names,times,types,blocks);
                
                
                % Delete one trial
                [names,times,types,blocks] = delete_event(4,682.4208  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,705.4981 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,707.0881 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,712.3849  ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,759.4317 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4, 789.9008 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,791.4891 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4, 811.6129 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,813.2027 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,834.8053 ,names,times,types,blocks);
                
                
                
        end
        
    case '07apr09'
        switch session
            case 1
                
                % delete one trial
                [names,times,types,blocks] = delete_event(4,177.5009 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4, 199.2436,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,200.775 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,206.505 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,239.91,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,267.7033 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,269.2946 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,288.651,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,290.2409 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,311.2904 ,names,times,types,blocks);
                
                % Truncated stop clean events
                [names,times,types,blocks] = insert_event(7,721.1576+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,911.5186+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,1299.2321+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,616.7375+20,'stop clean','stop clean',names,times,types,blocks);
                
                
                
                [names,times,types,blocks] = insert_event(8,163.8354 +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,568.214 +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,978.9324+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1189.5759+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1402.8402+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,175.9892+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,394.3691+20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(9,841.1768+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1067.9439+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1300.7444+20,'stop clean','stop clean',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(9,1173.5389+13,'one air pulse - 3 sec','one air pulse - 3 sec',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,813.5238-40,'start clean','start clean',names,times,types,blocks);
                
        end
        
        
        
        
        
    case '14apr09'
        switch session
            case 2
                % Two truncated stop clean events
                [names,times,types,blocks] = insert_event(11,1096.8851+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(12,980.1978+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,621.303+20,'stop clean','stop clean',names,times,types,blocks);
                
                % And another truncated event
                [names,times,types,blocks] = insert_event(13,1011.4329+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1011.4329+20+1.6+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
                
                % THese are start clean event that were lost, and are best
                % defined relative to the next stimulation event
                [names,times,types,blocks] = insert_event(13,594.0206-40,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,818.4703-40,'start clean','start clean',names,times,types,blocks);
        end
        
        
        
    case '10apr09'
        switch session
            case 1
                % Add events aftyer this air pulse - nothing was sabved
                % after it
                % 604  block: 9 time: 1524.3745 one air pulse - 3 sec
                [names,times,types,blocks] = insert_event(9,1524.3745 + 38,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6+20+1.6,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1524.3745 + 38+20+1.6+20+1.6+20,'stop clean','stop clean',names,times,types,blocks);
                
                % wrong trial
                [names,times,types,blocks] = delete_event(8,29.923,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,52.7028,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,54.2943,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,60.7429,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,95.2745,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,124.2712,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,125.8627,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,146.1883,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,147.7791,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,170.078,names,times,types,blocks);
                
                
                % wrong trial
                [names,times,types,blocks] = delete_event(8,1721.9485,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1746.6422,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1748.2367,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1755.3707,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1791.3406 ,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1821.9876,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1823.5817,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1844.8651,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1846.3492,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1869.2767,names,times,types,blocks);
                
                
        end
        
        
    case '05mar09'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(7,707.3015 +20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1186.5675+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1824.2111+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '04mar09'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2,329.8839,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,329.8839,'odor applied','Predator Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,482.6121,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,482.6121,'odor applied','Ringers_1F_2ul',names,times,types,blocks);
        end
        
        
        
    case '27feb09'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(5,378.9878,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,378.9878,'odor applied','KCL_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,550.2786,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,550.2786,'odor applied','Ringers_1F_2ul',names,times,types,blocks);
        end
        
    case '13feb09'
        switch session
            case 2
                [names,times,types,blocks] = insert_event(8,1011.9516+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,701.2347+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1074.9667+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '13jun08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2,632.4792,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,653.2592,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,654.8492,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,693.5762,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,720.3955,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,721.9852,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,740.708,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,742.2988,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,762.9005,names,times,types,blocks);
        end
        
        
    case '09dec08'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(10,1104.6792+40,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,788.7898+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1001.717+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1218.9624+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,164.6388+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '04dec08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(4,496.2675,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,496.2675,'odor applied','Low Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,656.1614,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,656.1614,'odor applied','Low Predator Urine_100F_2ul',names,times,types,blocks);
        end
        
    case '28nov08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(11,200.2267,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,222.0524,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,223.6421,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,263.9446,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,291.783,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,293.3759,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,313.3164,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,314.8745,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,336.7665,names,times,types,blocks);
        end
        
    case '26nov08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(3,642.4644,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,642.4644,'odor applied','High Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,799.1174,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,799.1174,'odor applied','Low Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,42.9292,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,42.9292,'odor applied','High Predator Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,361.0556,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,361.0556,'odor applied','Low Predator Urine_100F_2ul',names,times,types,blocks);
        end
        
        
        
    case '25nov08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(4,493.9358,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,515.9995,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,517.5614,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,557.2434,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,585.2583,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,586.8505,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,606.3427,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,607.9,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,629.2354,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,725.667+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,918.8385+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '21nov08'
        switch session
            case 1
                
                [names,times,types,blocks] = delete_event(9,1267.6989,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1189.3541+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,162.2359+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,339.8369+20,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,910.7327+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '13nov08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(6,1305.1736,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,1333.4856,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,1335.0743,names,times,types,blocks);
        end
        
        
    case '22may08'
        switch session
            case 3
                [names,times,types,blocks] = insert_event(14,910.3001-20,'odor applied','Ringers_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(15,459.2714+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(15,459.2714+20+1,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(15,459.2714+20+1+20,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(15,459.2714+20+1+20+1,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(15,459.2714+20+1+20+1+20,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '11sep08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(6,663.5357,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,663.5357,'odor applied','BC M1 Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,1150.4901,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1150.4901,'odor applied','HIGH BC M1 Male Urine_100F_2ul',names,times,types,blocks);
        end
        
        
    case '01sep08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(6,181.1409,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,203.7427,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,205.3315,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,244.7991,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,273.9874,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,275.5567,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,295.1768,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,296.6959,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,317.8423,names,times,types,blocks);
        end
        
    case '21aug08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(2,1325.6333,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1346.5144,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,1348.1039,names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(2,525.4237,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,525.4237,'odor applied','LOW CBA M3 Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,830.1062,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,830.1062,'odor applied','LOW BC M1 Male Urine_100F_2ul',names,times,types,blocks);
                
                
        end
        
        
        
    case '31jul08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(3,784.9072,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,784.9072,'odor applied','C57 M2 Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1092.5188,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,1092.5188,'odor applied','BC M2 Male Urine_100F_2ul',names,times,types,blocks);
                
        end
        
    case '10jun08'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(8,20+496.9291,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '08may08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(5,340.3471,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,340.3471,'odor applied','BC+CBA Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,500.1925,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,500.1925,'odor applied','B6+CBA Male Urine_100F_2ul',names,times,types,blocks);
                
        end
        
        
        
    case '02may08'
        switch session
            case 1
                [names,times,types,blocks] = delete_event(5,177.5974,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,177.5974,'odor applied','BC+CBA Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,334.3783,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,334.3783,'odor applied','B6+CBA Male Urine_100F_2ul',names,times,types,blocks);
                
        end
        
        
        
        
    case '30apr08'
        switch session
            case 1
                
                [names,times,types,blocks] = delete_event(8,195.6443,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,216.7725,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,218.3651,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,257.7669,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,284.9242,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,286.5166,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,305.7762,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,307.3695,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,328.6652,names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(2,643.3008,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,643.3008,'odor applied','BC+B6+CBA Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(2,798.4611,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,798.4611,'odor applied','BC+CBA Male Urine_100F_2ul',names,times,types,blocks);
                
                
                [names,times,types,blocks] = insert_event(7,20+500.4514,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,20+678.6104,'stop clean','stop clean',names,times,types,blocks);
                
        end
        
        
    case '18apr08'
        switch session
            case 1
                % DElete an entire stimulation block which was repeated
                [names,times,types,blocks] = delete_event(8,1258.2407,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1285.3916,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1286.98,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1329.2857,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1362.9972,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1364.5739,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1386.1144,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1387.6477,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,1409.6722,names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(8,20+1603.6806,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
    case '03apr08'
        switch session
            case 1
                [names,times,types,blocks] = insert_event(11,20+347.41,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '01apr08'
        switch session
            case 1
                % DElete an entire stimulation block which was repeated
                [names,times,types,blocks] = delete_event(3,1106.04,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1127.0701,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1128.663,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1167.5272,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1194.6275,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1196.2186,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1215.1156,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1216.7084,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,1237.4472,names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(7,508.2692,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,531.3171,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,532.9097,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,572.8742,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,602.5299,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,604.1114,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,623.7908,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,625.3838,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,646.7305,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,671.6407,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,695.0218,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,696.6096,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,736.7504,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,766.0815,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,767.6486,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,787.4407,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,789.0334,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,810.7088,names,times,types,blocks);
                
        end
        
        
    case '20mar08'
        switch session
            case 1
                % several stop clean events are missing
                [names,times,types,blocks] = insert_event(9,20+574.9877,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,20+755.2781,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,20+936.9433,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,20+1107.9411,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
        
    case '29feb08'
        switch session
            case 1
                % switched events, at day's end a balbc female can be mistaken for a B6 male ...
                %                 424  block: 9 time: 862.8868 BALBC Female Saliva_1F_2ul
                %                 433  block: 9 time: 1032.9226 CBA Male Saliva_1F_2ul
                [names,times,types,blocks] = delete_event(9,862.8868,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,862.8868,'odor applied','CBA Male Saliva_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,1032.9226,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,1032.9226,'odor applied','BALBC Female Saliva_1F_2ul',names,times,types,blocks);
        end
        
        
        
    case '28feb08'
        switch session
            case 1
                
                % Confused order of these two events
                %406  block: 8 time: 354.2361 B6 MALE Urine_100F_2ul
                %415  block: 8 time: 521.1713 B6 Female Urine_100F_2ul
                [names,times,types,blocks] = delete_event(8,354.2361,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,354.2361,'odor applied','B6 Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,521.1713,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,521.1713,'odor applied','B6 MALE Urine_100F_2ul',names,times,types,blocks);
                %712  block: 13 time: 180.5578 B6 Female Saliva_1F_2ul
                [names,times,types,blocks] = delete_event(13,180.5578,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,180.5578,'odor applied','BALBC Female Saliva_1F_2ul',names,times,types,blocks);
                
                % switched events, at day's end a balbc female can be mistaken for a B6 male ...
                % 739  block: 13 time: 660.3426 BALBC Female Saliva_1F_2ul
                % 748  block: 13 time: 896.0842 B6 MALE Saliva_1F_2ul
                [names,times,types,blocks] = delete_event(13,660.3426,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,660.3426,'odor applied','B6 MALE Saliva_1F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,896.0842,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,896.0842,'odor applied','B6 Female Saliva_1F_2ul',names,times,types,blocks);
                
                
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = insert_event(10,20+860.2994,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,20+1222.8953,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '15feb08'
        switch session
            case 2
                % I introduce a negative time for application because the
                % application occured in a tmp block prioir to stimulaiton
                [names,times,types,blocks] = insert_event(11,3.5944-20,'odor applied','B6 MALE Urine_100F_2ul',names,times,types,blocks);
        end
        
        
    case '05marb08'
        switch session
            case 1
                % Confused order of these two events
                %261  block: 7 time: 21.3867 B6 MALE Urine_100F_2ul
                %270  block: 7 time: 180.1678 BALBC Male Urine_100F_2ul
                [names,times,types,blocks] = delete_event(7,21.3867,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,21.3867,'odor applied','BALBC Male Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,180.1678,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,180.1678,'odor applied','B6 MALE Urine_100F_2ul',names,times,types,blocks);
        end
        
        
    case '19feb08'
        switch session
            case 1
                
                % Confused order of these two events
                %280  block: 6 time: 495.9176 BALBC Female Urine_100F_2ul
                %298  block: 6 time: 814.4101 FVB Female Urine_100F_2ul
                [names,times,types,blocks] = delete_event(6,495.9176,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,495.9176,'odor applied','FVB Female Urine_100F_2ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,814.4101,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,814.4101,'odor applied','BALBC Female Urine_100F_2ul',names,times,types,blocks);
                
                
                % A whole sequence that should be ignored
                %                 325  block: 7 time: 182.3245 FVB Female Urine_100F_2ul
                %                 326  block: 7 time: 204.8838 stimulation
                %                 327  block: 7 time: 206.4675 stimulation off
                %                 328  block: 7 time: 246.2919 start clean
                %                 329  block: 7 time: 275.1236 stimulation
                %                 330  block: 7 time: 276.7163 stimulation off
                %                 331  block: 7 time: 296.3523 stimulation
                %                 332  block: 7 time: 297.9438 stimulation off
                %                 333  block: 7 time: 319.1133 stop clean
                %                 [names,times,types,blocks] = delete_event(7,182.3245,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,204.8838,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,206.4675,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,246.2919,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,275.1236,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,276.7163,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,296.3523,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,297.9438,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(7,319.1133,names,times,types,blocks);
        end
        
        
        
    case '31jan08'
        switch session
            case 1
                
                % Confused order of these two events
                %586  block: 11 time: 374.8434 Male Saliva_1F_1ul
                %622  block: 11 time: 1124.161 Male SMG_1F_1ul
                [names,times,types,blocks] = delete_event(11,374.8434,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,374.8434,'odor applied','Male SMG_1F_1ul',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,1124.161,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1124.161,'odor applied','Male Saliva_1F_1ul',names,times,types,blocks);
                
                % A misplaced start clean and sitmulation event
                % A lot of fuckups in block 13, I think due to problems with data logging
                [names,times,types,blocks] = insert_event(13,223.707,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,420.8432,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,822.3856,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1026.3849,'stop clean','stop clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1438.6715,'stop clean','stop clean',names,times,types,blocks);
        end
        
        
        
    case '25jul07'
        switch session
            case 1
                % extra applications
                [names,times,types,blocks] = delete_event(3,255.3863,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,816.8726,names,times,types,blocks);
                
                % wrong report
                [names,times,types,blocks] = delete_event(3,491.3987,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,491.3987,'odor applied','Fox urine_300F_1ul',names,times,types,blocks);
                
                
        end
        
        
        
        
    case '23jul07'
        switch session
            case 1
                % extra applications
                [names,times,types,blocks] = delete_event(6,40.3491,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,493.519,names,times,types,blocks);
        end
        
        
    case '22jul07'
        switch session
            case 1
                % extra application
                [names,times,types,blocks] = delete_event(5,31.8557,names,times,types,blocks);
        end
        
        
    case '08mar07'
        switch session
            case 1
                
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(11,589.6441,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,589.6441,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,653.0223,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,653.0223,'stimulation','stimulation',names,times,types,blocks);
                
                
                
                etimes =  [ 741.4593  743.0147   772.6882  774.2697 ];
                for ji = 1:length(etimes)
                    [names,times,types,blocks] = delete_event(2,etimes(ji),names,times,types,blocks);
                end
                
        end
        
    case '05jan06' % it is really 07
        switch session
            case 1
                
                % extra cleaning
                etimes = [ 448.3007  450.2877  478.5311  480.5264 ];
                for ji = 1:length(etimes)
                    [names,times,types,blocks] = delete_event(2,etimes(ji),names,times,types,blocks);
                end
                
                % extra male urine report
                [names,times,types,blocks] = delete_event(2,535.8805,names,times,types,blocks);
                
                % Add a clean in the end
                [names,times,types,blocks] = insert_event(4,1045,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,1046,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,1047,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,1048,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,1049,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,1050,'stop clean','stop clean',names,times,types,blocks);
                
        end
        
        
        
    case '22nov06'
        switch session
            case 1
                % extra stim events
                [names,times,types,blocks] = delete_event(3,12.366,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,14.853,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,42.6346,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,45.1325,names,times,types,blocks);
                
                % an extrx start and stop clean event
                [names,times,types,blocks] = delete_event(4,1139.1696,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,1148.3107,names,times,types,blocks);
                
                % lots of ennecessary events in block 9
                etimes = [1164.3184 1166.7143 1195.7082 ,1198.1502 , 1273.8408 ,1348.3857 , 1350.8731 , 1379.8053 , 1382.2975 1461.0234  1503.452   1505.9341   1534.7804  1537.2685];
                for ji = 1:length(etimes)
                    [names,times,types,blocks] = delete_event(9,etimes(ji),names,times,types,blocks);
                end
                
                % correct bad naming format
                [names,times,types,blocks] = delete_event(4,599.8807,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,599.8807,'odor applied','PBS_1F_1ul',names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(5,222.006,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,222.006,'odor applied','PBS_1F_1ul',names,times,types,blocks);
                
                
                
                
                [names,times,types,blocks] = delete_event(6,577.246,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,577.246,'odor applied','PBS_1F_1ul',names,times,types,blocks);
                
                
                
                
        end
        
        
        
    case '21nov06'
        switch session
            case 1
                % ignore an extra application events
                [names,times,types,blocks] = delete_event(3,37.4112,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,39.8984,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,67.7591,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,70.2543,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,98.0431,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,100.5303,names,times,types,blocks);
                
                % replace a "start pulse clean event with a start clean event"
                [names,times,types,blocks] = delete_event(2,1125.6532,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,1125.6532,'start clean','start clean',names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(3,470.8702,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,473.3565,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,501.1652,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,503.6528,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,531.4314,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(3,533.9167,names,times,types,blocks);
                
                
                [names,times,types,blocks] = delete_event(5,587.025,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,589.5038,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,617.8293,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,620.3061,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,648.3476,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,650.7552,names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(6,499.7676,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,502.2473,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,530.3578,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,532.8424,names,times,types,blocks);
                
                % and now after allrecmoving all  these eextra stims we have to add some
                
                %                 222  block: 6 time: 1252.1366 stimulation
                % 223  block: 6 time: 1254.6227 stimulation off
                
                [names,times,types,blocks] = insert_event(6,1260,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1261,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1280,'stop clean','stop clean',names,times,types,blocks);
                
                
                % Add a clean in the end
                [names,times,types,blocks] = insert_event(6,1410,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1411,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1412,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1413,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1414,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1415,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1416,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(6,1417,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '30jul07'
        switch session
            case 1
                % ignore an extra application event
                [names,times,types,blocks] = delete_event(8,603.8023,names,times,types,blocks);
        end
        
        
    case '29jul07'
        switch session
            case 1
                
                % A stop clean must be added at the end of block 6
                [names,times,types,blocks] = insert_event(6,977,'stop clean','stop clean',names,times,types,blocks);
                
                
                % An extra clean which should be ignored
                % An extra application
                [names,times,types,blocks] = delete_event(7,163.6574,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,261.8496,names,times,types,blocks);
        end
        
    case '31aug07'
        switch session
            case 1
                % An extra application
                [names,times,types,blocks] = delete_event(3,273.6313,names,times,types,blocks);
                % and again ...
                [names,times,types,blocks] = delete_event(10,787.499,names,times,types,blocks);
                % an extra clean event
                [names,times,types,blocks] = delete_event(12,591.6869,names,times,types,blocks);
        end
        
    case '22jun07'
        switch session
            case 1
                % An extra start clean
                [names,times,types,blocks] = delete_event(6,817.2093,names,times,types,blocks);
        end
        
        
    case '21jun07'
        switch session
            case 1
                % Add a clean in the end
                [names,times,types,blocks] = insert_event(8,140,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,141,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,142,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,143,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,144,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,147,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '23aug07'
        switch session
            case 1
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(11,177.2261,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,177.2261,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,241.0994,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,241.0994,'stimulation','stimulation',names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(4,756.9232,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,756.9232,'odor applied','Volatile Mix_500uM_1ul',names,times,types,blocks);
        end
        
    case '26jul07'
        switch session
            case 1
                % A mistaken predator application and two followingf stims
                [names,times,types,blocks] = delete_event(4,545.9657,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,546.6996,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,548.2445,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,577.039,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,578.6255,names,times,types,blocks);
        end
        
    case '05jul07'
        switch session
            case 1
                % A mistaken extra Ringer's application report
                [names,times,types,blocks] = delete_event(15,555.2724,names,times,types,blocks);
                
                % need to replace female with male here
                [names,times,types,blocks] = delete_event(2,264.9739,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,264.9739,'odor applied','Male Urine_1e2F_1ul',names,times,types,blocks);
                
        end
        
    case '23mar07'
        switch session
            case 1
                % A frogotten case of cleaning off
                [names,times,types,blocks] = insert_event(6,inf,'stop clean','stop clean',names,times,types,blocks);
                % A mistaken start and end of cleaning
                [names,times,types,blocks] = delete_event(7,109.2883,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,110.8666,names,times,types,blocks);
                % Remove an event and add a new one instead - it seems like
                % two events were swapped in the Matlab reporting to TDT
                [names,times,types,blocks] = delete_event(7,342.1722,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,342.1722,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,405.0914,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(7,405.0914,'stimulation','stimulation',names,times,types,blocks);
        end
        
    case '22mar07'
        switch session
            case 1
                % An accidential odor delivery - that is when valve was
                % still optn
                [names,times,types,blocks] = delete_event(8,238.0205,names,times,types,blocks);
                % I did not clean in the last block - so I add fictious
                % cleaning events
                [names,times,types,blocks] = insert_event(10,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10005,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '14mar07'
        switch session
            case 1
                % I did not clean in this block, fake events entered
                [names,times,types,blocks] = insert_event(5,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,10004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,10005,'stop clean','stop clean',names,times,types,blocks);
                
                % a wongly placed quick clean episode, was not necessary
                [names,times,types,blocks] = delete_event(8,611.332,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(8,613.1323,names,times,types,blocks);
                
                
                % two events were swapped in the Matlab reporting to TDT
                [names,times,types,blocks] = delete_event(10,378.1239,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,378.1239,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,440.6709,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,440.6709,'stimulation','stimulation',names,times,types,blocks);
                
                
                % I did not clean in this block, fake events entered
                [names,times,types,blocks] = insert_event(11,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10005,'stop clean','stop clean',names,times,types,blocks);
                
        end
        
        
        
        
    case '02mar07'
        switch session
            case 1
                % an extra clean clean off pair
                [names,times,types,blocks] = delete_event(4,232.1698,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,293.4881,names,times,types,blocks);
                
                % did not clean in the last block now is not all clean
                [names,times,types,blocks] = insert_event(9,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,10004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,10005,'stop clean','stop clean',names,times,types,blocks);
                
                
        end
        
        
    case '29feb07'
        switch session
            case 1
                % Remove an event and add a new one instead - it seems like
                % two events were swapped in the Matlab reporting to TDT
                [names,times,types,blocks] = delete_event(10,766.6947,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,766.6947,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,829.9262,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,829.9262,'stimulation','stimulation',names,times,types,blocks);
                % events that the dilution was written incorrectly
                [names,times,types,blocks] = delete_event(2,501.4833,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,501.4833,'odor applied','Artificial Urine_1e2F_1ul',names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(4,760.9949,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,760.9949,'odor applied','Estrus Urine_1e2F_1ul',names,times,types,blocks);
                
        end
        
    case '11jan07'
        switch session
            case 1
                % Remove an event and add a new one instead - it seems like
                % two events were swapped in the Matlab reporting to TDT
                [names,times,types,blocks] = delete_event(7,193.3209,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(7,221.2272,names,times,types,blocks);
                % And two events need to bne swapped too - a stimulation
                % and a start clean event
                [names,times,types,blocks] = delete_event(11,721.7805,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,721.7805,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,785.9598,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,785.9598,'stimulation','stimulation',names,times,types,blocks);
                
                
                % I did not clean in the last block - so I add fictious
                % cleaning events
                [names,times,types,blocks] = insert_event(11,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,10005,'stop clean','stop clean',names,times,types,blocks);
                
        end
    case '16jan07'
        switch session
            case 1
                % a misplaced odor application event
                [names,times,types,blocks] = delete_event(5,39.9111,names,times,types,blocks);
                % Add a clean which was not performed here
                [names,times,types,blocks] = insert_event(10,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,10005,'stop clean','stop clean',names,times,types,blocks);
                % All these are associated with some very wild increease in
                % male urine 1/10000 which appears across all channels -
                % however - beware that this should not appear in the final
                % version since we nmay have remoived the artficats
                
                % I think removing only the base event should be enough
                [names,times,types,blocks] = delete_event(9,832.5055,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,873.9714,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,876.4606,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,904.5487,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,907.0359,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,,names,times,types,blocks);
                %                 [names,times,types,blocks] = delete_event(9,,names,times,types,blocks);
        end
    case '18jan07'
        switch session
            case 1
                % Add a clean which was not performed here (the stop clean does appear in the next block)
                [names,times,types,blocks] = insert_event(3,10000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,10001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,10002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,10003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(3,10004,'stimulation off','stimulation off',names,times,types,blocks);
                % This is bizzare, did I not clean here ?
                [names,times,types,blocks] = insert_event(4,620,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,621,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,622,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,623,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,624,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,625,'stop clean','stop clean',names,times,types,blocks);
                % This seems to be an unnecessary double clean
                [names,times,types,blocks] = delete_event(6,135.1783,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,136.7658,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,165.6513,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(6,167.24,names,times,types,blocks);
                % and here there is an excessive stimulaiton - why did I do that ?
                [names,times,types,blocks] = delete_event(9,423.5122,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,425.1005,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,454.3131,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(9,455.8388,names,times,types,blocks);
                % Again a misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(13,263.2389,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,263.2389,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,326.9143,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,326.9143,'stimulation','stimulation',names,times,types,blocks);
                % insert cleaning events
                [names,times,types,blocks] = insert_event(13,1000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,1005,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '16feb07'
        switch session
            case 1
                % Add a clean which was not performed here
                [names,times,types,blocks] = insert_event(8,1000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(8,1005,'stop clean','stop clean',names,times,types,blocks);
        end
        
    case '20feb07'
        switch session
            case 1
                % Again a misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(11,360.0535,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,360.0535,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,422.5838,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,422.5838,'stimulation','stimulation',names,times,types,blocks);
                
                % insert cleaning events
                [names,times,types,blocks] = insert_event(11,1000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,1005,'stop clean','stop clean',names,times,types,blocks);
                
                % Event was marked incorrecntly
                [names,times,types,blocks] = delete_event(9,535.9851,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,535.9851,'odor applied','predator urine_1e2F_1ul',names,times,types,blocks);
                
        end
        
    case '20mar07'
        switch session
            case 2
                % insert cleaning events
                [names,times,types,blocks] = insert_event(8,1000,'stop clean','stop clean',names,times,types,blocks);
                
                % This is a comment event
                [names,times,types,blocks] = delete_event(11,89.2426,names,times,types,blocks);
                
                % Event was marked incorrecntly
                [names,times,types,blocks] = delete_event(10,485.2688,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,485.2688,'odor applied','Artificial Urine_1e2F_1ul',names,times,types,blocks);
                
                % insert cleaning events
                [names,times,types,blocks] = insert_event(16,1000,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(16,1001,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(16,1002,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(16,1003,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(16,1004,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(16,1005,'stop clean','stop clean',names,times,types,blocks);
                
        end
        
    case '04apr07'
        switch session
            case 1
                % delete unnecessary stop clean event
                [names,times,types,blocks] = delete_event(9,53.7497,names,times,types,blocks);
                % elete quick clean event
                [names,times,types,blocks] = delete_event(9,836.521,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,307.5518,names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(10,640.2192,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,673.5742,names,times,types,blocks);
                
                [names,times,types,blocks] = delete_event(11,214.3055,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,218.1683,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,204.8688,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,446.6725,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,471.7364,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,813.4202,names,times,types,blocks);
                
                % Event was marked incorrecntly
                [names,times,types,blocks] = delete_event(5,33.947,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,33.947,'odor applied','Vol Female Urine_1F_vol',names,times,types,blocks);
        end
        
    case '06apr07'
        switch session
            case 1
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(10,1042.0002,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1042.0002,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1104.4876,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1104.4876,'stimulation','stimulation',names,times,types,blocks);
                
                % and again
                [names,times,types,blocks] = delete_event(11,587.0056,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,587.0056,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,650.1201,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,650.1201,'stimulation','stimulation',names,times,types,blocks);
                
                % and again
                [names,times,types,blocks] = delete_event(11,835.179,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,835.1796,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(11,898.2068,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(11,898.2068,'stimulation','stimulation',names,times,types,blocks);
                
        end
        
        
    case '10apr07'
        switch session
            case 1
                % INstead of a quick clean I made a start clean and stop
                % clean - these are unnecessary
                [names,times,types,blocks] = delete_event(4,329.3403,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(4,335.5692,names,times,types,blocks);
                
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(14,245.4524,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14,245.4524,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(14,310.083,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(14,310.083,'stimulation','stimulation',names,times,types,blocks);
                
        end
        
    case '11jun07'
        switch session
            case 2
                % Seems that I entirely forgot to clean after the Ringers
                % on Block 13
                [names,times,types,blocks] = insert_event(13,460,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,461,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,462,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,463,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,464,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,465,'stop clean','stop clean',names,times,types,blocks);
                % clean - these are unnecessary
                %[names,times,types,blocks] = delete_event(4,329.3403,names,times,types,blocks);
                %[names,times,types,blocks] = delete_event(4,335.5692,names,times,types,blocks);
                
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(13,844.3322,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,844.3322,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(13,908.4477,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(13,908.4477,'stimulation','stimulation',names,times,types,blocks);
                % Need to delete the occurence of some extra cleans I made
                [names,times,types,blocks] = delete_event(16,760.061,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(16,761.6541,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(16,791.9776,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(16,793.565,names,times,types,blocks);
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(17,463.0876,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(17,463.0876,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(17,529.3313,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(17,529.3313,'stimulation','stimulation',names,times,types,blocks);
                % A misplaced start clean and sitmulation event
                [names,times,types,blocks] = delete_event(20,890.8077,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(20,890.8077,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = delete_event(20,959.0012,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(20,959.0012,'stimulation','stimulation',names,times,types,blocks);
            case 1
                % did not enter the right concentration
                [names,times,types,blocks] = delete_event(5,36.4464,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(5,36.4464,'odor applied','N1 MIX_1e7F_1ul',names,times,types,blocks);
                % same thing here
                [names,times,types,blocks] = delete_event(9,266.5545,names,times,types,blocks);
                [names,times,types,blocks] = insert_event(9,266.5545,'odor applied','Ringers_1F_1ul',names,times,types,blocks);
        end
        
        
    case '17nov06'
        switch session
            case 1
                
                
                % The analysois of the KCL responses can not be accurate,
                % too many events had to be modified to conform to the
                % standard (that is, forgetting to clean)
                
                % ON that trial I only gave two stims, whereas I should have given 3
                [names,times,types,blocks] = insert_event(2,655,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(2,656,'stimulation off','stimulation off',names,times,types,blocks);
                
                % same problem, incosistency sucks
                [names,times,types,blocks] = insert_event(4,530,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,531,'stimulation off','stimulation off',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(4,650,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,651,'stimulation off','stimulation off',names,times,types,blocks);
                
                [names,times,types,blocks] = insert_event(4,800,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(4,801,'stimulation off','stimulation off',names,times,types,blocks);
                
                % Here I have some extra stims, amounting to 5 in this case
                % !!
                [names,times,types,blocks] = delete_event(5,1008.908,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,1011.392,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,1039.3994,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(5,1041.8897,names,times,types,blocks);
                
                
                
                % Add a clean in the end
                [names,times,types,blocks] = insert_event(10,1400,'start clean','start clean',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1401,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1402,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1403,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1404,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1405,'stimulation','stimulation',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1406,'stimulation off','stimulation off',names,times,types,blocks);
                [names,times,types,blocks] = insert_event(10,1407,'stop clean','stop clean',names,times,types,blocks);
                
                % And all these have to be deleted, what a mess really. ...
                
                
                [names,times,types,blocks] = delete_event(10,1303.6101,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1332.130,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1334.6189,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1363.0808,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1365.5802,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1394.0152,names,times,types,blocks);
                [names,times,types,blocks] = delete_event(10,1396.5001 ,names,times,types,blocks);
        end
        
        
        
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









