`timescale 1ns / 1ps

module tb_top_module_spi;

    //Estimulos de entrada
    logic clk_pi;
    logic wr_pi;
    logic reg_sel_pi; 
     
    logic [12 : 0] entrada_pi;  
    logic [1  : 0] addr_pi;     

    //Estimulos de salida
    logic [15 : 0]   leds_po;     
    logic            mosi_po;
    logic            sclk_po;
    logic            ss_po;

    //Instancia del modulo top de la interfaz SPI
    top_module_spi DUT (
    .clk_pi     (clk_pi),
    .wr_pi      (wr_pi),
    .reg_sel_pi (reg_sel_pi), 
    .entrada_pi (entrada_pi),
    .addr_pi    (addr_pi),
    .leds_po    (leds_po),
    .miso_pi    (mosi_po),  //Se conecta el MISO con el MOSI   
    .mosi_po    (mosi_po),   
    .sclk_po    (sclk_po),
    .ss_po      (ss_po)
    );

    //Se genera un estimulo de clk a 100MHz
    initial clk_pi = 0;
    always #5 clk_pi = ~clk_pi;

    initial begin
    
        //Pasa el Locked del PLL
        #10000;
        
        //Inicializacion
        wr_pi = 0;
        reg_sel_pi = 0;
        entrada_pi = '0;
        addr_pi = 2'b00;

        //Ingreso primer dato
        #10000;
        
        wr_pi = 0;
        reg_sel_pi = 1;
        entrada_pi = 12'b000010100100;
        addr_pi = 2'b00;
        
        //Cargo dato
        #110;
        wr_pi = 1;
        #110;
        wr_pi = 0;
        
        #110;
        
        wr_pi = 0;
        reg_sel_pi = 1;
        entrada_pi = 12'b000010100100;
        addr_pi = 2'b11;

        //Cargo dato
        #110;
        wr_pi = 1;
        #110;
        wr_pi = 0;

        //Ingreso primer transaccion
        #200;
        wr_pi = 0;
        reg_sel_pi = 0;
        entrada_pi = 12'b000000000011; //Una transaccion dato de registro
        addr_pi = 2'b00;
        
        //Cargo dato
        #200;
        wr_pi = 1;
        #100;
        wr_pi = 0;

        #135_000;
        
        //Verifico primer transaccion
        assert (leds_po[0] == 1'b0)
        else $error("%m no se actualiza send en registro de control");
        
        assert (leds_po[15 : 13] == 3'b001)
        else $error("%m no se muestra la cantidad de transacciones realizadas");
        
        assert (ss_po  == 1'b1)
        else $error("%m no se deshabilita el esclavo al terminar");
        
        assert (sclk_po == 1'b0)
        else $error("%m no se tiene la polaridad del sclk en reposo de 0");
        
        #100;
        reg_sel_pi = 1;
        
        #100;
        assert (leds_po[7 : 0] == 8'b10100100)
        else $error("%m no se recibio el dato esperado");
        
        
         //Ingreso segunda transaccion
        #200;
        wr_pi = 0;
        reg_sel_pi = 0;
        entrada_pi = 12'b000000101011; //tres transacciones todo en 0
        addr_pi = 2'b00;
        
        #200;
        //Cargo dato
        wr_pi = 1;
        
        #100;
        wr_pi = 0;
        
        #400_000;
        
        //Verifico segunda transaccion
        assert (leds_po[0] == 1'b0)
        else $error("%m no se actualiza send en registro de control");
        
        assert (leds_po[15 : 13] == 3'b011)
        else $error("%m no se muestra la cantidad de transacciones realizadas");
        
        assert (ss_po  == 1'b1)
        else $error("%m no se deshabilita el esclavo al terminar");
        
        assert (sclk_po == 1'b0)
        else $error("%m no se tiene la polaridad del sclk en reposo de 0");
        
        #100;
        reg_sel_pi = 1;
        
        #100;
        assert (leds_po[7 : 0] == 8'b00000000)
        else $error("%m no se recibio el dato esperado en la primer transaccion");
        
        #100;
        addr_pi = 2'b01;
        
        #100;
        assert (leds_po[7 : 0] == 8'b00000000)
        else $error("%m no se recibio el dato esperado en la segunda transaccion");
        
        #100;
        addr_pi = 2'b10;
        
        #100;
        assert (leds_po[7 : 0] == 8'b00000000)
        else $error("%m no se recibio el dato esperado en la tercer transaccion");
        
        #100;
        addr_pi = 2'b11;
        
        #100;
        assert (leds_po[7 : 0] == 8'b10100100)
        else $error("%m se cambio un registro que no debia participar en una transaccion");
        
        $finish;
    end
endmodule