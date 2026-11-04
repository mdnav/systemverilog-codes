module programmable_pulse_generator #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [WIDTH-1:0] period,
    input wire [WIDTH-1:0] pulse_width,
    output reg pulse_out
);

    reg [WIDTH-1:0] period_count;
    reg [WIDTH-1:0] width_count;
    reg pulse_active;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            period_count <= 0;
            width_count  <= 0;
            pulse_active <= 0;
            pulse_out    <= 0;
        end else if (!enable || period == 0 || pulse_width == 0) begin
            period_count <= 0;
            width_count  <= 0;
            pulse_active <= 0;
            pulse_out    <= 0;
        end else begin
            if (!pulse_active) begin
                if (period_count >= period - 1'b1) begin
                    period_count <= 0;
                    pulse_active <= 1;
                    pulse_out    <= 1;
                    width_count  <= 1;
                end else begin
                    period_count <= period_count + 1'b1;
                end
            end else begin
                if (width_count >= pulse_width) begin
                    pulse_out    <= 0;
                    pulse_active <= 0;
                    width_count  <= 0;
                end else begin
                    width_count <= width_count + 1'b1;
                end
            end
        end
    end

endmodule
