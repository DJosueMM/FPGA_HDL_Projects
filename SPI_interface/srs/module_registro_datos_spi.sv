module module_registro_datos_spi

#(
    //Parametros
    parameter N = 2,
    parameter DATA_WIDTH = 32 
    
)(
    //Entradas
    input logic clk_i,                 //reloj 10 MHz
    input logic rst_i,                 //reset activo en bajo
    input logic wr1_i,                 //write enable 1
    input logic wr2_i,                 //write enable 2
    input logic hold_ctrl_i,           //senal de hold control
    
    input logic [N - 1 : 0] addr_1_i , //puntero 1
    input logic [N - 1 : 0] addr_2_i , //puntero 2

    input logic [DATA_WIDTH - 1 : 0] data_in1_i, //Datos de entrada 1 (cliente)
    input logic [DATA_WIDTH - 1 : 0] data_in2_i, //Datos de entrada 2 (SPI)

    //Salidas
    output logic [DATA_WIDTH - 1 : 0] data1_o, //Datos de salida 1 al cliente 
    output logic [DATA_WIDTH - 1 : 0] data2_o  //Datos de salida 2 a la interfaz
);

    //Banco de ff
    typedef logic [DATA_WIDTH - 1 : 0] registro;           //tipo registro de DATA_WIDTH bits
    registro      [2**N - 1 : 0]       banco_registros_r;  //2^N registros de DATA_WIDTH bits
    
    always_ff@(posedge clk_i) //Escritura en registros
        
        if (!rst_i) begin //reset
        
            banco_registros_r <= '0;
        end
        
        else if (wr1_i && hold_ctrl_i == 0) begin  //escritura en el puntero del cliente
      
            banco_registros_r [addr_1_i] <= data_in1_i; 
        
        end
        
        else if (wr2_i) begin //escritura en el puntero de la interfaz
      
            banco_registros_r [addr_2_i] <= data_in2_i; 
        
        end
        
        else  banco_registros_r <= banco_registros_r; //Se mantiene el dato
        
    //Lectura de registros   
    assign data1_o  = banco_registros_r [addr_1_i]; //Se lee el puntero del cliente
    assign data2_o  = banco_registros_r [addr_2_i]; //Se lee el puntero de la interfaz
       
endmodule
