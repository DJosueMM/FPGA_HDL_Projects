`timescale 1ns / 1ps

module tb_module_registro_control_spi;

    // Definir parámetros
    parameter DATA_WIDTH = 32;

    // Definir señales de entrada y salida del módulo
    logic [DATA_WIDTH-1:0] data_1_i;
    logic [9 : 0]          n_rx_end_i;
    
    logic clk_i;
    logic rst_i;
    
    logic send_clear_i;
    logic wr_1_i;
    logic wr_2_i;
    
    logic [DATA_WIDTH-1:0] data_o;

    // Crear instancia del módulo a testear
    registro_control_spi registro_control_spi_inst (
        .data_1_i(data_1_i),
        .n_rx_end_i(n_rx_end_i),
        .clk_i(clk_i),
        .rst_i(rst_i),
        .send_clear_i(send_clear_i),
        .wr_1_i(wr_1_i),
        .wr_2_i(wr_2_i),
        .data_o(data_o)
    );

    initial   clk_i = 0;
    always #5 clk_i = ~clk_i;
  
    initial begin
    data_1_i     = 0;
    n_rx_end_i   = 0;
    rst_i        = 0;
    send_clear_i = 0;
    wr_1_i       = 0;
    wr_2_i       = 0;
    
    #1 
    rst_i = 0;
    #5 
    rst_i = 1;
    
    //
    #5
    data_1_i = 'd25;
    wr_1_i   = 1;
       
    #100
    wr_1_i = 0;
    
    #50
    wr_2_i = 1;
    
    #50
    wr_2_i = 0;
    
    #50
    send_clear_i = 1;
    
    #50
    n_rx_end_i = 'd31;
    
    #50
    n_rx_end_i = 'd0;
    
    #50
    wr_2_i = 1;
    n_rx_end_i = 'd63;
    
    #50
    wr_2_i = 0;
    n_rx_end_i = 'd0;
    
    #150
    wr_1_i = 1;
    n_rx_end_i = 'd127;
    
    #50
    wr_1_i = 0;
    n_rx_end_i = 'd0;
    
    end

endmodule
