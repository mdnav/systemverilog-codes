`timescale 1ns/1ps

module tb_watchdog_timer;

    reg clk;
    reg reset;
    reg kick;
    wire timeout;

    watchdog_timer #(
        .TIMEOUT_CYCLES(5)
    ) uut (
        .clk(clk),
        .reset(reset),
        .kick(kick),
        .timeout(timeout)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        kick = 0;

        $monitor("Time=%0t | Kick=%b | Timeout=%b",
                 $time, kick, timeout);

        // Apply reset
        #12;
        reset = 0;

        // Kick before timeout
        repeat (3) @(negedge clk);
        kick = 1;
        @(negedge clk);
        kick = 0;

        // Allow timer to expire
        repeat (7) @(negedge clk);

        if (timeout == 1)
            $display("TEST PASSED: Watchdog timeout detected");
        else
            $display("TEST FAILED: Timeout not detected");

        // Kick resets the watchdog and clears timeout
        kick = 1;
        @(negedge clk);
        kick = 0;

        if (timeout == 0)
            $display("TEST PASSED: Watchdog reset by kick");

        #10;
        $finish;
    end

endmodule
