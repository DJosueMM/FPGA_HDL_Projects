module module_fsm_spi

    import spi_pkg ::*;
    
(

    input logic clk_i,
    input logic rst_i,
    
    input logic pos_edge_i,
    input logic neg_edge_i,

    input palabra_control palabra_control_i,

    output logic en_sclk_o,
    output logic en_shift_tx_o,
    output logic en_shift_rx_o,
    output logic en_load_o,
    
    output logic we2_data_o,
    output logic we2_control_o,
    
    output logic cs_o,
    
    output logic [1 : 0] addr2_o,
    output logic [1 : 0] mux_all_01_sel,
    
    output logic send_o,
    output logic hold_ctrl_o,
    output logic [9 : 0] n_rx_end_o

);

    //Senales internas
    logic fin;        //una transaccion
    logic termina;    //toda la operacion
    logic en_shift_tx;
    logic en_shift_rx;

    logic [9 : 0] n_tranc;
    logic [3 : 0] conta_neg_edge;

    //Generar shift
    always_ff@(posedge clk_i) begin
    
        if(!rst_i || fin) begin
        
            conta_neg_edge <= 4'd0;
            en_shift_tx    <= 0;
            en_shift_rx    <= 0;
        end   
        
        else begin
        
            if (pos_edge_i) begin
                en_shift_tx <= 1;
            end 
            
            else begin
                en_shift_tx <= 0;
            end
        
            if (neg_edge_i) begin
                en_shift_rx <= 1;
                conta_neg_edge <= conta_neg_edge + 4'd1;
            end 
            
            else begin
                en_shift_rx <= 0;
                conta_neg_edge <= conta_neg_edge;
            end
        end       
    end 

       //fin
        always_ff@(posedge clk_i) begin
       
           if(!rst_i) begin
        
               fin <= 0;
           end
           
           else begin
           
               if (conta_neg_edge == 8 && neg_edge_i == 1) begin
                    fin <= 1;
                end
                
               else begin
                     fin <= 0;
               end
           end     
       end
       
       //manejo de termina y numero de transacciones 
       always_ff@(posedge clk_i) begin
       
           if(!rst_i || state_r == INIT) begin
        
               n_tranc <= 10'd0;
           end
           
           else begin
           
               if (fin) begin
                   n_tranc <= n_tranc + 10'd1; 
               end
                   
               else begin
                    n_tranc <= n_tranc;
               end
               
               if (n_tranc == palabra_control_i.n_tx_end) begin
                   termina <= 1;
               end   
               
               else begin
                   termina <= 0;
               end
           end
       end
        
   ///////////////////////
   
   assign mux_all_01_sel = {palabra_control_i.all_0s, palabra_control_i.all_1s};
   assign en_shift_tx_o = en_shift_tx;
   assign en_shift_rx_o = en_shift_rx;
   
   //Maquina de estados 
    typedef enum logic [2:0] {

        INIT,
        LOAD,
        TRANSACTION,
        ALMACENAR,
        INDEX,
        FIN

    } state;
 
    state state_r;
    state next_state;
    logic [1 : 0] next_addr2;

    //cambio de estado
    always_ff @(posedge clk_i) 

        if (!rst_i) begin
        
            state_r <= INIT;
            addr2_o <= 0;
        end
        else begin
            state_r <= next_state;
            addr2_o <= next_addr2;
        end    

    //Logica de siguiente estado y salida       
    always_comb begin
  
        next_addr2    = addr2_o;
        next_state    = state_r;
        en_sclk_o     = 0;
        en_load_o     = 0;
        hold_ctrl_o   = 0;
        we2_data_o    = 0;
        we2_control_o = 0;
        cs_o          = 1;
        send_o        = 0;
        n_rx_end_o    = '0;

        case (state_r)

            INIT :          begin
            
                                //Salida
                                en_sclk_o     = 0;
                                en_load_o     = 0;
                                hold_ctrl_o   = 0;
                                we2_data_o    = 0;
                                we2_control_o = 0;
                                cs_o          = 1;
                                next_addr2    = '0;
                                send_o        = 0;
                                n_rx_end_o    = '0;
                            
                                //Siguiente estado
                                if (palabra_control_i.send && rst_i) begin
                                
                                    next_state = LOAD;
                                end
                                
                                else  next_state = INIT;
                            end
            

            LOAD :          begin
            
                                //Salida
                                en_sclk_o     = 0;
                                en_load_o     = 1;
                                hold_ctrl_o   = 1;
                                we2_data_o    = 0;
                                we2_control_o = 0;
                                cs_o          = 1;
                                next_addr2    = addr2_o;
                                send_o        = 1;
                                n_rx_end_o    = n_tranc;

                                //Siguiente estado
                                next_state = TRANSACTION;
                                  
                            end
            

            TRANSACTION :   begin 
            
                                //Salida
                                en_sclk_o     = 1;
                                en_load_o     = 0;
                                hold_ctrl_o   = 1;
                                we2_data_o    = 0;
                                we2_control_o = 0;
                                cs_o          = ~palabra_control_i.cs_ctrl;
                                next_addr2    = addr2_o;
                                send_o        = 1;
                                n_rx_end_o    = n_tranc;
                                
                                //Siguiente estado
                                if (fin) begin
                                    next_state = ALMACENAR;

                                end

                                else begin

                                    next_state = TRANSACTION;
                                end
                                
                            end


            ALMACENAR :     begin
                                
                                //Salida
                                en_sclk_o     = 0;
                                en_load_o     = 0;
                                hold_ctrl_o   = 1;
                                we2_data_o    = 1;
                                we2_control_o = 1;
                                cs_o          = 1;
                                next_addr2    = addr2_o;
                                send_o        = 1;
                                n_rx_end_o    = n_tranc;
                                                            
                                //Siguiente estado
                                if (termina) begin
                                
                                    next_state = FIN;

                                end

                                else begin

                                    next_state = INDEX;
                                end
                            end


            INDEX :         begin
             
                                //Salida
                                en_sclk_o     = 0;
                                en_load_o     = 0;
                                hold_ctrl_o   = 1;
                                we2_data_o    = 0;
                                we2_control_o = 0;
                                cs_o          = 1;
                                next_addr2    = addr2_o + 1;
                                send_o        = 1;
                                n_rx_end_o    = n_tranc;
                            
                                //Siguiente estado
                                next_state = LOAD;
                                
                            end


            FIN :           begin
            
                                //Salida
                                en_sclk_o     = 0;
                                en_load_o     = 0;
                                hold_ctrl_o   = 1;
                                we2_data_o    = 0;
                                we2_control_o = 1;
                                cs_o          = 1;
                                next_addr2    = addr2_o;
                                send_o        = 0;
                                n_rx_end_o    = n_tranc;
                            
                                //Siguiente estado
                                next_state = INIT;

                            end
            
            default: next_state = INIT;
        
        endcase
    end

endmodule