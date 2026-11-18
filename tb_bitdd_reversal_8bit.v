`timescale 1ns/1ps

module tb_bit_reversal_8bit;

    reg [7:0] data_in;
    wire [7:0] data_out;

    integer i;
    integer errors;

    bit_reversal_8bit uut (
        .data_in(data_in),
        .data_out(data_out)
    );

    task check_result;
        input [7:0] test_input;
        input [7:0] expected_output;
        begin
            data_in = test_input;
            #10;

            if (data_out === expected_output) begin
                $display("PASS | Input=%b | Output=%b",
                         data_in, data_out);
            end else begin
                $display("FAIL | Input=%b | Expected=%b | Got=%b",
                         data_in, expected_output, data_out);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        data_in = 8'b00000000;

        $display("====================================");
        $display("      8-BIT BIT REVERSAL TEST");
        $display("====================================");

        // Test 1: All zeros
        check_result(8'b00000000, 8'b00000000);

        // Test 2: All ones
        check_result(8'b11111111, 8'b11111111);

        // Test 3: Alternating bits
        check_result(8'b10101010, 8'b01010101);

        // Test 4: Reverse alternating bits
        check_result(8'b01010101, 8'b10101010);

        // Test 5: Single MSB
        check_result(8'b10000000, 8'b00000001);

        // Test 6: Single LSB
        check_result(8'b00000001, 8'b10000000);

        // Test 7: Random pattern
        check_result(8'b11010010, 8'b01001011);

        // Test 8: Another pattern
        check_result(8'b11100001, 8'b10000111);

        // Exhaustive verification: all 256 inputs
        for (i = 0; i < 256; i = i + 1) begin
            data_in = i;
            #1;

            if (data_out !== {
                data_in[0], data_in[1],
                data_in[2], data_in[3],
                data_in[4], data_in[5],
                data_in[6], data_in[7]
            }) begin
                errors = errors + 1;
                $display("FAIL at input %b", data_in);
            end
        end

        $display("====================================");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED: %0d errors", errors);

        $display("====================================");

        $finish;
    end

endmodule
