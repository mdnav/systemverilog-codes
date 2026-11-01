`timescale 1ns/1ps

module tb_programmable_clock_divider;

    reg CLK;
    reg RESET;
    reg [7:0] DIV_FACTOR;

    wire OUT_CLK;

    programmable_clock_divider uut (
        .CLK(CLK),
        .RESET(RESET),
        .DIV_FACTOR(DIV_FACTOR),
        .OUT_CLK(OUT_CLK)
    );

    // Input clock period = 10 ns
    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        DIV_FACTOR = 4;

        #12;
        RESET = 0;

        // Division factor 4
        $display("Testing DIV_FACTOR = 4");
        repeat (30) @(negedge CLK);

        // Change division factor to 5
        DIV_FACTOR = 5;
        $display("Testing DIV_FACTOR = 5");
        repeat (40) @(negedge CLK);

        // Change division factor to 10
        DIV_FACTOR = 10;
        $display("Testing DIV_FACTOR = 10");
        repeat (60) @(negedge CLK);

        #10;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | DIV_FACTOR=%0d | CLK=%b | OUT_CLK=%b",
            $time, DIV_FACTOR, CLK, OUT_CLK
        );
    end

endmodule
