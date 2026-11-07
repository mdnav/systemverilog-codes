module bcd_adder(
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    output reg [3:0] Sum,
    output reg Cout
);

    reg [4:0] binary_sum;
    reg [4:0] corrected_sum;

    always @(*) begin
        binary_sum = A + B + Cin;

        if (binary_sum > 9)
            corrected_sum = binary_sum + 5'd6;
        else
            corrected_sum = binary_sum;

        Sum = corrected_sum[3:0];
        Cout = corrected_sum[4];
    end

endmodule
