`timescale 1ns/1ps

module tb_programmable_pwm_controller;

    reg clk;
    reg reset;
    reg enable;
    reg [7:0] duty_cycle;
    wire pwm_out;

    programmable_pwm_controller #(
        .PERIOD(20)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .duty_cycle(duty_cycle),
        .pwm_out(pwm_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        duty_cycle = 50;

        $monitor("Time=%0t | Enable=%b | Duty=%0d%% | PWM=%b",
                 $time, enable, duty_cycle, pwm_out);

        repeat (2) @(negedge clk);
        reset = 0;

        // Test 50% duty cycle
        enable = 1;
        duty_cycle = 50;
        repeat (25) @(negedge clk);

        // Test 25% duty cycle
        duty_cycle = 25;
        repeat (25) @(negedge clk);

        // Test 75% duty cycle
        duty_cycle = 75;
        repeat (25) @(negedge clk);

        // Disable PWM
        enable = 0;
        repeat (3) @(negedge clk);

        if (pwm_out == 0)
            $display("TEST PASSED: PWM disabled successfully");

        $finish;
    end

endmodule
