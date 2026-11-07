module leading_zero_detector(
    input wire [7:0] data_in,
    output reg [3:0] leading_zeros,
    output reg zero_flag
);

    always @(*) begin
        zero_flag = 0;

        casex (data_in)
            8'b1xxxxxxx: leading_zeros = 0;
            8'b01xxxxxx: leading_zeros = 1;
            8'b001xxxxx: leading_zeros = 2;
            8'b0001xxxx: leading_zeros = 3;
            8'b00001xxx: leading_zeros = 4;
            8'b000001xx: leading_zeros = 5;
            8'b0000001x: leading_zeros = 6;
            8'b00000001: leading_zeros = 7;

            default: begin
                leading_zeros = 8;
                zero_flag = 1;
            end
        endcase
    end

endmodule
