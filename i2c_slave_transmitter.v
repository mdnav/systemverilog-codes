`timescale 1ns/1ps

module i2c_slave_transmitter (
    input SCL,
    input RESET,
    input START_TX,
    input [7:0] DATA_IN,
    output reg SDA_OUT,
    output reg DATA_VALID
);

    reg [7:0] shift_reg;
    reg [3:0] bit_count;
    reg active;

    always @(negedge SCL or posedge RESET) begin
        if (RESET) begin
            shift_reg <= 8'b0;
            bit_count <= 0;
            active <= 0;
            SDA_OUT <= 1'b1;
            DATA_VALID <= 0;
        end
        else begin
            DATA_VALID <= 0;

            if (START_TX && !active) begin
                shift_reg <= DATA_IN;
                bit_count <= 0;
                active <= 1;
                SDA_OUT <= DATA_IN[7];
            end
            else if (active) begin
                if (bit_count < 7) begin
                    shift_reg <= {shift_reg[6:0], 1'b0};
                    bit_count <= bit_count + 1'b1;
                    SDA_OUT <= shift_reg[6];
                end
                else begin
                    active <= 0;
                    SDA_OUT <= 1'b1;
                    DATA_VALID <= 1;
                end
            end
        end
    end

endmodule
