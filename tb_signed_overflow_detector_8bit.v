
`timescale 1ns/1ps

module tb_signed_overflow_detector_8bit;

    reg [7:0] A, B;
    reg subtract;

    wire [7:0] result;
    wire overflow;

    signed_overflow_detector_8bit uut (
        .A(A),
        .B(B),
        .subtract(subtract),
        .result(result),
        .overflow(overflow)
    );

    initial begin
        $display("Operation\tA\tB\tResult\tOverflow");

        // Test 1: Positive addition without overflow
        A = 8'd20;
        B = 8'd30;
        subtract = 0;
        #10;
        $display("Addition\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 2: Positive addition with overflow
        A = 8'd100;
        B = 8'd50;
        subtract = 0;
        #10;
        $display("Addition\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 3: Negative addition without overflow
        A = -8'sd20;
        B = -8'sd30;
        subtract = 0;
        #10;
        $display("Addition\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 4: Negative addition with overflow
        A = -8'sd100;
        B = -8'sd50;
        subtract = 0;
        #10;
        $display("Addition\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 5: Subtraction without overflow
        A = 8'd50;
        B = 8'd100;
        subtract = 1;
        #10;
        $display("Subtraction\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 6: Subtraction with positive overflow
        A = 8'd100;
        B = -8'sd50;
        subtract = 1;
        #10;
        $display("Subtraction\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 7: Subtraction with negative overflow
        A = -8'sd100;
        B = 8'd50;
        subtract = 1;
        #10;
        $display("Subtraction\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        // Test 8: Boundary case -128
        A = -8'sd128;
        B = 8'd0;
        subtract = 0;
        #10;
        $display("Addition\t%d\t%d\t%d\t%b",
                 $signed(A), $signed(B),
                 $signed(result), overflow);

        $display("Testbench completed.");
        $finish;
    end

endmodule
