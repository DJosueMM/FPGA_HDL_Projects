
module module_contador_2bits (

    input logic           clk, 
    input logic           rst_n_i, 
    input logic           en_i, 
    input logic           refresh_i,
    output logic [1 : 0]  conta_o
    );
    
    logic [1:0] registro_refresh_r;

    always_ff@(posedge clk) begin
        registro_refresh_r <= {registro_refresh_r[0], refresh_i};
    end

    always_ff@(posedge clk) begin
        if(~rst_n_i)
        
            conta_o <= 0;
            
        else if (!en_i && (registro_refresh_r == 2'b01)) 
        
            conta_o <= conta_o + 1;

        else if (en_i)  
        
            conta_o <= conta_o;
       
    end

endmodule
