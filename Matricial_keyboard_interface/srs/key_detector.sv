
module key_detector(
 
    input logic [3 : 0] key_pressed,

    output logic data_available_o

);

    always_comb
        case(key_pressed)
        
            0: data_available_o  = 1;
         
            1: data_available_o  = 1;
  
            2: data_available_o  = 1;
       
            3: data_available_o  = 1;
    
            4: data_available_o  = 1;
            
            5: data_available_o  = 1;
         
            6: data_available_o  = 1;
  
            7: data_available_o  = 1;
       
            8: data_available_o  = 1;
    
            9: data_available_o  = 1;
         
            10: data_available_o = 1;
  
            11: data_available_o = 1;
       
            12: data_available_o = 1;
    
            13: data_available_o = 1;
            
            14: data_available_o = 1;
         
            15: data_available_o = 0;
            
            default: data_available_o = 0;
  
        endcase


endmodule
