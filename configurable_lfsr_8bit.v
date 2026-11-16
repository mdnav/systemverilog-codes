module configurable_lfsr_8bit(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [7:0] seed,
    output reg [7:0] lfsr_out
);

    wire feedback;

    assign feedback = lfsr_out[7] ^ lfsr_out[5] ^
                      lfsr_out[4] ^ lfsr_out[3];

    always @(posedge clk or posedge reset) begin
        if (reset)
            lfsr_out <= seed;
        else if (enable)
            lfsr_out <= {lfsr_out[6:0], feedback};
    end

endmodule
