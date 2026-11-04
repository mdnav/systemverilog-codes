`timescale 1ns/1ps

module tb_programmable_event_counter;

    reg clk;
    reg reset;
    reg enable;
    reg event_in;
    reg [7:0] threshold;

    wire [7:0] count;
    wire alert;

    programmable_event_counter #(
        .WIDTH(8)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .event_in(event_in),
        .threshold(threshold),
        .count(count),
        .alert(alert)
    );

    always #5 clk = ~clk;

    task send_event;
        begin
            @(negedge clk);
            event_in = 1;
            @(negedge clk);
            event_in = 0;
            @(negedge clk);
        end
    endtask

    integer i;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        event_in = 0;
        threshold = 5;

        $monitor("Time=%0t | Count=%0d | Threshold=%0d | Alert=%b",
                 $time, count, threshold, alert);

        repeat (2) @(negedge clk);
        reset = 0;
        enable = 1;

        // Send five events
        for (i = 0; i < 5; i = i + 1)
            send_event();

        if (count == 5 && alert == 1)
            $display("TEST PASSED: Threshold alert generated");
        else
            $display("TEST FAILED");

        // Reset the counter
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;

        if (count == 0 && alert == 0)
            $display("TEST PASSED: Counter reset");

        $finish;
    end

endmodule
