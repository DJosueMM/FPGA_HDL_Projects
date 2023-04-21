module module_divisor(

    input logic clk,
    input logic rst_i,
    
    output logic en

);
 
    logic [31:0] count;
    logic timer;

    always @ (posedge clk)
    
        if (!rst_i) begin
        
            count <= 0;
            timer <= 0;
        end

        else if (count == 20000) begin
        
            timer <= ~timer;
            count <= 0;  
        end 
        
        else 
            count <= count + 1;
    

    assign en = timer;
    
endmodule
