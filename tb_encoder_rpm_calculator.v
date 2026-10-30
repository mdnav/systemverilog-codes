`timescale 1ns/1ps

module tb_encoder_rpm_calculator;

    reg CLK;
    reg RESET;
    reg ENCODER_A;

    wire [31:0] RPM;

    encoder_rpm_calculator #(
        .CLK_FREQ(1000000),
        .PULSES_PER_REV(20),
        .MEASURE_TIME(1000)
    ) uut (
        .CLK(CLK),
        .RESET(RESET),
        .ENCODER_A(ENCODER_A),
        .RPM(RPM)
    );

    always #500 CLK = ~CLK; // 1 MHz clock

    initial begin
        CLK = 0;
        RESET = 1;
        ENCODER_A = 0;

        #5000 RESET = 0;

        // Generate encoder pulses
        repeat (10) begin
            #10000 ENCODER_A = 1;
            #10000 ENCODER_A = 0;
        end

        #2000000;
        $display("Calculated RPM = %0d", RPM);
        $finish;
    end

    initial begin
        $monitor("Time=%0t Encoder=%b RPM=%0d",
                 $time, ENCODER_A, RPM);
    end

endmodule
