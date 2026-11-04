module programmable_mod_n_counter #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire direction,  // 1 = Up, 0 = Down
    input wire [WIDTH-1:0] mod_value,
    output reg [WIDTH-1:0] count
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end else if (enable) begin
            if (mod_value == 0) begin
                count <= 0;
            end else if (direction) begin
                // Up counter
                if (count >= mod_value - 1'b1)
                    count <= 0;
                else
                    count <= count + 1'b1;
            end else begin
                // Down counter
                if (count == 0)
                    count <= mod_value - 1'b1;
                else if (count >= mod_value)
                    count <= mod_value - 1'b1;
                else
                    count <= count - 1'b1;
            end
        end
    end

endmodule
