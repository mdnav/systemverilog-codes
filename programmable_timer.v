module programmable_timer #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire start,
    input wire stop,
    input wire [WIDTH-1:0] load_value,
    output reg [WIDTH-1:0] count,
    output reg done
);

    reg running;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count   <= 0;
            done    <= 0;
            running <= 0;
        end else begin
            if (start && !running) begin
                count   <= load_value;
                done    <= 0;
                running <= (load_value != 0);
                if (load_value == 0)
                    done <= 1;
            end else if (stop) begin
                running <= 0;
            end else if (running) begin
                if (count > 1) begin
                    count <= count - 1'b1;
                end else begin
                    count   <= 0;
                    done    <= 1;
                    running <= 0;
                end
            end
        end
    end

endmodule
