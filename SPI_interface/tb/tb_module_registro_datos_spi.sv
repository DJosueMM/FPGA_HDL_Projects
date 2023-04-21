`timescale 1ns / 1ps

module tb_module_registro_datos_spi;

    // Parámetros
    localparam N = 2;
    localparam DATA_WIDTH = 32;

    // Señales del testbench
    logic clk_i;
    logic rst_i;
    logic wr1_i;
    logic wr2_i;
    logic hold_ctrl_i;
    logic [N-1:0] addr1_i;
    logic [N-1:0] addr2_i;
    logic [DATA_WIDTH-1:0] data_in1_i;
    logic [DATA_WIDTH-1:0] data_in2_i;
    logic [DATA_WIDTH-1:0] data1_o;
    logic [DATA_WIDTH-1:0] data2_o;

    // Instancia del módulo
    module_registro_datos_spi DUT (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .wr1_i(wr1_i),
        .wr2_i(wr2_i),
        .hold_ctrl_i(hold_ctrl_i),
        .addr_1_i(addr1_i),
        .addr_2_i(addr2_i),
        .data_in1_i(data_in1_i),
        .data_in2_i(data_in2_i),
        .data1_o(data1_o),
        .data2_o(data2_o)
    );

    initial   clk_i = 0;
    always #5 clk_i = ~clk_i;
  
    initial begin
    rst_i       = 0;
    wr1_i       = 0;
    wr2_i       = 0;
    hold_ctrl_i = 0;
    addr1_i     = 'b00;
    addr2_i     = 'b00;
    data_in1_i  = 'h00;
    data_in2_i  = 'h00;
    



    #5 
    rst_i = 1;
    
    //
    #5
    data_in1_i = 'h25;
    wr1_i      = 1;
    
    #100
    data_in1_i = 'h00;
    wr1_i      = 0;
    
    #100
    wr2_i      = 1;
    data_in2_i = 'h12;
    addr2_i    = 'b01;
    
    #100
    wr2_i      = 0;
    data_in2_i = 'h00;
    addr2_i    = 'b00;
    addr1_i    = 'b01;
    
    #100
    addr1_i     = 'b00;
    hold_ctrl_i = 1;
    wr1_i       = 1;
    data_in1_i  = 'h1234;
    
    #100
    hold_ctrl_i = 0;
    wr1_i       = 1;
    data_in1_i  = 'h1234;
    
    #100
    addr2_i     = 'b10;
    wr1_i       = 0;
    hold_ctrl_i = 1;
    wr2_i       = 1;
    data_in2_i  = 'h5678;
    
    #100
    hold_ctrl_i = 0;
    wr2_i       = 1;
    data_in2_i  = 'h5678;
   
    #100
    wr2_i      = 0;
    end

endmodule
