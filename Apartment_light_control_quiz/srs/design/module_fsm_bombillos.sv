//módulo para modelar la máquina de estados de Mealy para el control de las luces 
module module_fsm_bombillos(

    //entradas
    input logic clk_i,
    input logic rst_i,
    input logic p1_i,
    input logic p2_i,
    input logic fin_i,
   
    //salidas 
    output logic         en_o,
    output logic [2 : 0] b_o
);
 
    //definicion de estados
    typedef enum {
    
        por_defecto, 
        lobby,
        timer,
        cuarto_1,
        cuarto_2
        
    } state;
    
    state state_r;
    state next_state;

    //cambio de estado
    always_ff @ (posedge clk_i)
    
        if (!rst_i) begin
        
            state_r <= por_defecto;
        end 
        
        else begin  
        
            state_r <= next_state;
        end    
            
            
    //Logica de siguiente estado y salida       
    always_comb begin
    
        next_state = state_r;
        b_o = 3'b000;
        en_o = 0;
    
        case (state_r)
        
            por_defecto : begin 
                              if (~rst_i || (~p1_i && ~p2_i)) begin
                                  
                                  next_state = por_defecto;
                                  b_o = 3'b000;
                                  en_o = 0;
                              end
                              
                              else if (p1_i || p2_i) begin
                              
                                  next_state = lobby;
                                  b_o = 3'b001;
                                  en_o = 0;
                              end    
                          end
                          
                          
            lobby:        begin 
                              if (~p1_i && ~p2_i) begin
                                  
                                  next_state = timer;
                                  b_o = 3'b001;
                                  en_o = 1;
                                  
                              end  
                          end
                          
            timer:        begin 
                              if (~fin_i && ~p1_i && ~p2_i) begin
                                  
                                  next_state = timer;
                                  b_o = 3'b001;
                                  en_o = 1;
                              end
                              
                              else if (p1_i && ~p2_i) begin
                              
                                  next_state = cuarto_1;
                                  b_o = 3'b010;
                                  en_o = 0;
                              end
                              
                              else if (p2_i && ~p1_i) begin
                              
                                  next_state = cuarto_2;
                                  b_o = 3'b100;
                                  en_o = 0;
                              end     
                              
                              else if (fin_i) begin
                              
                                  next_state = por_defecto;
                                  b_o = 3'b000;
                                  en_o = 0;
                              end 
                              
                          end  
                          
            cuarto_1 :    begin 
                              if (~p1_i && ~p2_i) begin
                                  
                                  next_state = cuarto_1;
                                  b_o = 3'b010;
                                  en_o = 0;
                              end 
                              
                              else if (p1_i || p2_i) begin
                              
                                  next_state = por_defecto;
                                  b_o = 3'b000;
                                  en_o = 0;
                              end    
                          end
                               
            cuarto_2 :    begin 
                              if (~p1_i && ~p2_i) begin
                                  
                                  next_state = cuarto_2;
                                  b_o = 3'b100;
                                  en_o = 0;
                              end 
                              
                              else if (p1_i || p2_i) begin
                              
                                  next_state = por_defecto;
                                  b_o = 3'b000;
                                  en_o = 0;
                              end    
                          end
            
            default: next_state = por_defecto;
            
        endcase
    end
       
endmodule
