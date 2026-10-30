
`timescale 1ns/1ps

module digital_frequency_synthesizer #(
    parameter DIVISOR = 4
)(
    input CLK,
    input RESET,
    output reg OUT_CLK
);

    localparam HALF_DIV = DIVISOR / 2;
    integer count;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            count <= 0;
            OUT_CLK <= 0;
        end
        else begin
            if (count == HALF_DIV - 1) begin
                count <= 0;
                OUT_CLK <= ~OUT_CLK;
            end
            else begin
                count <= count + 1;
            end
        end
    end

endmodule
