`timescale 1ns/1ps

module i2c_slave_receiver (
    input SCL,
    input RESET,
    input SDA_IN,
    input START,
    input STOP,
    output reg [7:0] DATA_OUT,
    output reg DATA_VALID,
    output reg ACK
);

    reg [7:0] shift_reg;
    reg [3:0] bit_count;

    always @(posedge SCL or posedge RESET) begin
        if (RESET) begin
            shift_reg <= 8'b0;
            bit_count <= 0;
            DATA_OUT <= 8'b0;
            DATA_VALID <= 0;
            ACK <= 1;
        end
        else if (STOP) begin
            bit_count <= 0;
            DATA_VALID <= 0;
            ACK <= 1;
        end
        else if (START) begin
            shift_reg <= 8'b0;
            bit_count <= 0;
            DATA_VALID <= 0;
            ACK <= 1;
        end
        else begin
            DATA_VALID <= 0;

            if (bit_count < 8) begin
                shift_reg <= {shift_reg[6:0], SDA_IN};
                bit_count <= bit_count + 1'b1;

                if (bit_count == 7) begin
                    DATA_OUT <= {shift_reg[6:0], SDA_IN};
                    DATA_VALID <= 1;
                    ACK <= 0;
                    bit_count <= 8;
                end
            end
            else begin
                // ACK phase
                ACK <= 0;
                bit_count <= 0;
            end
        end
    end

endmodule
