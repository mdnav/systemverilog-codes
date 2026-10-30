`timescale 1ns/1ps

module spi_slave_receiver (
    input SCLK,
    input RESET,
    input CS,
    input MOSI,
    output reg [7:0] DATA_OUT,
    output reg DATA_VALID
);

    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    always @(posedge SCLK or posedge RESET) begin
        if (RESET) begin
            shift_reg <= 8'b0;
            bit_count <= 0;
            DATA_OUT <= 8'b0;
            DATA_VALID <= 0;
        end
        else if (CS) begin
            bit_count <= 0;
            shift_reg <= 8'b0;
            DATA_VALID <= 0;
        end
        else begin
            DATA_VALID <= 0;
            shift_reg <= {shift_reg[6:0], MOSI};

            if (bit_count == 7) begin
                DATA_OUT <= {shift_reg[6:0], MOSI};
                DATA_VALID <= 1;
                bit_count <= 0;
            end
            else begin
                bit_count <= bit_count + 1'b1;
            end
        end
    end

endmodule
