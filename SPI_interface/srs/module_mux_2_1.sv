module module_mux_2_1 # (

    parameter DATA_WIDTH = 32 //Ancho de bits de los datos
  
)(

    //Entradas
    input logic mux_sel,                   //Bit de seleccion
    input logic [DATA_WIDTH - 1 : 0] control_i,    //Entrada a
    input logic [DATA_WIDTH - 1 : 0] datos_i,      //Entrada b
    
    //Salidas
    output logic [DATA_WIDTH - 1 : 0] salida_o //Salida del mux
    
);
    
    //Mux 2:1 
    assign salida_o =  mux_sel ? datos_i : control_i; 

endmodule
