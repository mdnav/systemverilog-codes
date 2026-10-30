
`timescale 1ns/1ps

module piso_shift_register_load_enable (
    input CLK,
    input RESET,
    input LOAD,
    input ENABLE,
    input [3:0] PARALLEL_IN,
    output reg SERIAL_OUT
);

    reg [3:0] shift_reg;

    always @(posedge CLK) begin
        if (RESET) begin
            shift_reg <= 4'b0000;
            SERIAL_OUT <= 1'b0;
        end
        else if (LOAD) begin
            shift_reg <= PARALLEL_IN;
            SERIAL_OUT <= PARALLEL_IN[3];
        end
        else if (ENABLE) begin
            SERIAL_OUT <= shift_reg[2];
            shift_reg <= {shift_reg[2:0], 1'b0};
        end
    end

endmodule

