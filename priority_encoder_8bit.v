module priority_encoder_8bit(
    input wire [7:0] D,
    output reg [2:0] Y,
    output reg valid
);

    always @(*) begin
        Y = 3'b000;
        valid = 1'b0;

        casex (D)
            8'b1xxxxxxx: begin
                Y = 3'b111;
                valid = 1'b1;
            end

            8'b01xxxxxx: begin
                Y = 3'b110;
                valid = 1'b1;
            end

            8'b001xxxxx: begin
                Y = 3'b101;
                valid = 1'b1;
            end

            8'b0001xxxx: begin
                Y = 3'b100;
                valid = 1'b1;
            end

            8'b00001xxx: begin
                Y = 3'b011;
                valid = 1'b1;
            end

            8'b000001xx: begin
                Y = 3'b010;
                valid = 1'b1;
            end

            8'b0000001x: begin
                Y = 3'b001;
                valid = 1'b1;
            end

            8'b00000001: begin
                Y = 3'b000;
                valid = 1'b1;
            end

            default: begin
                Y = 3'b000;
                valid = 1'b0;
            end
        endcase
    end

endmodule
