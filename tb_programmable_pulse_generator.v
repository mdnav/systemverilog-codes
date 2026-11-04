`timescale 1ns/1ps

module tb_programmable_pulse_generator;

    reg clk;
    reg reset;
    reg enable;
    reg [7:0] period;
    reg [7:0] pulse_width;

    wire pulse_out;

    programmable_pulse_generator #(
        .WIDTH(8)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .period(period),
        .pulse_width(pulse_width),
        .pulse_out(pulse_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        period = 10;
        pulse_width = 3;

        $monitor(
            "Time=%0t | Period=%0d | Width=%0d | Pulse=%b",
            $time, period, pulse_width, pulse_out
        );

        repeat (2) @(negedge clk);
        reset = 0;
        enable = 1;

        // Observe multiple generated pulses.
        repeat (35) @(negedge clk);

        enable = 0;
        @(negedge clk);

        if (pulse_out == 0)
            $display("TEST PASSED: Output LOW when disabled");
        else
            $display("TEST FAILED");

        $finish;
    end

endmodule
