
`timescale 1ns/1ps

module sipo_shift_register_enable (
    input CLK,
    input RESET,
    input ENABLE,
    input SERIAL_IN,
    output reg [3:0] PARALLEL_OUT
);

    always @(posedge CLK) begin
        if (RESET)
            PARALLEL_OUT <= 4'b0000;
        else if (ENABLE)
            PARALLEL_OUT <= {PARALLEL_OUT[2:0], SERIAL_IN};
    end

endmodule
