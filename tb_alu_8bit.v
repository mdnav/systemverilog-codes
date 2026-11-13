`timescale 1ns/1ps

module tb_alu_8bit;

    reg [7:0] A, B;
    reg [2:0] sel;

    wire [7:0] result;
    wire zero;

    alu_8bit uut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result),
        .zero(zero)
    );

    initial begin

        $monitor(
            "Time=%0t | A=%d | B=%d | SEL=%b | Result=%d | Zero=%b",
            $time, A, B, sel, result, zero
        );

        A = 8'd20;
        B = 8'd10;

        // Addition
        sel = 3'b000;
        #10;
        if (result == 30)
            $display("TEST 1 PASSED");

        // Subtraction
        sel = 3'b001;
        #10;
        if (result == 10)
            $display("TEST 2 PASSED");

        // AND
        sel = 3'b010;
        #10;
        if (result == (A & B))
            $display("TEST 3 PASSED");

        // OR
        sel = 3'b011;
        #10;
        if (result == (A | B))
            $display("TEST 4 PASSED");

        // XOR
        sel = 3'b100;
        #10;
        if (result == (A ^ B))
            $display("TEST 5 PASSED");

        // NOT
        sel = 3'b101;
        #10;
        if (result == ~A)
            $display("TEST 6 PASSED");

        // Left shift
        sel = 3'b110;
        #10;
        if (result == (A << 1))
            $display("TEST 7 PASSED");

        // Right shift
        sel = 3'b111;
        #10;
        if (result == (A >> 1))
            $display("TEST 8 PASSED");

        // Zero flag
        A = 8'd10;
        B = 8'd10;
        sel = 3'b001;
        #10;

        if (result == 0 && zero == 1)
            $display("TEST 9 PASSED");

        $display("All tests completed.");

        $finish;
    end

endmodule
