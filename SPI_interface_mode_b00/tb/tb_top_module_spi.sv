`timescale 1ns / 1ps

module tb_top_module_spi;

    logic            clk_pi;

    logic            wr_pi;
    logic            reg_sel_pi;  //sw
    logic  [12 : 0]  entrada_pi;  //sw
    logic  [1  : 0]  addr_pi;     //sw

    logic [15 : 0]   leds_po;     //Salida de datos
    
    //logic            miso_pi;     //Puerto serial 
    logic            mosi_po;
    logic            sclk_po;
    logic            ss_po;


    top_module_spi DUT (
    .clk_pi     (clk_pi),
    .wr_pi      (wr_pi),
    .reg_sel_pi (reg_sel_pi), 
    .entrada_pi (entrada_pi),
    .addr_pi    (addr_pi),
    .leds_po    (leds_po),
    .miso_pi    (mosi_po),     
    .mosi_po    (mosi_po),   
    .sclk_po    (sclk_po),
    .ss_po      (ss_po)
    );

    initial   clk_pi = 0;
    always #5 clk_pi = ~clk_pi;

    initial begin
    
        //Pasa el Locked PLL
        #10000
        
        //Inicializacion
        wr_pi       = 0;
        reg_sel_pi  = 0;
        entrada_pi  = '0;
        addr_pi     = 2'b00;

        //Ingreso dato
        #10000
        wr_pi       = 0;
        reg_sel_pi  = 1;
        entrada_pi  = 12'b000010100100;
        addr_pi     = 2'b00;

        //Cargo dato
        #200
        wr_pi       = 1;
        
        #100
        wr_pi       = 0;

        
        //Ingreso una transaccion
        #200
        wr_pi       = 0;
        reg_sel_pi  = 0;
        entrada_pi  = 12'b000000010111;
        addr_pi     = 2'b00;
        
        
        //Cargo dato
        #200
        wr_pi       = 1;
        
        #100
        wr_pi       = 0;
        reg_sel_pi  = 1;
        
        //Ingreso una transaccion
        #200
        wr_pi       = 0;
        reg_sel_pi  = 0;
        entrada_pi  = 12'b000000011011;
        addr_pi     = 2'b00;
        
        
        //Cargo dato
        #300_000
        wr_pi       = 1;
        
        #100
        wr_pi       = 0;
        reg_sel_pi  = 1;
        
    end


endmodule