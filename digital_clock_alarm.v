module digital_clock_alarm(
    input wire clk,
    input wire reset,
    input wire alarm_enable,
    input wire [4:0] alarm_hour,
    input wire [5:0] alarm_minute,
    output reg [4:0] hours,
    output reg [5:0] minutes,
    output reg [5:0] seconds,
    output reg alarm
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hours   <= 0;
            minutes <= 0;
            seconds <= 0;
            alarm   <= 0;
        end else begin

            // Clock counting
            if (seconds == 59) begin
                seconds <= 0;

                if (minutes == 59) begin
                    minutes <= 0;

                    if (hours == 23)
                        hours <= 0;
                    else
                        hours <= hours + 1'b1;

                end else begin
                    minutes <= minutes + 1'b1;
                end

            end else begin
                seconds <= seconds + 1'b1;
            end

            // Alarm detection
            if (alarm_enable &&
                hours == alarm_hour &&
                minutes == alarm_minute &&
                seconds == 0)
                alarm <= 1'b1;
            else
                alarm <= 1'b0;

        end
    end

endmodule
