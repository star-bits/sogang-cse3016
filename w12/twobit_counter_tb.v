`timescale 1ns / 1ps

module binary_counter_tb;
    reg x;
    reg clk;
    reg rst;
    wire [1:0] z;

    binary_counter uut (
        .x(x),
        .clk(clk),
        .rst(rst),
        .z(z)
    );

    initial begin
        x = 1'b1;
        rst = 1'b0;
        clk = 1'b0;
    end

    always #64 clk = ~clk;
    always #900 rst = ~rst;

    initial begin
        #1000;
        $finish;
    end

endmodule

