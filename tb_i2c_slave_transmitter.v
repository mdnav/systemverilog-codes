`timescale 1ns/1ps

module tb_i2c_slave_transmitter;

    reg SCL;
    reg RESET;
    reg START_TX;
    reg [7:0] DATA_IN;

    wire SDA_OUT;
    wire DATA_VALID;

    i2c_slave_transmitter uut (
        .SCL(SCL),
        .RESET(RESET),
        .START_TX(START_TX),
        .DATA_IN(DATA_IN),
        .SDA_OUT(SDA_OUT),
        .DATA_VALID(DATA_VALID)
    );

    // Generate SCL clock
    initial SCL = 0;
    always #5 SCL = ~SCL;

    initial begin
        RESET = 1;
        START_TX = 0;
        DATA_IN = 8'h00;

        #12;
        RESET = 0;

        // Load data A5
        @(negedge SCL);
        DATA_IN = 8'hA5;
        START_TX = 1;

        @(negedge SCL);
        START_TX = 0;

        // Monitor transmission
        repeat (10) begin
            @(negedge SCL);
            $display(
                "Time=%0t | SDA_OUT=%b | DATA_VALID=%b",
                $time, SDA_OUT, DATA_VALID
            );
        end

        // Send another byte
        DATA_IN = 8'h3C;
        START_TX = 1;

        @(negedge SCL);
        START_TX = 0;

        repeat (10) @(negedge SCL);

        #10;
        $finish;
    end

endmodule
