//Modulo para disenar un sumador carry look ahead adder (CLA)
 
module module_carry_look_ahead_adder #(

    parameter CLA_WIDTH = 32   //Ancho de bits del sumador CLA
    
)(

    input logic  [CLA_WIDTH - 1 : 0] a_i,     //Entrada a_i de ancho CLA_WIDTH bits
    input logic  [CLA_WIDTH - 1 : 0] b_i,     //Entrada b_i de ancho CLA_WIDTH bits
    input logic                      carry_i, //Acarreo de entrada de la suma
    output logic                     carry_o, //Acarreo de salida (overflow) de la suma a_i + b_i
    output logic [CLA_WIDTH - 1 : 0] sum_o    //Resultado de la suma a_i + b_i 
   
);

    
    integer int_j;

    //Declaracion de senales internas    
    logic [CLA_WIDTH - 1 : 0] f_p;
    logic [CLA_WIDTH - 1 : 0] f_g;
    logic [CLA_WIDTH - 1 : 0] c;
    logic [CLA_WIDTH - 1 : 0] s;
  
    always @(a_i, b_i, carry_i) 
        begin
            for (int_j = 0; int_j < CLA_WIDTH; int_j = (int_j + 1))
                begin
      
                    c[0] = carry_i; //Carry de entrada
                
                    f_p[int_j] = a_i[int_j] ^ b_i[int_j]; // Funcion Carry Generate
                    f_g[int_j] = a_i[int_j] & b_i[int_j]; // Funcion Carry Propagate
                
                    s[int_j]   = f_p[int_j] ^ c[int_j];                //Resultado de la suma de cada a_i[j] + b_i[j]
                    c[int_j+1] = f_g[int_j] | (f_p[int_j] & c[int_j]); //Carry de salida de cada a_i[j] + b_i[j]
                
                end
        end
  
    assign sum_o   = s;                 //Suma total de salida
    assign carry_o = c[CLA_WIDTH - 1];  //Carry de salida (overflow)

endmodule
