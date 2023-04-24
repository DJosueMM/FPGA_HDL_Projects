//Modulo para modelar el bloque de nivel de pulso
module module_nivel_pulso(

//entradas
input logic clk_i,
input logic rst_i,
input logic p_i,

//salidas 
output logic pulso_o
);

//definicion de estados
typedef enum {

    espera, 
    genera
    
} state;

state state_r;
state next_state;

//cambio de estado
always_ff @ (posedge clk_i)

    if (!rst_i) begin
    
        state_r <= espera;
    end 
    
    else begin  
    
        state_r <= next_state;
    end    
        
//Logica de siguiente estado y salida       
always_comb begin

    next_state = state_r;
    pulso_o    = 0;
    
    case (state_r)
    
        espera :     begin 
                          if (p_i) begin
                              
                              next_state = genera;
                              pulso_o  = 1;
                          end
                      end
                      
                      
        genera:      begin 
                          if (~p_i) begin
                              
                              next_state = espera;
                              pulso_o  = 0;  
                          end  
                      end

        default: next_state = espera;
        
    endcase
end

endmodule