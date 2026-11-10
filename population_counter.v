module population_counter(
    input wire [7:0] data_in,
    output reg [3:0] count
);

    integer i;

    always @(*) begin
        count = 0;

        for (i = 0; i < 8; i = i + 1) begin
            if (data_in[i] == 1'b1)
                count = count + 1'b1;
        end
    end

endmodule
