`timescale 1ns / 1ps

module reloj_divisor(

    input logic clk_10MHz,
    input logic rst_i,  // Reloj de entrada de 10 MHz
    input logic en_sclk_i,      
    
    output logic clk_100kHz,  // Salida del reloj de 100 kHz
    output logic pos_edge,  // Salida del reloj de 100 kHz en flanco positivo
    output logic neg_edge
    
  );
  
    localparam CUENTA = 50;
    
    logic [$clog2(CUENTA) - 1 : 0] counter;
         
    always_ff @ (posedge clk_10MHz) begin
    
        if (!rst_i || !en_sclk_i) begin
        
            counter <= 0;
            clk_100kHz <= 0;
        end
        
        else begin

            if (counter == CUENTA - 1 && en_sclk_i) begin
                clk_100kHz <= ~clk_100kHz;
                counter <= 0;
            end
            
            if (en_sclk_i) 
                counter <= counter + 1;
                
            else counter <= counter;       
        end
    end

    always_ff @(posedge clk_10MHz) begin
    
      if (~rst_i) begin
          pos_edge <= 0;
          neg_edge <= 0;
      end
      
      else begin
        if ((counter == CUENTA - 1) && (clk_100kHz == 0)) begin
            pos_edge <= 1;
            
        end else begin
            pos_edge <= 0;
        end
        
        if ((counter == CUENTA - 1) && (clk_100kHz == 1)) begin
            neg_edge <= 1; 
            
        end else begin
        
            neg_edge <= 0;
        end
      end
  end

  endmodule

