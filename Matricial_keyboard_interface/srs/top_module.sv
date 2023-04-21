//Top module para la interfaz del teclado
module top_module_interfaz(

    input logic         clk_pi,             //clk 100MHz de la FPGA
    input logic [3 : 0] key_pressed_pi,     //tecla presionada activa en bajo
    input logic [1 : 0] row_pi,             //salida del codificador de la proto
    
    output logic [1 : 0] col_o,             //entrada del contador a la proto (reemplaza dipswitch)
    output logic         data_available_po, //bandera de dato disponible
    output logic [7 : 0] an,                //anodos para el 7 segmentos
    output logic [6 : 0] seg                //salida para 7 segmentos

);

    //Señales internas
    
    logic reset;         //reset        
    logic clk_10MHz;     //clk 10 MHz
    logic refresh;       
    logic [3:0] key;     
    logic [3:0] key_deb;
   
    //PLL
    clk_10MHz  (
      // Clock out ports
      .clk_out1 (clk_10MHz),
      // Status and control signals
      .locked (reset),
     // Clock in ports
      .clk_in1 (clk_pi)
      
    );
 
    //Divisor de clk
    module_divisor delay (
        .clk(clk_10MHz),
        .rst_i(reset),
        .en (refresh)
    );
    
    //Contador de 2 bits
    module_contador_2bits timer (

    .clk(clk_10MHz), 
    .rst_n_i (reset), 
    .refresh_i (refresh),
    .en_i (data_available_po), 
    .conta_o (col_o)
    );

    //Debouncer
    module_debouncer_syncr debouncer
    (
    .clk (clk_10MHz),                // Clock de entrada
    .reset(reset),                   // Reset 
    .in (key_pressed_pi),  // Entrada del debouncer 
    .out (key_deb)         // salida del debouncer
    
    );
    
    //Detector de tecla
    key_detector dec (
        .key_pressed(key_deb),
        .data_available_o(data_available_po)
    );

    //Flip flops de salida
    module_key_encoding ffs_salida(
    
        //Entradas
        .clk_i (clk_10MHz),
        .rst_i (reset),
        .en (data_available_po),
        
        
        .key_fila_i (row_pi),
        .key_colum_i(col_o),
        
        //Salidas
        .key_value_o (key)
    
    );
    
    //Display de 7 segmentos y codificacion
    Display dis (
        .data(key),
        .seg(seg),
        .anode(an)
    );

endmodule
