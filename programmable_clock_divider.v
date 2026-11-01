`timescale 1ns/1ps

module programmable_clock_divider (
    input CLK,
    input RESET,
    input [7:0] DIV_FACTOR,
    output reg OUT_CLK
);

    reg [7:0] count;
    reg [7:0] active_divisor;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            count <= 0;
            active_divisor <= 2;
            OUT_CLK <= 0;
        end
        else begin
            if (DIV_FACTOR < 2)
                active_divisor <= 2;
            else
                active_divisor <= DIV_FACTOR;

            if (count >= active_divisor - 1) begin
                count <= 0;
                OUT_CLK <= ~OUT_CLK;
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end

endmodule
