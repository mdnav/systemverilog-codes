`timescale 1ns/1ps

module tb_piso_shift_register_load_enable;

    reg CLK;
    reg RESET;
    reg LOAD;
    reg ENABLE;
    reg [3:0] PARALLEL_IN;

    wire SERIAL_OUT;

    piso_shift_register_load_enable uut (
        .CLK(CLK),
        .RESET(RESET),
        .LOAD(LOAD),
        .ENABLE(ENABLE),
        .PARALLEL_IN(PARALLEL_IN),
        .SERIAL_OUT(SERIAL_OUT)
    );

    // Clock generation: 10 ns period
    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        LOAD = 0;
        ENABLE = 0;
        PARALLEL_IN = 4'b0000;

        // Apply reset
        @(negedge CLK);
        RESET = 0;

        // Load parallel data 1011
        LOAD = 1;
        PARALLEL_IN = 4'b1011;

        @(negedge CLK);
        LOAD = 0;
        ENABLE = 1;

        // Shift data out
        repeat (4) @(negedge CLK);

        // Disable shifting
        ENABLE = 0;
        repeat (2) @(negedge CLK);

        // Load another parallel value 1100
        PARALLEL_IN = 4'b1100;
        LOAD = 1;

        @(negedge CLK);
        LOAD = 0;
        ENABLE = 1;

        // Shift second value out
        repeat (4) @(negedge CLK);

        $finish;
    end

    // Display signal values
    initial begin
        $monitor("Time=%0t | RESET=%b | LOAD=%b | ENABLE=%b | PARALLEL_IN=%b | SERIAL_OUT=%b",
                 $time, RESET, LOAD, ENABLE, PARALLEL_IN, SERIAL_OUT);
    end

endmodule
