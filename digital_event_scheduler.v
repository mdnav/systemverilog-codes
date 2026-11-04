module digital_event_scheduler #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire start,
    input wire [WIDTH-1:0] delay_value,
    output reg trigger,
    output reg busy
);

    reg [WIDTH-1:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            trigger <= 0;
            busy    <= 0;
        end else begin
            trigger <= 0;

            if (start && !busy) begin
                if (delay_value == 0) begin
                    trigger <= 1;
                    busy    <= 0;
                    counter <= 0;
                end else begin
                    counter <= delay_value;
                    busy    <= 1;
                end
            end else if (busy) begin
                if (counter == 1) begin
                    counter <= 0;
                    trigger <= 1;
                    busy    <= 0;
                end else begin
                    counter <= counter - 1'b1;
                end
            end
        end
    end

endmodule
