module crc8_generator(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire data_in,
    output reg [7:0] crc
);

    wire feedback;

    assign feedback = crc[7] ^ data_in;

    always @(posedge clk or posedge reset) begin
        if (reset)
            crc <= 8'h00;
        else if (enable) begin
            crc <= {crc[6:0], 1'b0} ^
                   (feedback ? 8'h07 : 8'h00);
        end
    end

endmodule
