

module module_key_encoding(

    //Entradas
    input logic clk_i,
    input logic rst_i,
    input logic en,
    
    input logic [1 : 0] key_fila_i,
    input logic [1 : 0] key_colum_i,
    
    //Salidas
    output logic [3 : 0] key_value_o

);

    always_ff @(posedge clk_i) 
    
        if (!rst_i) key_value_o <= '0;
        
        else if (en) begin
        
         key_value_o [3 : 2] <= key_fila_i;
         key_value_o [0] <= key_colum_i [0];
         key_value_o [1] <= key_colum_i [1];
        end
 
endmodule
