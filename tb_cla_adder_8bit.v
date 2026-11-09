`timescale 1ns/1ps

module tb_cla_adder_8bit;

    reg [7:0] A;
    reg [7:0] B;
    reg Cin;

    wire [7:0] Sum;
    wire Cout;

    cla_adder_8bit uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    reg [8:0] expected;

    initial begin
        $monitor(
            "Time=%0t | A=%d | B=%d | Cin=%b | Sum=%d | Cout=%b",
            $time, A, B, Cin, Sum, Cout
        );

        // Test 1
        A = 8'd25;
        B = 8'd30;
        Cin = 0;
        #10;

        expected = A + B + Cin;
        if ({Cout, Sum} == expected)
            $display("TEST 1 PASSED");
        else
            $display("TEST 1 FAILED");

        // Test 2
        A = 8'd100;
        B = 8'd80;
        Cin = 0;
        #10;

        expected = A + B + Cin;
        if ({Cout, Sum} == expected)
            $display("TEST 2 PASSED");
        else
            $display("TEST 2 FAILED");

        // Test 3: Carry generation
        A = 8'd200;
        B = 8'd100;
        Cin = 0;
        #10;

        expected = A + B + Cin;
        if ({Cout, Sum} == expected)
            $display("TEST 3 PASSED");
        else
            $display("TEST 3 FAILED");

        // Test 4: Carry input
        A = 8'd255;
        B = 8'd0;
        Cin = 1;
        #10;

        expected = A + B + Cin;
        if ({Cout, Sum} == expected)
            $display("TEST 4 PASSED");
        else
            $display("TEST 4 FAILED");

        $display("All tests completed.");
        $finish;
    end

endmodule
