`timescale 1ns/1ps

module tb_crc8_generator;

    reg clk;
    reg reset;
    reg enable;
    reg data_in;

    wire [7:0] crc;

    crc8_generator uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .data_in(data_in),
        .crc(crc)
    );

    always #5 clk = ~clk;

    integer i;

    task send_byte;
        input [7:0] data;
        begin
            for (i = 7; i >= 0; i = i - 1) begin
                @(negedge clk);
                data_in = data[i];
                enable = 1;

                @(negedge clk);
                enable = 0;
            end
        end
    endtask

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        data_in = 0;

        $display("CRC-8 Generator Test");

        // Apply reset
        repeat (2) @(negedge clk);
        reset = 0;

        // Send ASCII string: 123456789
        send_byte(8'h31);
        send_byte(8'h32);
        send_byte(8'h33);
        send_byte(8'h34);
        send_byte(8'h35);
        send_byte(8'h36);
        send_byte(8'h37);
        send_byte(8'h38);
        send_byte(8'h39);

        #1;

        $display("Calculated CRC = %02h", crc);

        if (crc == 8'hF4)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        $finish;
    end

endmodule
