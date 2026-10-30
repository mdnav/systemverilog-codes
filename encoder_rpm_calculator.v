module encoder_rpm_calculator #(
    parameter CLK_FREQ = 1000000,
    parameter PULSES_PER_REV = 20,
    parameter MEASURE_TIME = 1000
)(
    input CLK,
    input RESET,
    input ENCODER_A,
    output reg [31:0] RPM
);

    reg encoder_prev;
    reg [31:0] pulse_count;
    reg [31:0] timer_count;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            encoder_prev <= 1'b0;
            pulse_count  <= 0;
            timer_count  <= 0;
            RPM          <= 0;
        end
        else begin
            encoder_prev <= ENCODER_A;

            // Count rising edges from the encoder
            if (ENCODER_A && !encoder_prev)
                pulse_count <= pulse_count + 1'b1;

            // Measure speed over a fixed interval
            if (timer_count == MEASURE_TIME - 1) begin
                RPM <= (pulse_count * 60) /
                       (PULSES_PER_REV * MEASURE_TIME / 1000);

                pulse_count <= 0;
                timer_count <= 0;
            end
            else begin
                timer_count <= timer_count + 1'b1;
            end
        end
    end

endmodule
