module barrel_shifter_rotate(
    input wire [7:0] data_in,
    input wire [2:0] shift_amount,
    input wire [1:0] operation,
    output reg [7:0] data_out
);

    always @(*) begin
        case (operation)

            2'b00: 
                data_out = data_in << shift_amount;

            2'b01: 
                data_out = data_in >> shift_amount;

            2'b10: 
                data_out = (data_in << shift_amount) |
                           (data_in >> (8 - shift_amount));

            2'b11: 
                data_out = (data_in >> shift_amount) |
                           (data_in << (8 - shift_amount));

            default:
                data_out = data_in;

        endcase
    end

endmodule
