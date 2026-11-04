`timescale 1ns/1ps

module tb_programmable_mod_n_counter;

    reg clk;
    reg reset;
    reg enable;
    reg direction;
    reg [7:0] mod_value;

    wire [7:0] count;

    programmable_mod_n_counter #(
        .WIDTH(8)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .direction(direction),
        .mod_value(mod_value),
        .count(count)
    );

    always #5 clk = ~clk;

    task clock_cycle;
        begin
            @(negedge clk);
            #1;
            $display("Time=%0t | Direction=%s | Count=%0d",
                     $time, direction ? "UP" : "DOWN", count);
        end
    endtask

    integer i;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        direction = 1;
        mod_value = 5;

        repeat (2) @(negedge clk);
        reset = 0;
        enable = 1;

        $display("--- UP COUNTING: MOD-5 ---");
        for (i = 0; i < 7; i = i + 1)
            clock_cycle();

        if (count == 2)
            $display("TEST PASSED: Up counter");

        // Reset before testing down counting
        @(negedge clk);
        reset = 1;
        @(negedge clk);
        reset = 0;

        direction = 0;

        $display("--- DOWN COUNTING: MOD-5 ---");
        for (i = 0; i < 7; i = i + 1)
            clock_cycle();

        $display("TEST COMPLETED");
        $finish;
    end

endmodule
