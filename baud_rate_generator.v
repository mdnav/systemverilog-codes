`timescale 1ns/1ps

module baud_rate_generator #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600
)(
    input CLK,
    input RESET,
    output reg BAUD_TICK
);

    localparam DIVISOR = CLK_FREQ / BAUD_RATE;

    integer count;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            count <= 0;
            BAUD_TICK <= 0;
        end
        else begin
            if (count == DIVISOR - 1) begin
                count <= 0;
                BAUD_TICK <= 1;
            end
            else begin
                count <= count + 1;
                BAUD_TICK <= 0;
            end
        end
    end

endmodule
