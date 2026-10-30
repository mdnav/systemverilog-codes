`timescale 1ns/1ps

module tb_spi_slave_receiver;

    reg SCLK;
    reg RESET;
    reg CS;
    reg MOSI;

    wire [7:0] DATA_OUT;
    wire DATA_VALID;

    spi_slave_receiver uut (
        .SCLK(SCLK),
        .RESET(RESET),
        .CS(CS),
        .MOSI(MOSI),
        .DATA_OUT(DATA_OUT),
        .DATA_VALID(DATA_VALID)
    );

    // SPI clock generation
    initial SCLK = 0;
    always #5 SCLK = ~SCLK;

    task send_byte;
        input [7:0] data;
        integer i;
        begin
            for (i = 7; i >= 0; i = i - 1) begin
                @(negedge SCLK);
                MOSI = data[i];
                @(posedge SCLK);
                #1;
            end
        end
    endtask

    initial begin
        RESET = 1;
        CS = 1;
        MOSI = 0;

        #12;
        RESET = 0;

        // Select the SPI slave
        @(negedge SCLK);
        CS = 0;

        // Send 8-bit data: A5
        send_byte(8'hA5);

        #2;
        if (DATA_OUT == 8'hA5 && DATA_VALID)
            $display("PASS: Received DATA = %h", DATA_OUT);
        else
            $display("FAIL: DATA = %h, VALID = %b",
                     DATA_OUT, DATA_VALID);

        // Send another byte: 3C
        send_byte(8'h3C);

        #2;
        if (DATA_OUT == 8'h3C && DATA_VALID)
            $display("PASS: Received DATA = %h", DATA_OUT);
        else
            $display("FAIL: DATA = %h, VALID = %b",
                     DATA_OUT, DATA_VALID);

        // Deselect slave
        @(negedge SCLK);
        CS = 1;

        #20;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | CS=%b | MOSI=%b | DATA_OUT=%h | DATA_VALID=%b",
            $time, CS, MOSI, DATA_OUT, DATA_VALID
        );
    end

endmodule
