module module_temporizador(

    input logic clk_i,
    input logic rst_i,
    input logic en_i,
    
    output logic fin_o
);
 
    logic [31:0] count;

    always @ (posedge clk_i)
    
        if (!rst_i) begin
        
            count <= 0;
            fin_o <= 0;
        end

        else if (count == 99999999) begin
        
            fin_o <= 1;
            count <= 0;  
        end 
        
        else if (en_i) begin
        
            count <= count + 1;
            fin_o <= 0;  
        end 
           
endmodule