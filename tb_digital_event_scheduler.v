`timescale 1ns/1ps

module tb_digital_event_scheduler;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] delay_value;

    wire trigger;
    wire busy;

    digital_event_scheduler #(
        .WIDTH(8)
    ) uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .delay_value(delay_value),
        .trigger(trigger),
        .busy(busy)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        delay_value = 5;

        $monitor(
            "Time=%0t | Delay=%0d | Busy=%b | Trigger=%b",
            $time, delay_value, busy, trigger
        );

        repeat (2) @(negedge clk);
        reset = 0;

        // Schedule an event after 5 clock cycles.
        @(negedge clk);
        start = 1;
        @(negedge clk);
        start = 0;

        wait (trigger == 1);
        $display("TEST PASSED: Scheduled event triggered");

        // Verify that the scheduler is idle again.
        @(negedge clk);
        if (busy == 0)
            $display("TEST PASSED: Scheduler returned to idle");

        // Test an immediate event with zero delay.
        delay_value = 0;
        @(negedge clk);
        start = 1;
        @(negedge clk);
        start = 0;

        if (trigger == 1)
            $display("TEST PASSED: Zero-delay event");

        #10;
        $finish;
    end

endmodule
