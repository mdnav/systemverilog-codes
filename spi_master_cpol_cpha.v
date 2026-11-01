`timescale 1ns/1ps

module spi_master_cpol_cpha #(
    parameter CPOL = 0,
    parameter CPHA = 0
)(
    input CLK,
    input RESET,
    input START,
    input [7:0] TX_DATA,
    input MISO,
    output reg SCLK,
    output reg CS,
    output reg MOSI,
    output reg [7:0] RX_DATA,
    output reg BUSY,
    output reg DONE
);

    reg [7:0] tx_shift;
    reg [7:0] rx_shift;
    reg [3:0] edge_count;
    reg [7:0] divider_count;

    localparam CLK_DIVIDER = 4;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            SCLK <= CPOL;
            CS <= 1;
            MOSI <= 0;
            RX_DATA <= 0;
            tx_shift <= 0;
            rx_shift <= 0;
            edge_count <= 0;
            divider_count <= 0;
            BUSY <= 0;
            DONE <= 0;
        end
        else begin
            DONE <= 0;

            if (!BUSY) begin
                SCLK <= CPOL;
                CS <= 1;
                divider_count <= 0;

                if (START) begin
                    BUSY <= 1;
                    CS <= 0;
                    tx_shift <= TX_DATA;
                    rx_shift <= 0;
                    edge_count <= 0;

                    if (CPHA == 0)
                        MOSI <= TX_DATA[7];
                    else
                        MOSI <= 0;
                end
            end
            else begin
                if (divider_count == CLK_DIVIDER - 1) begin
                    divider_count <= 0;
                    SCLK <= ~SCLK;

                    if (edge_count < 16) begin
                        if ((CPHA == 0 && SCLK == CPOL) ||
                            (CPHA == 1 && SCLK != CPOL)) begin
                            rx_shift <= {rx_shift[6:0], MISO};
                        end

                        if ((CPHA == 0 && SCLK != CPOL) ||
                            (CPHA == 1 && SCLK == CPOL)) begin
                            tx_shift <= {tx_shift[6:0], 1'b0};
                            MOSI <= tx_shift[6];
                        end

                        edge_count <= edge_count + 1'b1;

                        if (edge_count == 15) begin
                            BUSY <= 0;
                            CS <= 1;
                            RX_DATA <= rx_shift;
                            DONE <= 1;
                            SCLK <= CPOL;
                        end
                    end
                end
                else begin
                    divider_count <= divider_count + 1'b1;
                end
            end
        end
    end

endmodule
