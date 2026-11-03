`timescale 1ns/1ps

module tb_digital_frequency_counter_display;

    reg clk;
    reg reset;
    reg pulse_in;

    wire [7:0] frequency_count;
    wire [6:0] tens_display;
    wire [6:0] ones_display;

    digital_frequency_counter_display #(
        .WINDOW_CYCLES(100)
    ) uut (
        .clk(clk),
        .reset(reset),
        .pulse_in(pulse_in),
        .frequency_count(frequency_count),
        .tens_display(tens_display),
        .ones_display(ones_display)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0;
        reset = 1;
        pulse_in = 0;

        $display("Time\tCount\tTens\tOnes");

        #12;
        reset = 0;

        // Generate 10 input pulses within one measurement window.
        for (i = 0; i < 10; i = i + 1) begin
            repeat (5) @(negedge clk);
            pulse_in = 1;
            @(negedge clk);
            pulse_in = 0;
        end

        // Wait for measurement window to finish.
        repeat (60) @(negedge clk);

        $display("%0t\t%0d\t%07b\t%07b",
                 $time, frequency_count,
                 tens_display, ones_display);

        if (frequency_count == 10)
            $display("TEST PASSED");
        else
            $display("TEST RESULT: count = %0d", frequency_count);

        $finish;
    end

endmodule
