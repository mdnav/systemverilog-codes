`timescale 1ns/1ps

module tb_spi_master_cpol_cpha;

    reg CLK;
    reg RESET;
    reg START;
    reg [7:0] TX_DATA;
    reg MISO;

    wire SCLK;
    wire CS;
    wire MOSI;
    wire [7:0] RX_DATA;
    wire BUSY;
    wire DONE;

    spi_master_cpol_cpha #(
        .CPOL(0),
        .CPHA(0)
    ) uut (
        .CLK(CLK),
        .RESET(RESET),
        .START(START),
        .TX_DATA(TX_DATA),
        .MISO(MISO),
        .SCLK(SCLK),
        .CS(CS),
        .MOSI(MOSI),
        .RX_DATA(RX_DATA),
        .BUSY(BUSY),
        .DONE(DONE)
    );

    always #5 CLK = ~CLK;

    // Simple SPI slave model for mode 0.
    // Present each received bit before the master's sampling edge.
    reg [7:0] slave_data;
    integer bit_index;

    always @(negedge SCLK or posedge CS) begin
        if (CS) begin
            bit_index = 7;
            MISO = 0;
        end
        else begin
            MISO = slave_data[bit_index];
            if (bit_index > 0)
                bit_index = bit_index - 1;
        end
    end

    initial begin
        CLK = 0;
        RESET = 1;
        START = 0;
        TX_DATA = 8'hA5;
        MISO = 0;
        slave_data = 8'h3C;
        bit_index = 7;

        #20;
        RESET = 0;

        @(negedge CLK);
        START = 1;

        @(negedge CLK);
        START = 0;

        wait (DONE == 1);
        #1;

        $display("Transmission completed");
        $display("TX_DATA = %h", TX_DATA);
        $display("RX_DATA = %h", RX_DATA);

        #20;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | CS=%b | SCLK=%b | MOSI=%b | MISO=%b | BUSY=%b | DONE=%b",
            $time, CS, SCLK, MOSI, MISO, BUSY, DONE
        );
    end

endmodule
