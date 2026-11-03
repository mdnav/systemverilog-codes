module digital_frequency_counter_display #(
    parameter WINDOW_CYCLES = 100
)(
    input wire clk,
    input wire reset,
    input wire pulse_in,
    output reg [7:0] frequency_count,
    output wire [6:0] tens_display,
    output wire [6:0] ones_display
);

    reg [31:0] window_count;
    reg [7:0] pulse_count;
    reg pulse_prev;

    wire pulse_rise;
    assign pulse_rise = pulse_in & ~pulse_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            window_count   <= 0;
            pulse_count    <= 0;
            pulse_prev     <= 0;
            frequency_count <= 0;
        end else begin
            pulse_prev <= pulse_in;

            if (pulse_rise && pulse_count < 99)
                pulse_count <= pulse_count + 1'b1;

            if (window_count == WINDOW_CYCLES - 1) begin
                window_count <= 0;

                if (pulse_rise && pulse_count < 99)
                    frequency_count <= pulse_count + 1'b1;
                else
                    frequency_count <= pulse_count;

                pulse_count <= 0;
            end else begin
                window_count <= window_count + 1'b1;
            end
        end
    end

    reg [3:0] tens;
    reg [3:0] ones;

    always @(*) begin
        tens = frequency_count / 10;
        ones = frequency_count % 10;
    end

    // Active-low seven-segment outputs:
    // bit order = {a,b,c,d,e,f,g}
    function [6:0] seven_segment;
        input [3:0] digit;
        begin
            case (digit)
                4'd0: seven_segment = 7'b0000001;
                4'd1: seven_segment = 7'b1001111;
                4'd2: seven_segment = 7'b0010010;
                4'd3: seven_segment = 7'b0000110;
                4'd4: seven_segment = 7'b1001100;
                4'd5: seven_segment = 7'b0100100;
                4'd6: seven_segment = 7'b0100000;
                4'd7: seven_segment = 7'b0001111;
                4'd8: seven_segment = 7'b0000000;
                4'd9: seven_segment = 7'b0000100;
                default: seven_segment = 7'b1111111;
            endcase
        end
    endfunction

    assign tens_display = seven_segment(tens);
    assign ones_display = seven_segment(ones);

endmodule
