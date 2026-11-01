`timescale 1ns/1ps

module tb_programmable_pwm;

    reg CLK;
    reg RESET;
    reg [6:0] DUTY_CYCLE;

    wire PWM_OUT;

    programmable_pwm #(
        .PERIOD(100)
    ) uut (
        .CLK(CLK),
        .RESET(RESET),
        .DUTY_CYCLE(DUTY_CYCLE),
        .PWM_OUT(PWM_OUT)
    );

    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        DUTY_CYCLE = 25;

        #12;
        RESET = 0;

        // Test 25% duty cycle
        $display("Testing 25%% duty cycle");
        repeat (200) @(negedge CLK);

        // Test 50% duty cycle
        DUTY_CYCLE = 50;
        $display("Testing 50%% duty cycle");
        repeat (200) @(negedge CLK);

        // Test 75% duty cycle
        DUTY_CYCLE = 75;
        $display("Testing 75%% duty cycle");
        repeat (200) @(negedge CLK);

        // Test 0% duty cycle
        DUTY_CYCLE = 0;
        $display("Testing 0%% duty cycle");
        repeat (100) @(negedge CLK);

        // Test 100% duty cycle
        DUTY_CYCLE = 100;
        $display("Testing 100%% duty cycle");
        repeat (100) @(negedge CLK);

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | Duty=%0d%% | PWM_OUT=%b",
            $time, DUTY_CYCLE, PWM_OUT
        );
    end

endmodule
