
`timescale 1ns/1ps

module tb_digital_frequency_synthesizer;

    reg CLK;
    reg RESET;
    wire OUT_CLK;

    // Instantiate the design
    digital_frequency_synthesizer #(
        .DIVISOR(4)
    ) uut (
        .CLK(CLK),
        .RESET(RESET),
        .OUT_CLK(OUT_CLK)
    );

    // Generate 10 ns input clock
    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;

        // Apply reset
        #12;
        RESET = 0;

        // Run simulation
        #200;
        $finish;
    end

    // Display signal values
    initial begin
        $monitor("Time=%0t ns | CLK=%b | OUT_CLK=%b",
                 $time, CLK, OUT_CLK);
    end

endmodule
