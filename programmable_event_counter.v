module programmable_event_counter #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire event_in,
    input wire [WIDTH-1:0] threshold,
    output reg [WIDTH-1:0] count,
    output reg alert
);

    reg event_prev;
    wire event_rise = event_in & ~event_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count      <= 0;
            alert      <= 0;
            event_prev <= 0;
        end else begin
            event_prev <= event_in;

            if (enable && event_rise) begin
                if (count < threshold) begin
                    count <= count + 1'b1;

                    if (count + 1'b1 >= threshold)
                        alert <= 1'b1;
                end
            end
        end
    end

endmodule
