`timescale 1ns / 1ps

module decade_counter_tb;
    reg x;
    reg clk;
    reg rst;
    wire [3:0] z;

    decade_counter uut (
        .x(x),
        .clk(clk),
        .rst(rst),
        .z(z)
    );

    initial begin
        x = 1'b0;
        rst = 1'b0;
        clk = 1'b0;
    end

    always #16 clk = ~clk;
    always #32 x = ~x;
    always #900 rst = ~rst;

    initial begin
        #1024;
        $finish;
    end

endmodule


