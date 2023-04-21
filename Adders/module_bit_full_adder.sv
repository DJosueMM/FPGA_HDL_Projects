//Modulo para disenar de manera estructural un sumador completo de 1 bit.
module module_bit_full_adder 
(
    input logic  a_i,     //Entrada del primer numero de 1 bit.
    input logic  b_i,     //Entrada del segundo numero de 1 bit.
    input logic  carry_i, //Entrada para el acarreo de entrada c_i
    output logic sum_o,   //Salida del resultado de la suma de a_i + b_i.
    output logic carry_o  //Salida del acarreo resultante de la suma a_i + b_i.
);

    //Declaracion de senales internas
    logic c_1; //Entrada 1 a la or que genera carry_o
    logic c_2; //Entrada 2 a la or que genera carry_o
    logic c_3; //Entrada 3 a la or que genera carry_o
    
    //modelado estructural del sumador
    and and1 (c_1, a_i, b_i);       // c1 = a_i & b_i
    and and2 (c_2, b_i, carry_i);   // c2 = b_i & carry_i
    and and3 (c_3, a_i, carry_i);   // c3 = a_i & carry_i
    
    or  or1  (carry_o, c_1, c_2, c_3);   // carry_o = c_1 + c_2 + c_3
    xor xor1 (sum_o, a_i, b_i, carry_i); // sum_o   = a_i ^ b_i ^ carry_i
    
endmodule