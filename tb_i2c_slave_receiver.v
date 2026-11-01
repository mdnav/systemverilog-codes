`timescale 1ns/1ps

module tb_i2c_slave_receiver;

    reg SCL;
    reg RESET;
    reg SDA_IN;
    reg START;
    reg STOP;

    wire [7:0] DATA_OUT;
    wire DATA_VALID;
    wire ACK;

    i2c_slave_receiver uut (
        .SCL(SCL),
        .RESET(RESET),
        .SDA_IN(SDA_IN),
        .START(START),
        .STOP(STOP),
        .DATA_OUT(DATA_OUT),
        .DATA_VALID(DATA_VALID),
        .ACK(ACK)
    );

    // Generate I2C clock
    initial SCL = 0;
    always #5 SCL = ~SCL;

    task send_byte;
        input [7:0] data;
        integer i;
        begin
            for (i = 7; i >= 0; i = i - 1) begin
                @(negedge SCL);
                SDA_IN = data[i];
                @(posedge SCL);
                #1;
            end
        end
    endtask

    initial begin
        RESET = 1;
        SDA_IN = 1;
        START = 0;
        STOP = 0;

        #12;
        RESET = 0;

        // Simulate START condition
        @(negedge SCL);
        START = 1;
        @(posedge SCL);
        #1;
        START = 0;

        // Send byte 0xA5
        send_byte(8'hA5);

        if (DATA_OUT == 8'hA5 && DATA_VALID)
            $display("PASS: Received DATA = %h", DATA_OUT);
        else
            $display("FAIL: DATA = %h, VALID = %b",
                     DATA_OUT, DATA_VALID);

        // Simulate STOP condition
        @(negedge SCL);
        STOP = 1;
        @(posedge SCL);
        #1;
        STOP = 0;

        #20;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | SDA=%b | DATA_OUT=%h | DATA_VALID=%b | ACK=%b",
            $time, SDA_IN, DATA_OUT, DATA_VALID, ACK
        );
    end

endmodule
