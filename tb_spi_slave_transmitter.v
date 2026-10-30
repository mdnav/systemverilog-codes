`timescale 1ns/1ps

module tb_spi_slave_transmitter;

    reg SCLK;
    reg RESET;
    reg CS;
    reg [7:0] DATA_IN;
    reg LOAD;

    wire MISO;
    wire DATA_SENT;

    spi_slave_transmitter uut (
        .SCLK(SCLK),
        .RESET(RESET),
        .CS(CS),
        .DATA_IN(DATA_IN),
        .LOAD(LOAD),
        .MISO(MISO),
        .DATA_SENT(DATA_SENT)
    );

    // SPI clock
    initial SCLK = 0;
    always #5 SCLK = ~SCLK;

    initial begin
        RESET = 1;
        CS = 1;
        DATA_IN = 8'h00;
        LOAD = 0;

        #12;
        RESET = 0;

        // Select slave
        @(negedge SCLK);
        CS = 0;

        // Load data 10100101
        DATA_IN = 8'hA5;
        LOAD = 1;
        @(negedge SCLK);
        LOAD = 0;

        // Observe serial output
        repeat (8) begin
            @(posedge SCLK);
            #1;
            $display("Time=%0t | MISO=%b | DATA_SENT=%b",
                     $time, MISO, DATA_SENT);
        end

        // Deselect slave
        @(negedge SCLK);
        CS = 1;

        #20;
        $finish;
    end

endmodule
