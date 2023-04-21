module module_rx_shift_reg_spi # (

    parameter DATA_WIDTH = 8 //Parametros de ancho de bits
)(

    //Entradas
    input logic clk_i,
    input logic rst_i,
    input logic shift_en_i, 

    input logic data_i,
    
    //Salidas
    output logic [DATA_WIDTH - 1 : 0] data_o
);

    //Registro
    logic [DATA_WIDTH - 1 : 0] data_r;

    //Escritura en registro
    always_ff @ (posedge clk_i) begin

        if(!rst_i) begin //Reset
          
            data_r <= '0;
        end

        else if (shift_en_i) begin //Desplazamiento

            data_r[0] <= data_i;
            data_r[1] <= data_r[0];
            data_r[2] <= data_r[1];
            data_r[3] <= data_r[2];
            data_r[4] <= data_r[3];
            data_r[5] <= data_r[4];
            data_r[6] <= data_r[5];
            data_r[7] <= data_r[6];
        end    

        //Se mantiene el dato
        else 
            data_r <= data_r;
    end

    assign data_o = data_r; //Salida paralela

endmodule