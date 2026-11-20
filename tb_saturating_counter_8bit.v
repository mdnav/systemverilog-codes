
`timescale 1ns/1ps

module tb_saturating_counter_8bit;

    reg clk;
    reg reset;
    reg enable;
    reg direction;

    wire [7:0] count;
    wire max_reached;
    wire min_reached;

    integer i;

    saturating_counter_8bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .direction(direction),
        .count(count),
        .max_reached(max_reached),
        .min_reached(min_reached)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        enable = 0;
        direction = 1;

        $display("Time\tReset\tEnable\tDirection\tCount\tMax\tMin");

        // Apply reset
        reset = 1;
        #10;
        reset = 0;

        // Count upward to maximum
        enable = 1;
        direction = 1;

        for (i = 0; i < 260; i = i + 1) begin
            @(posedge clk);
            #1;
        end

        $display("Maximum reached: Count=%d, Max=%b",
                 count, max_reached);

        // Count downward to minimum
        direction = 0;

        for (i = 0; i < 260; i = i + 1) begin
            @(posedge clk);
            #1;
        end

        $display("Minimum reached: Count=%d, Min=%b",
                 count, min_reached);

        // Verify counter holds when disabled
        enable = 0;
        repeat (5) begin
            @(posedge clk);
            #1;
        end

        $display("Counter disabled: Count=%d", count);

        // Reset test
        reset = 1;
        #1;
        $display("After reset: Count=%d", count);

        reset = 0;
        enable = 1;
        direction = 1;

        repeat (5) begin
            @(posedge clk);
            #1;
        end

        $display("After 5 upward counts: Count=%d", count);

        $display("Testbench completed.");
        $finish;
    end

endmodule
