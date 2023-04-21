//Modulo para disenar de manera estructural un sumador ripple carry (RCA)
//a partir de sumadores completos de 1 bit (fa).
module module_ripple_carry_adder #(
    parameter RCAWIDE = 64         //Ancho del bits del sumador RCA
)(

    input  logic [RCAWIDE - 1 : 0] a_i,     //Entrada a_i de ancho RCAWIDE bits
    input  logic [RCAWIDE - 1 : 0] b_i,     //Entrada b_i de ancho RCAWIDE bits
    input  logic                   carry_i, //Acarreo de entrada de la suma
    output logic [RCAWIDE - 1 : 0] sum_o,   //Resultado de la suma a_i + b_i
    output logic                   carry_o  //Acarreo de salida (overflow) de la suma a_i + b_i
    
);

    //Declaracion de senales internas
    logic [RCAWIDE - 1 : 0] c_in;          //Acarreos de entrada de las etapas itermedias
    logic [RCAWIDE - 1 : 0] c_out;         //Acarreos de salida de las etapas itermedias
    
    //Bloque para replicar la estructura del sumador completo de 1 bit
    generate 
    
        genvar j;                         //Variable auxiliar para iterar
        
        assign c_in[0] = carry_i;         //Se le asigna el acarreo de entrada a la primera etapa
        
        //Bloque for para replicar e interconectar los sumadores completos
        for (j = 0; j < (RCAWIDE - 1); j++) 
            begin
            
               //Se genera desde la primer etapa hasta la penultima, interconectando los acarreos
               module_bit_full_adder etapa_fa (.a_i(a_i[j]), .b_i(b_i[j]), .carry_i(c_in[j]), 
                                               .sum_o(sum_o[j]), .carry_o(c_in[j + 1]));             
       
            end
        
    endgenerate   
     
    //Se genera la etapa final, donde el acarreo de salida sera el overflow
    module_bit_full_adder etapa_final_fa (.a_i(a_i[RCAWIDE - 1]), .b_i(b_i[RCAWIDE - 1]), 
                                          .carry_i(c_in[RCAWIDE - 1]), .sum_o(sum_o[RCAWIDE - 1]),
                                          .carry_o(carry_o));  
                                   
endmodule 