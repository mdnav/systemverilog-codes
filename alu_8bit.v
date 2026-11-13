module alu_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [2:0] sel,
    output reg [7:0] result,
    output reg zero
);

    always @(*) begin
        case (sel)

            3'b000: result = A + B;  // Addition
            3'b001: result = A - B;  // Subtraction
            3'b010: result = A & B;  // AND
            3'b011: result = A | B;  // OR
            3'b100: result = A ^ B;  // XOR
            3'b101: result = ~A;     // NOT
            3'b110: result = A << 1; // Left shift
            3'b111: result = A >> 1; // Right shift

            default: result = 8'b00000000;

        endcase

        zero = (result == 0);
    end

endmodule
