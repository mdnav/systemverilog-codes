`timescale 1ns/1ps

module tb_digital_clock_alarm;

    reg clk;
    reg reset;
    reg alarm_enable;
    reg [4:0] alarm_hour;
    reg [5:0] alarm_minute;

    wire [4:0] hours;
    wire [5:0] minutes;
    wire [5:0] seconds;
    wire alarm;

    digital_clock_alarm uut (
        .clk(clk),
        .reset(reset),
        .alarm_enable(alarm_enable),
        .alarm_hour(alarm_hour),
        .alarm_minute(alarm_minute),
        .hours(hours),
        .minutes(minutes),
        .seconds(seconds),
        .alarm(alarm)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0;
        reset = 1;
        alarm_enable = 0;
        alarm_hour = 0;
        alarm_minute = 1;

        $display("Digital Clock and Alarm Test");

        repeat (2) @(negedge clk);
        reset = 0;

        // Set the clock close to the alarm time.
        // Alarm is configured for 00:01.
        @(negedge clk);
        uut.seconds = 58;

        alarm_enable = 1;

        // Advance through 00:00:59 and 00:01:00.
        for (i = 0; i < 3; i = i + 1) begin
            @(negedge clk);
            $display("Time = %02d:%02d:%02d | Alarm = %b",
                     hours, minutes, seconds, alarm);
        end

        if (alarm == 1)
            $display("TEST PASSED: Alarm activated");
        else
            $display("TEST FAILED: Alarm not activated");

        // Verify alarm is disabled.
        alarm_enable = 0;
        @(negedge clk);

        if (alarm == 0)
            $display("TEST PASSED: Alarm disabled");

        $finish;
    end

endmodule
