module programmable_pwm_controller #(
    parameter PERIOD = 100
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [7:0] duty_cycle,
    output reg pwm_out
);

    reg [31:0] counter;
    reg [31:0] high_cycles;

    always @(*) begin
        high_cycles = (PERIOD * duty_cycle) / 100;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            pwm_out <= 0;
        end else if (!enable) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (counter >= PERIOD - 1)
                counter <= 0;
            else
                counter <= counter + 1'b1;

            if (counter < high_cycles)
                pwm_out <= 1;
            else
                pwm_out <= 0;
        end
    end

endmodule
