`timescale 1ns / 1ps

module tb_module_top_luces;


   //entradas
   logic p1_pi;
   logic p2_pi;
   logic clk_pi;
    
   //salidas 
   logic [2 : 0] b_po;
   
   
   module_top_luces DUT(
    
        //entradas
        .p1_pi(p1_pi),
        .p2_pi(p2_pi),
        .clk_pi(clk_pi),
    
        //salidas 
        .b_po(b_po)
    );
    
    // Generamos un reloj de 100 MHz
    initial     clk_pi = 1;
    always #5 clk_pi = ~clk_pi;
    
    initial begin

        p1_pi = 0;
        p2_pi = 0;
        
        #128000
    
        p1_pi = 1;
        p2_pi = 0;
        
        #110
        
        p1_pi = 0;
        p2_pi = 0;
        
         #128000
        
        p1_pi = 0;
        p2_pi = 1;
        
        
        #110
        
        p1_pi = 0;
        p2_pi = 0;
        
        
        #128000
        
        p1_pi = 0;
        p2_pi = 1;
        
        
        #110
        
        p1_pi = 0;
        p2_pi = 0;
        
        #128000
        
        p1_pi = 0;
        p2_pi = 1;
        
        #110
        
        p1_pi = 0;
        p2_pi = 0;
       
    end    
 
endmodule
