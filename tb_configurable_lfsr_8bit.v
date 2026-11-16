`timescale 1ns/1ps

module tb_configurable_lfsr_8bit;

    reg clk;
    reg reset;
    reg enable;
    reg [7:0] seed;

    wire [7:0] lfsr_out;

    configurable_lfsr_8bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .seed(seed),
        .lfsr_out(lfsr_out)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        seed = 8'b10101010;

        $display("8-Bit LFSR Test");

        #12;
        reset = 0;
        enable = 1;

        $display("Initial Seed = %b", lfsr_out);

        for (i = 0; i < 15; i = i + 1) begin
            @(negedge clk);
            $display("LFSR Output = %b", lfsr_out);
        end

        enable = 0;
        @(negedge clk);

        $display("TEST COMPLETED");
        $finish;
    end

endmodule
