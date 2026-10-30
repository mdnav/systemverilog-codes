`timescale 1ns/1ps

module tb_uart_transceiver;

    reg CLK;
    reg RESET;
    reg TX_START;
    reg [7:0] TX_DATA;
    reg RX;

    wire TX_OUT;
    wire TX_BUSY;
    wire [7:0] RX_DATA;
    wire RX_DONE;

    uart_transceiver uut (
        .CLK(CLK),
        .RESET(RESET),
        .TX_START(TX_START),
        .TX_DATA(TX_DATA),
        .TX(TX_OUT),
        .TX_BUSY(TX_BUSY),
        .RX(RX),
        .RX_DATA(RX_DATA),
        .RX_DONE(RX_DONE)
    );

    always #5 CLK = ~CLK;

    // Drive the received serial line with UART framing
    task send_byte;
        input [7:0] data;
        integer i;
        begin
            @(negedge CLK);
            RX = 0; // Start bit

            @(negedge CLK);

            for (i = 0; i < 8; i = i + 1) begin
                RX = data[i];
                @(negedge CLK);
            end

            RX = 1; // Stop bit
            @(negedge CLK);
        end
    endtask

    initial begin
        CLK = 0;
        RESET = 1;
        TX_START = 0;
        TX_DATA = 8'h00;
        RX = 1;

        #12;
        RESET = 0;

        // Test receiver with 8-bit data 0xA5
        send_byte(8'hA5);

        // Allow receiver to finish
        repeat (3) @(negedge CLK);

        if (RX_DATA == 8'hA5)
            $display("PASS: Received data = %h", RX_DATA);
        else
            $display("FAIL: Received data = %h, expected A5",
                     RX_DATA);

        // Test transmitter
        TX_DATA = 8'h3C;
        TX_START = 1;
        @(negedge CLK);
        TX_START = 0;

        wait (TX_BUSY == 1);
        $display("Transmitter started: data = %h", TX_DATA);

        wait (TX_BUSY == 0);
        $display("Transmitter completed.");

        #20;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | TX=%b | TX_BUSY=%b | RX=%b | RX_DATA=%h | RX_DONE=%b",
                 $time, TX_OUT, TX_BUSY, RX, RX_DATA, RX_DONE);
    end

endmodule
