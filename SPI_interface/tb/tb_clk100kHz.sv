`timescale 1ns / 1ps

module tb_clk100kHz;

    logic clk_pi;
    logic clk_100kHz;
    logic pos_edge;
    logic neg_edge;
    logic en;

    logic clk_10MHz;
    logic rst;

    
    logic clk_100kHz;

    clk_wiz_0 dut ( 
        .clk_out1   (clk_10MHz),           
        .locked     (rst),
        .clk_in1    (clk_pi)
    );
    
    reloj_divisor DUT (
        .clk_10MHz(clk_10MHz),
        .rst_i(rst),
        .en_sclk_i (en),
        .clk_100kHz(clk_100kHz),
        .pos_edge(pos_edge),
        .neg_edge(neg_edge)
    );

    initial clk_pi = 1;

    always begin
        #5; 
        clk_pi = ~clk_pi;
    end
    
    initial begin
    
        en = 0;
        
        #10_000;
        
        en = 1;
        
        #199_000;
        
        en = 0;
        
        #10_000;
        
        en = 1;
            
    end

endmodule
