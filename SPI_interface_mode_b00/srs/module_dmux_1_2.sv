module module_dmux_1_2 (
    
    //Entradas del modulo
    input logic  wr_i,
    input logic  reg_sel_i,

    //Salidas del modulo
    output logic wr1_control_o,
    output logic wr1_datos_o
  );
  
  // demux utilizando un case
  always_comb begin 
    
    case (reg_sel_i)

      1'b0: begin
        wr1_control_o = wr_i;
        wr1_datos_o   = 1'b0;
      end
    
      1'b1: begin
        wr1_control_o = 1'b0;
        wr1_datos_o   = wr_i;
      end
    
      default: begin
        wr1_control_o = 1'b0;
        wr1_datos_o   = 1'b0;
      end
    
    endcase
        
  end
    
endmodule
  
  