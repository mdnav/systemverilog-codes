
`timescale 1ns/1ps

module pwm_duty_cycle_measurement #(
    parameter WINDOW_CYCLES = 100
)(
    input CLK,
    input RESET,
    input PWM_IN,
    output reg [6:0] DUTY_PERCENT,
    output reg MEASURE_VALID
);

    reg [31:0] sample_count;
    reg [31:0] high_count;
    reg [31:0] total_high;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            sample_count <= 0;
            high_count <= 0;
            total_high <= 0;
            DUTY_PERCENT <= 0;
            MEASURE_VALID <= 0;
        end
        else begin
            MEASURE_VALID <= 0;

            if (sample_count == WINDOW_CYCLES - 1) begin
                total_high = high_count + PWM_IN;

                DUTY_PERCENT <=
                    (total_high * 100) / WINDOW_CYCLES;

                sample_count <= 0;
                high_count <= 0;
                MEASURE_VALID <= 1;
            end
            else begin
                sample_count <= sample_count + 1;

                if (PWM_IN)
                    high_count <= high_count + 1;
            end
        end
    end

endmodule
