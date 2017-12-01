function [probe_info]=get_probe_info(probeID)
%%This function maps provides information about neuronexus probes used for
%%recordings. 

%%double check each of these site mappings!
% probeID*2
switch probeID
    case '904'
        probe_info.type='a4 by 8 5mm 100:200:177';  %%orderID 9368
        site_mapping='4x8';
              probe_info.z_spacing=100;
        probe_info.hor_sep=200;

       case '909'
        probe_info.type='a4 by 8 5mm 100:200:177';  %%orderID 9368
        site_mapping='4x8';
              probe_info.z_spacing=100;
        probe_info.hor_sep=200;
        
 
    
    case '915'
        probe_info.type='a4 by 8 5mm 100:200:177';  %%orderID 9368
        site_mapping='4x8';
              probe_info.z_spacing=100;
        probe_info.hor_sep=200;
 

    case '917'
        probe_info.type='a4 by 8 5mm 100:200:177?????';  %%orderID CHECK THIS To Make sure it is correct
        site_mapping='4x8';
              probe_info.z_spacing=100;
        probe_info.hor_sep=200;
 

    case '947'
        probe_info.type='a4 by 8 5mm 100:200:177';  %%orderID #8643
        site_mapping='4x8';
              probe_info.z_spacing=100;
        probe_info.hor_sep=200;
 

    case '951'
        probe_info.type='a4 by 8 5mm 100:200:177';  %%orderID #8643
        site_mapping='4x8';
              probe_info.z_spacing=100;
        probe_info.hor_sep=200;
 

    case '952'
        probe_info.type='a4 by 8 5mm 100:200:177';  %%orderID #8643
       probe_info.z_spacing=100;
        probe_info.hor_sep=200;
        site_mapping='4x8';

        
        
        
        
  case '495'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
        
   case '584'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
    case '587'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
       
      
  case 'CB4'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
        
   case '11A3'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
       
        
     case '115D'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
       
      
        
        
        
    case '1086'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
     case '1089'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;

    case '1486'
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #9548
        site_mapping='2x16';
               probe_info.z_spacing=100;
        probe_info.hor_sep=500;


    case '1773'
        probe_info.type='a 2 by 16 10mm 100:500:177';%%orderID #9548
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        

    case '1807'
        probe_info.type='a 1 by 32 6mm 50:95';%%Free trial
        site_mapping='1x32';
        probe_info.z_spacing=50;
        probe_info.hor_sep=0;
        
     case '2528'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
     case '2529'  %%%
        probe_info.type='a 2 by 16 10mm 100:500:413';%%orderID #?
        site_mapping='2x16';
        probe_info.z_spacing=100;
        probe_info.hor_sep=500;
        
    case '3BDC'
        probe_info.type='a 1 by 32 6mm 50:95';%%Free trial
        site_mapping='1x32';
        probe_info.z_spacing=50;
        probe_info.hor_sep=0;
 
    case '3BDB'
        probe_info.type='a 1 by 32 6mm 50:95';%%Free trial
        site_mapping='1x32';
        probe_info.z_spacing=50;
        probe_info.hor_sep=0;
        
        
    case '4896'
        probe_info.type='a 1 by 32 6mm 50:95';%%Free trial
        site_mapping='1x32';
        probe_info.z_spacing=50;
        probe_info.hor_sep=0;
        
    otherwise
        probe_info.type='default: probe not found';%%Free trial
        site_mapping='2x16';
              probe_info.z_spacing=100;
        probe_info.hor_sep=500;
 
end


switch site_mapping %%set the groupings
    case '4x8'
        probe_info.groups=[1:4:32; 2:4:32; 3:4:32; 4:4:32];
        probe_info.shanks=4;
        
    case '2x16'
        temp_grp=[1,2,5,6,9,10,13,14];
        probe_info.groups=[temp_grp;temp_grp+16;temp_grp+2;temp_grp+18];
        probe_info.shanks=2;

    case '1x32'
        probe_info.groups=[1:8; 9:16; 17:24; 25:32];
        probe_info.shanks=1;
    otherwise
        probe_info.groups=[1:4:32; 2:4:32; 3:4:32; 4:4:32];  %%as good of a default as any...
        probe_info.shanks=2;

end


probe_info.do_groups=[1:size( probe_info.groups,1)];



    
return