
`timescale 1ns/1ps

module tb_pwm_duty_cycle_measurement;

    reg CLK;
    reg RESET;
    reg PWM_IN;

    wire [6:0] DUTY_PERCENT;
    wire MEASURE_VALID;

    integer i;

    pwm_duty_cycle_measurement #(
        .WINDOW_CYCLES(100)
    ) uut (
        .CLK(CLK),
        .RESET(RESET),
        .PWM_IN(PWM_IN),
        .DUTY_PERCENT(DUTY_PERCENT),
        .MEASURE_VALID(MEASURE_VALID)
    );

    // Clock generation: 10 ns period
    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        PWM_IN = 0;

        // Apply reset
        #12;
        RESET = 0;

        // Generate PWM: 25 cycles HIGH, 75 cycles LOW
        for (i = 0; i < 300; i = i + 1) begin
            @(negedge CLK);

            if ((i % 100) < 25)
                PWM_IN = 1;
            else
                PWM_IN = 0;
        end

        #20;
        $finish;
    end

    // Display each completed measurement
    always @(posedge CLK) begin
        if (MEASURE_VALID)
            $display("Time=%0t ns | Duty Cycle=%0d%%",
                     $time, DUTY_PERCENT);
    end

endmodule
