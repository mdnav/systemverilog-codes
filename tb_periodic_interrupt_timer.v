`timescale 1ns/1ps

module tb_periodic_interrupt_timer;

    reg clk;
    reg reset;
    reg enable;
    wire interrupt;

    periodic_interrupt_timer #(
        .PERIOD(5)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .interrupt(interrupt)
    );

    always #5 clk = ~clk;

    integer interrupt_count;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        interrupt_count = 0;

        $monitor("Time=%0t | Enable=%b | Interrupt=%b",
                 $time, enable, interrupt);

        repeat (2) @(negedge clk);
        reset = 0;
        enable = 1;

        repeat (20) begin
            @(negedge clk);
            if (interrupt)
                interrupt_count = interrupt_count + 1;
        end

        $display("Total interrupts detected: %0d",
                 interrupt_count);

        if (interrupt_count >= 3)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        enable = 0;
        @(negedge clk);

        $finish;
    end

endmodule
