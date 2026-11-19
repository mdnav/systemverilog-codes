module binary_to_onehot_8bit(
    input wire [7:0] binary_in,
    output reg [255:0] onehot_out
);

    always @(*) begin
        onehot_out = 256'b0;
        onehot_out[binary_in] = 1'b1;
    end

endmodule
