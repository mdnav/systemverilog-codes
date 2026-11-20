
module saturating_counter_8bit (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire direction,  // 1 = Up, 0 = Down
    output reg [7:0] count,
    output wire max_reached,
    output wire min_reached
);

    assign max_reached = (count == 8'd255);
    assign min_reached = (count == 8'd0);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 8'd0;
        end
        else if (enable) begin
            if (direction) begin
                if (count < 8'd255)
                    count <= count + 1'b1;
            end
            else begin
                if (count > 8'd0)
                    count <= count - 1'b1;
            end
        end
    end

endmodule
