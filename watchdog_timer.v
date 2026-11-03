module watchdog_timer #(
    parameter TIMEOUT_CYCLES = 10
)(
    input wire clk,
    input wire reset,
    input wire kick,
    output reg timeout
);

    reg [31:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            timeout <= 0;
        end else begin
            if (kick) begin
                counter <= 0;
                timeout <= 0;
            end else if (!timeout) begin
                if (counter >= TIMEOUT_CYCLES - 1) begin
                    timeout <= 1;
                end else begin
                    counter <= counter + 1'b1;
                end
            end
        end
    end

endmodule
