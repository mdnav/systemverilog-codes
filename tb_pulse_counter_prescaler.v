`timescale 1ns/1ps

module tb_pulse_counter_prescaler;

    reg clk;
    reg reset;
    reg enable;
    reg pulse_in;
    reg [7:0] prescaler;

    wire [7:0] count;

    pulse_counter_prescaler #(
        .WIDTH(8)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .pulse_in(pulse_in),
        .prescaler(prescaler),
        .count(count)
    );

    always #5 clk = ~clk;

    task send_pulse;
        begin
            @(negedge clk);
            pulse_in = 1;
            @(negedge clk);
            pulse_in = 0;
            @(negedge clk);
        end
    endtask

    integer i;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        pulse_in = 0;
        prescaler = 4;

        $monitor("Time=%0t | Prescaler=%0d | Count=%0d",
                 $time, prescaler, count);

        repeat (2) @(negedge clk);
        reset = 0;
        enable = 1;

        // 8 input pulses should produce 2 count increments.
        for (i = 0; i < 8; i = i + 1)
            send_pulse();

        if (count == 2)
            $display("TEST PASSED: Prescaler operation");
        else
            $display("TEST FAILED: Count=%0d, expected 2", count);

        // Test prescaler of 1: every pulse increments the counter.
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;
        prescaler = 1;

        for (i = 0; i < 3; i = i + 1)
            send_pulse();

        if (count == 3)
            $display("TEST PASSED: Prescaler equal to 1");

        $finish;
    end

endmodule
