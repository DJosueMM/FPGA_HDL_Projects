module module_mux_3_1 # (

    parameter DATA_WIDTH = 8
)(

    input logic [1 : 0] sel,
    input logic [DATA_WIDTH - 1 : 0] data_i,

    output logic [DATA_WIDTH - 1 : 0] data_o

);

    always_comb begin

        data_o = '0;

        case (sel) 

            2'b00: data_o = data_i;
            2'b01: data_o = 8'b11111111;
            2'b10: data_o = 8'b00000000;

            default: data_o = 8'b11111111;

        endcase

    end

endmodule