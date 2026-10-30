`timescale 1ns/1ps

module spi_slave_transmitter (
    input SCLK,
    input RESET,
    input CS,
    input [7:0] DATA_IN,
    input LOAD,
    output reg MISO,
    output reg DATA_SENT
);

    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    always @(negedge SCLK or posedge RESET) begin
        if (RESET) begin
            shift_reg <= 8'b0;
            bit_count <= 0;
            MISO <= 0;
            DATA_SENT <= 0;
        end
        else if (CS) begin
            shift_reg <= 8'b0;
            bit_count <= 0;
            MISO <= 0;
            DATA_SENT <= 0;
        end
        else begin
            DATA_SENT <= 0;

            if (LOAD) begin
                shift_reg <= DATA_IN;
                MISO <= DATA_IN[7];
                bit_count <= 0;
            end
            else begin
                MISO <= shift_reg[6];
                shift_reg <= {shift_reg[6:0], 1'b0};

                if (bit_count == 7) begin
                    bit_count <= 0;
                    DATA_SENT <= 1;
                end
                else begin
                    bit_count <= bit_count + 1'b1;
                end
            end
        end
    end

endmodule
