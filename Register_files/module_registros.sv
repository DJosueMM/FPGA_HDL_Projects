//Modulo para generar un banco de registros parametrizable con 2^N registros de W bits
module module_registros 

# (
    //Parametros
    parameter N = 2,
    parameter DATA_WIDTH = 4
    
)(
    //Entradas
    input logic we_i,                   //write enable
    input logic clk_i,                  //reloj 10 MHz
    //input logic rst_i,                  //reset

    input logic [N - 1 : 0] addr_rs1_i , //puntero de lectura 1
    input logic [N - 1 : 0] addr_rs2_i , //puntero de lectura 2
    input logic [N - 1 : 0] addr_rd_i  , //puntero de escritura
    
    input logic [DATA_WIDTH - 1 : 0] data_i  , //bus de datos

    //Salidas
    output logic [DATA_WIDTH - 1 : 0] rs1_o ,    //salida de lectura 1
    output logic [DATA_WIDTH - 1 : 0] rs2_o      //salida de lectura 2

);

    //Banco de ff
    typedef logic [DATA_WIDTH - 1 : 0] registro; //tipo registro de DATA_WIDTH bits
    registro      [2**N - 1 : 0]       banco_registros_r;   //2^N registros de DATA_WIDTH bits
    
    //$zero con DATA_WIDTH ceros
    assign banco_registros_r [0] = '0;
    
    always_ff@(posedge clk_i)
        
        //Escritura en registro excluyendo el registro $zero
        if (we_i & (addr_rd_i != '0)) begin 
        
            banco_registros_r [addr_rd_i] <= data_i; //data_in se almacena en el registro addr_rd
        
        end
        
    //Lectura de registros   
    assign rs1_o = banco_registros_r [addr_rs1_i]; //el dato del registro addr_rs1 se muestra en rs1 
    assign rs2_o = banco_registros_r [addr_rs2_i]; //el dato del registro addr_rs2 se muestra en rs2 
       
endmodule
