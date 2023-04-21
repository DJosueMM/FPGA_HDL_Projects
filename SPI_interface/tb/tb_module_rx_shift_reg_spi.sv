`timescale 1ns / 1ps

module tb_module_rx_shift_reg_spi;
    
    // Se�ales de entrada
    logic clk_i; 
    logic rst_i;
    logic shift_en_i;
    logic data_i;

    // Se�ales de salida
    logic [7 : 0] data_o;

    // Instancia el m�dulo
    module_rx_shift_reg_spi DUT (
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .shift_en_i (shift_en_i),
        .data_i     (data_i),
        .data_o     (data_o)
    );

    initial   clk_i = 0;
    always #5 clk_i = ~clk_i;
  
    initial begin
    rst_i       = 0;
    shift_en_i  = 0;
    data_i      = 0;
    
    #20 
    rst_i       = 1;
    
    #13
    data_i      = 'b1;
    
    #2
    shift_en_i  = 1;
    
    #2
    data_i      = 'b0;
    
    end


endmodule
