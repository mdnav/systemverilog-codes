`timescale 1ns/1ps

module universal_shift_register (
    input CLK,
    input RESET,
    input [1:0] MODE,
    input [3:0] PARALLEL_IN,
    input SERIAL_LEFT_IN,
    input SERIAL_RIGHT_IN,
    output reg [3:0] Q
);

    always @(posedge CLK or posedge RESET) begin
        if (RESET)
            Q <= 4'b0000;
        else begin
            case (MODE)
                2'b00: Q <= Q; // Hold
                2'b01: Q <= {SERIAL_RIGHT_IN, Q[3:1]}; // Shift right
                2'b10: Q <= {Q[2:0], SERIAL_LEFT_IN}; // Shift left
                2'b11: Q <= PARALLEL_IN; // Parallel load
                default: Q <= Q;
            endcase
        end
    end

endmodule
