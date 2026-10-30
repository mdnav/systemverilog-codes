`timescale 1ns/1ps

module tb_baud_rate_generator;

    reg CLK;
    reg RESET;
    wire BAUD_TICK;

    integer tick_count;

    baud_rate_generator #(
        .CLK_FREQ(1000),
        .BAUD_RATE(100)
    ) uut (
        .CLK(CLK),
        .RESET(RESET),
        .BAUD_TICK(BAUD_TICK)
    );

    // Clock period = 10 ns
    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RESET = 1;
        tick_count = 0;

        // Apply reset
        #12;
        RESET = 0;

        // Run simulation
        repeat (50) @(posedge CLK);

        #1;
        $display("Total baud ticks observed: %0d", tick_count);
        $finish;
    end

    always @(posedge CLK) begin
        if (BAUD_TICK) begin
            tick_count = tick_count + 1;
            $display("Time=%0t ns | BAUD_TICK=%b",
                     $time, BAUD_TICK);
        end
    end

endmodule
