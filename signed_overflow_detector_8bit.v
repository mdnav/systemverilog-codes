
module signed_overflow_detector_8bit (
    input wire [7:0] A,
    input wire [7:0] B,
    input wire subtract,
    output reg [7:0] result,
    output reg overflow
);

    always @(*) begin
        if (subtract) begin
            result = A - B;

            // Subtraction overflow:
            // operands have different signs,
            // and result sign differs from A.
            overflow = (A[7] != B[7]) &&
                       (result[7] != A[7]);
        end
        else begin
            result = A + B;

            // Addition overflow:
            // operands have the same sign,
            // and result sign differs from A.
            overflow = (A[7] == B[7]) &&
                       (result[7] != A[7]);
        end
    end

endmodule
