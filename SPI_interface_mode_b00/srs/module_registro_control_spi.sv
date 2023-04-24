module registro_control_spi 

    import spi_pkg :: *; //pkg del SPI

#(

    parameter DATA_WIDTH = 32
)(
    //Entradas del modulo
    input logic [DATA_WIDTH - 1 : 0] data_1_i, //Datos del cliente
    input logic [9 : 0] n_rx_end_i,  //Cantidad de transacciones realizadas

    input logic clk_i,        //Reloj 10 MHz   
    input logic rst_i,        //reset activo en bajo
    input logic send_clear_i, //senal para sobreescribir el send
    input logic wr_1_i,       //write enable del dato del cliente
    input logic wr_2_i,       //write enable del 

    //Salidas del modulo
    output logic [DATA_WIDTH - 1 : 0] data_o //Salida de datos

);

    palabra_control palabra_control_r;
    
    always_ff@(posedge clk_i) begin //Escritura en el registro
        
        if (~rst_i) begin //Reset 

            palabra_control_r <= '0;
        end
        
        else if (wr_1_i) begin //Escritura en registro por entrada 1 (cliente)
        
            palabra_control_r <= data_1_i; 

        end
        
        else if (wr_2_i) begin //Escritura en registro por entrada 2 (FSM)

            palabra_control_r.send     <= send_clear_i;
            palabra_control_r.n_rx_end <= n_rx_end_i;
        end    

        else palabra_control_r <= palabra_control_r;

    end
    
    assign data_o = palabra_control_r; //Lectura en el registro

endmodule