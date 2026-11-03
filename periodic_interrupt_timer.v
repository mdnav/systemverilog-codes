module periodic_interrupt_timer #(
    parameter PERIOD = 10
)(
    input wire clk,
    input wire reset,
    input wire enable,
    output reg interrupt
);

    reg [31:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter   <= 0;
            interrupt <= 0;
        end else if (!enable) begin
            counter   <= 0;
            interrupt <= 0;
        end else begin
            if (counter == PERIOD - 1) begin
                counter   <= 0;
                interrupt <= 1;
            end else begin
                counter   <= counter + 1'b1;
                interrupt <= 0;
            end
        end
    end

endmodule
