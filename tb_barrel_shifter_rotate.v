`timescale 1ns/1ps

module tb_barrel_shifter_rotate;

    reg [7:0] data_in;
    reg [2:0] shift_amount;
    reg [1:0] operation;

    wire [7:0] data_out;

    barrel_shifter_rotate uut (
        .data_in(data_in),
        .shift_amount(shift_amount),
        .operation(operation),
        .data_out(data_out)
    );

    initial begin

        $monitor(
            "Time=%0t | Input=%b | Shift=%0d | Operation=%b | Output=%b",
            $time, data_in, shift_amount, operation, data_out
        );

        data_in = 8'b10110010;
        shift_amount = 2;

        // Logical left shift
        operation = 2'b00;
        #10;
        if (data_out == 8'b11001000)
            $display("TEST 1 PASSED");

        // Logical right shift
        operation = 2'b01;
        #10;
        if (data_out == 8'b00101100)
            $display("TEST 2 PASSED");

        // Rotate left
        operation = 2'b10;
        #10;
        if (data_out == 8'b11001010)
            $display("TEST 3 PASSED");

        // Rotate right
        operation = 2'b11;
        #10;
        if (data_out == 8'b10101100)
            $display("TEST 4 PASSED");

        // Shift by zero
        shift_amount = 0;
        operation = 2'b10;
        #10;
        if (data_out == data_in)
            $display("TEST 5 PASSED");

        $display("All tests completed.");
        $finish;

    end

endmodule
