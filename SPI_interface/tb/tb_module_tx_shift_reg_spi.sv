`timescale 1ns / 1ps

module tb_module_tx_shift_reg_spi;

    // Señales de entrada
    logic clk_i;
    logic rst_i;
    logic load_en_i;
    logic shift_en_i;
    
    logic [7 : 0] data_in_i;
    
    // Señales de salida
    logic data_out_o;

    // Instancia del módulo
    module_tx_shift_reg_spi DUT(
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .load_en_i  (load_en_i),
        .shift_en_i (shift_en_i),
        .data_i     (data_in_i),
        .data_o     (data_out_o)
    );

    initial   clk_i = 0;
    always #5 clk_i = ~clk_i;
  
    initial begin
    rst_i       = 0;
    load_en_i   = 0;
    shift_en_i  = 0;
    data_in_i   = 0;
    
    #20 
    rst_i       = 1;
    
    #9
    data_in_i   = 8'b10101010;
    
    #5
    load_en_i   = 1;
    
    #10
    load_en_i   = 0;
    
    #5
    shift_en_i  = 1;
    


    end

endmodule
