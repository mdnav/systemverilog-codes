`timescale 1ns/1ps

module tb_binary_to_onehot_8bit;

    reg [7:0] binary_in;
    wire [255:0] onehot_out;

    integer i;
    integer errors;

    binary_to_onehot_8bit uut (
        .binary_in(binary_in),
        .onehot_out(onehot_out)
    );

    task check_result;
        input [7:0] test_input;
        begin
            binary_in = test_input;
            #10;

            if (onehot_out[test_input] === 1'b1 &&
                onehot_out === (256'b1 << test_input)) begin

                $display("PASS | Input=%0d | Active output bit=%0d",
                         test_input, test_input);

            end else begin

                $display("FAIL | Input=%0d | Output incorrect",
                         test_input);

                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        $display("===== 8-BIT BINARY TO ONE-HOT TEST =====");

        check_result(8'd0);
        check_result(8'd1);
        check_result(8'd5);
        check_result(8'd10);
        check_result(8'd25);
        check_result(8'd100);
        check_result(8'd128);
        check_result(8'd255);

        // Exhaustive verification of all 256 inputs
        for (i = 0; i < 256; i = i + 1) begin
            binary_in = i;
            #1;

            if (onehot_out !== (256'b1 << i))
                errors = errors + 1;
        end

        $display("---------------------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED: %0d errors", errors);

        $finish;
    end

endmodule
