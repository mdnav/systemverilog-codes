`timescale 1ns/1ps

module tb_sipo_shift_register_enable;

    reg CLK;
    reg RESET;
    reg ENABLE;
    reg SERIAL_IN;

    wire [3:0] PARALLEL_OUT;

    sipo_shift_register_enable uut (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(ENABLE),
        .SERIAL_IN(SERIAL_IN),
        .PARALLEL_OUT(PARALLEL_OUT)
    );

    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        ENABLE = 0;
        SERIAL_IN = 0;

        // Apply reset
        @(negedge CLK);
        RESET = 0;
        ENABLE = 1;

        // Shift in 1, 0, 1, 1
        SERIAL_IN = 1;
        @(negedge CLK);

        SERIAL_IN = 0;
        @(negedge CLK);

        SERIAL_IN = 1;
        @(negedge CLK);

        SERIAL_IN = 1;
        @(negedge CLK);

        // Disable shifting
        ENABLE = 0;
        SERIAL_IN = 0;
        repeat (2) @(negedge CLK);

        // Apply reset again
        RESET = 1;
        @(negedge CLK);
        RESET = 0;

        #10;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | RESET=%b | ENABLE=%b | SERIAL_IN=%b | PARALLEL_OUT=%b",
                 $time, RESET, ENABLE, SERIAL_IN, PARALLEL_OUT);
    end

endmodule
