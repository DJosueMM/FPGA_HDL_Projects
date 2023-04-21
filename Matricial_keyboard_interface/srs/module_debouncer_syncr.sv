`timescale 1ns / 1ps

module module_debouncer_syncr(

    input logic clk, // Clock input
    input logic reset, // Reset input
    input logic [3:0] in, // Input to be debounced and synchronized
    output logic [3:0] out // Debounced and synchronized output
);

    logic [3:0] input_reg;
    logic [3:0] sync_reg;
    logic [3:0] debounce_reg;
    logic [3:0] output_reg;

    always_ff @(posedge clk) begin
    if (!reset) begin
    
        input_reg <= 2'b00;
        sync_reg <= 2'b00;
        debounce_reg <= 2'b00;
        output_reg <= 2'b00;
    end else begin

        sync_reg <= {input_reg[3], input_reg[2], input_reg[1], input_reg[0]};
        input_reg <= in;

        if (sync_reg != debounce_reg) begin
            output_reg <= debounce_reg;
        end else begin
            output_reg <= sync_reg;
        end

        if (sync_reg != debounce_reg) begin
            debounce_reg <= sync_reg;
        end else if (debounce_reg != output_reg) begin
            debounce_reg <= debounce_reg;
        end
    end
end

    assign out = output_reg;
endmodule



