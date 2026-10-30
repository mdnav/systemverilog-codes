`timescale 1ns/1ps

module uart_transceiver (
    input CLK,
    input RESET,

    input TX_START,
    input [7:0] TX_DATA,
    output reg TX,
    output reg TX_BUSY,

    input RX,
    output reg [7:0] RX_DATA,
    output reg RX_DONE
);

    // Transmitter states
    localparam TX_IDLE  = 2'd0;
    localparam TX_START_BIT = 2'd1;
    localparam TX_DATA_BITS = 2'd2;
    localparam TX_STOP_BIT  = 2'd3;

    reg [1:0] tx_state;
    reg [7:0] tx_shift;
    reg [2:0] tx_bit_count;

    // Receiver states
    localparam RX_IDLE = 2'd0;
    localparam RX_DATA_BITS = 2'd1;
    localparam RX_STOP_BIT = 2'd2;

    reg [1:0] rx_state;
    reg [2:0] rx_bit_count;
    reg [7:0] rx_shift;

    // UART transmitter: one clock per bit
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            tx_state <= TX_IDLE;
            tx_shift <= 0;
            tx_bit_count <= 0;
            TX <= 1;
            TX_BUSY <= 0;
        end
        else begin
            case (tx_state)
                TX_IDLE: begin
                    TX <= 1;
                    TX_BUSY <= 0;

                    if (TX_START) begin
                        tx_shift <= TX_DATA;
                        TX_BIT_COUNT <= 0;
                        TX <= 0;
                        TX_BUSY <= 1;
                        tx_state <= TX_START_BIT;
                    end
                end

                TX_START_BIT: begin
                    TX <= tx_shift[0];
                    tx_shift <= {1'b0, tx_shift[7:1]};
                    tx_bit_count <= 0;
                    tx_state <= TX_DATA_BITS;
                end

                TX_DATA_BITS: begin
                    TX <= tx_shift[0];
                    tx_shift <= {1'b0, tx_shift[7:1]};

                    if (tx_bit_count == 7)
                        tx_state <= TX_STOP_BIT;
                    else
                        tx_bit_count <= tx_bit_count + 1;
                end

                TX_STOP_BIT: begin
                    TX <= 1;
                    TX_BUSY <= 0;
                    tx_state <= TX_IDLE;
                end
            endcase
        end
    end

    // UART receiver: samples one bit per clock
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            rx_state <= RX_IDLE;
            rx_bit_count <= 0;
            rx_shift <= 0;
            RX_DATA <= 0;
            RX_DONE <= 0;
        end
        else begin
            RX_DONE <= 0;

            case (rx_state)
                RX_IDLE: begin
                    if (RX == 0) begin
                        rx_bit_count <= 0;
                        rx_state <= RX_DATA_BITS;
                    end
                end

                RX_DATA_BITS: begin
                    rx_shift[rx_bit_count] <= RX;

                    if (rx_bit_count == 7)
                        rx_state <= RX_STOP_BIT;
                    else
                        rx_bit_count <= rx_bit_count + 1;
                end

                RX_STOP_BIT: begin
                    if (RX == 1) begin
                        RX_DATA <= rx_shift;
                        RX_DONE <= 1;
                    end

                    rx_state <= RX_IDLE;
                end
            endcase
        end
    end

endmodule
