//módulo para modelar la máquina de estados de Mealy para el control de las luces 
module module_top_luces(

    //entradas
    input logic p1_pi,
    input logic p2_pi,
    input logic clk_pi,

    //salidas 
    output logic [2 : 0] b_po
);

    logic clk_10Mhz;
    logic reset;
    logic p1;
    logic p2;
    logic en;
    logic fin;
  
 
    clk_10MHz clk_global(
      // Clock out ports
      .clk_out1(clk_10Mhz),
      // Status and control signals
      .locked (reset),
     // Clock in ports
      .clk_in1(clk_pi)
     );

    module_fsm_bombillos FSM(

        //entradas
        .clk_i (clk_10Mhz),
        .rst_i (reset),
        .p1_i  (p1),
        .p2_i  (p2),
        .fin_i (fin),
   
        //salidas 
        .en_o (en),
        .b_o(b_po)
    );
    
    module_nivel_pulso uno(

        //entradas
        .clk_i (clk_10Mhz),
        .rst_i (reset),
        .p_i   (p1_pi),
    
        //salidas 
        .pulso_o (p1)
     );
     
     module_nivel_pulso dos(

        //entradas
        .clk_i (clk_10Mhz),
        .rst_i (reset),
        .p_i   (p2_pi),
    
        //salidas 
        .pulso_o (p2)
     );
     
     module_temporizador timer(

        .clk_i (clk_10Mhz),
        .rst_i (reset),
        .en_i  (en),
        
        .fin_o (fin)
     );

endmodule