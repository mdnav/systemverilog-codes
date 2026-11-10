`timescale 1ns/1ps

module tb_population_counter;

    reg [7:0] data_in;
    wire [3:0] count;

    population_counter uut (
        .data_in(data_in),
        .count(count)
    );

    initial begin

        $monitor(
            "Time=%0t | Input=%b | Number of Ones=%0d",
            $time, data_in, count
        );

        // Test 1: No HIGH bits
        data_in = 8'b00000000;
        #10;
        if (count == 0)
            $display("TEST 1 PASSED");

        // Test 2: One HIGH bit
        data_in = 8'b00000001;
        #10;
        if (count == 1)
            $display("TEST 2 PASSED");

        // Test 3: Four HIGH bits
        data_in = 8'b10101010;
        #10;
        if (count == 4)
            $display("TEST 3 PASSED");

        // Test 4: Six HIGH bits
        data_in = 8'b11110011;
        #10;
        if (count == 6)
            $display("TEST 4 PASSED");

        // Test 5: All bits HIGH
        data_in = 8'b11111111;
        #10;
        if (count == 8)
            $display("TEST 5 PASSED");

        $display("All tests completed.");

        $finish;
    end

endmodule
