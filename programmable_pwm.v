`timescale 1ns/1ps

module programmable_pwm #(
    parameter PERIOD = 100
)(
    input CLK,
    input RESET,
    input [6:0] DUTY_CYCLE,
    output reg PWM_OUT
);

    reg [31:0] counter;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            counter <= 0;
            PWM_OUT <= 0;
        end
        else begin
            if (counter >= PERIOD - 1)
                counter <= 0;
            else
                counter <= counter + 1;

            if (DUTY_CYCLE >= 100)
                PWM_OUT <= 1'b1;
            else if (DUTY_CYCLE == 0)
                PWM_OUT <= 1'b0;
            else
                PWM_OUT <= (counter < (PERIOD * DUTY_CYCLE / 100));
        end
    end

endmodule
