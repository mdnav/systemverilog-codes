`timescale 1ns/1ps

module tb_programmable_timer;

    reg clk;
    reg reset;
    reg start;
    reg stop;
    reg [7:0] load_value;

    wire [7:0] count;
    wire done;

    programmable_timer #(
        .WIDTH(8)
    ) uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .stop(stop),
        .load_value(load_value),
        .count(count),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        stop = 0;
        load_value = 8'd5;

        $monitor("Time=%0t | Count=%0d | Done=%b",
                 $time, count, done);

        // Reset timer
        repeat (2) @(negedge clk);
        reset = 0;

        // Start countdown from 5
        start = 1;
        @(negedge clk);
        start = 0;

        // Wait for countdown to finish
        wait (done == 1);
        #1;

        if (count == 0 && done == 1)
            $display("TEST PASSED: Countdown completed");

        // Start another countdown
        @(negedge clk);
        load_value = 8'd6;
        start = 1;
        @(negedge clk);
        start = 0;

        // Pause countdown
        repeat (2) @(negedge clk);
        stop = 1;
        @(negedge clk);
        stop = 0;

        $display("Timer paused at count=%0d", count);

        // Reset to finish the test cleanly
        reset = 1;
        @(negedge clk);
        reset = 0;

        $display("TEST COMPLETED");
        $finish;
    end

endmodule
