module pulse_counter_prescaler #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire pulse_in,
    input wire [WIDTH-1:0] prescaler,
    output reg [WIDTH-1:0] count
);

    reg pulse_prev;
    reg [WIDTH-1:0] prescale_count;

    wire pulse_rise = pulse_in & ~pulse_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pulse_prev     <= 0;
            prescale_count <= 0;
            count          <= 0;
        end else begin
            pulse_prev <= pulse_in;

            if (!enable) begin
                prescale_count <= 0;
            end else if (pulse_rise) begin
                if (prescaler <= 1) begin
                    count <= count + 1'b1;
                end else if (prescale_count >= prescaler - 1'b1) begin
                    prescale_count <= 0;
                    count <= count + 1'b1;
                end else begin
                    prescale_count <= prescale_count + 1'b1;
                end
            end
        end
    end

endmodule
