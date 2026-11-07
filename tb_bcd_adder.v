`timescale 1ns/1ps

module tb_bcd_adder;

    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    wire [3:0] Sum;
    wire Cout;

    bcd_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $monitor(
            "Time=%0t | A=%d | B=%d | Cin=%b | Sum=%d | Cout=%b",
            $time, A, B, Cin, Sum, Cout
        );

        // Test 1: 5 + 3 = 8
        A = 4'd5;
        B = 4'd3;
        Cin = 0;
        #10;

        if (Sum == 8 && Cout == 0)
            $display("TEST 1 PASSED");
        else
            $display("TEST 1 FAILED");

        // Test 2: 5 + 7 = 12
        A = 4'd5;
        B = 4'd7;
        Cin = 0;
        #10;

        if (Sum == 2 && Cout == 1)
            $display("TEST 2 PASSED");
        else
            $display("TEST 2 FAILED");

        // Test 3: 9 + 8 = 17
        A = 4'd9;
        B = 4'd8;
        Cin = 0;
        #10;

        if (Sum == 7 && Cout == 1)
            $display("TEST 3 PASSED");
        else
            $display("TEST 3 FAILED");

        // Test 4: 9 + 9 + 1 = 19
        A = 4'd9;
        B = 4'd9;
        Cin = 1;
        #10;

        if (Sum == 9 && Cout == 1)
            $display("TEST 4 PASSED");
        else
            $display("TEST 4 FAILED");

        $display("All tests completed.");
        $finish;
    end

endmodule
