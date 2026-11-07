`timescale 1ns/1ps

module tb_leading_zero_detector;

    reg [7:0] data_in;

    wire [3:0] leading_zeros;
    wire zero_flag;

    leading_zero_detector uut (
        .data_in(data_in),
        .leading_zeros(leading_zeros),
        .zero_flag(zero_flag)
    );

    initial begin

        $monitor(
            "Time=%0t | Input=%b | Leading Zeros=%0d | Zero Flag=%b",
            $time, data_in, leading_zeros, zero_flag
        );

        // Test 1
        data_in = 8'b10000000;
        #10;
        if (leading_zeros == 0 && zero_flag == 0)
            $display("TEST 1 PASSED");

        // Test 2
        data_in = 8'b01000000;
        #10;
        if (leading_zeros == 1 && zero_flag == 0)
            $display("TEST 2 PASSED");

        // Test 3
        data_in = 8'b00100000;
        #10;
        if (leading_zeros == 2 && zero_flag == 0)
            $display("TEST 3 PASSED");

        // Test 4
        data_in = 8'b00001000;
        #10;
        if (leading_zeros == 4 && zero_flag == 0)
            $display("TEST 4 PASSED");

        // Test 5
        data_in = 8'b00000001;
        #10;
        if (leading_zeros == 7 && zero_flag == 0)
            $display("TEST 5 PASSED");

        // Test 6: All zeros
        data_in = 8'b00000000;
        #10;
        if (leading_zeros == 8 && zero_flag == 1)
            $display("TEST 6 PASSED");

        $display("All tests completed.");

        $finish;
    end

endmodule
