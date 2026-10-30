`timescale 1ns/1ps

module tb_universal_shift_register;

    reg CLK;
    reg RESET;
    reg [1:0] MODE;
    reg [3:0] PARALLEL_IN;
    reg SERIAL_LEFT_IN;
    reg SERIAL_RIGHT_IN;

    wire [3:0] Q;

    universal_shift_register uut (
        .CLK(CLK),
        .RESET(RESET),
        .MODE(MODE),
        .PARALLEL_IN(PARALLEL_IN),
        .SERIAL_LEFT_IN(SERIAL_LEFT_IN),
        .SERIAL_RIGHT_IN(SERIAL_RIGHT_IN),
        .Q(Q)
    );

    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        MODE = 2'b00;
        PARALLEL_IN = 4'b0000;
        SERIAL_LEFT_IN = 0;
        SERIAL_RIGHT_IN = 0;

        // Reset
        @(negedge CLK);
        RESET = 0;

        // Parallel load 1011
        MODE = 2'b11;
        PARALLEL_IN = 4'b1011;
        @(negedge CLK);

        // Hold
        MODE = 2'b00;
        @(negedge CLK);

        // Shift right, serial input = 1
        MODE = 2'b01;
        SERIAL_RIGHT_IN = 1;
        @(negedge CLK);

        // Shift left, serial input = 0
        MODE = 2'b10;
        SERIAL_LEFT_IN = 0;
        @(negedge CLK);

        // Parallel load 1100
        MODE = 2'b11;
        PARALLEL_IN = 4'b1100;
        @(negedge CLK);

        // Shift left
        MODE = 2'b10;
        SERIAL_LEFT_IN = 1;
        @(negedge CLK);

        // Shift right
        MODE = 2'b01;
        SERIAL_RIGHT_IN = 0;
        @(negedge CLK);

        // Finish simulation
        #10;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | MODE=%b | PARALLEL_IN=%b | Q=%b",
            $time, MODE, PARALLEL_IN, Q
        );
    end

endmodule
