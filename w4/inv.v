`timescale 1ns / 1ps

module inv(
input a, b, c, d,
output e, f, g
    );

// NAND
//assign e = ~(a&b);
//assign f = ~(e&c);
//assign g = ~(f&d);

//NOR
//assign e = ~(a|b);
//assign f = ~(e|c);     
//assign g = ~(f|d);

// XOR
// assign e = a^b;
// assign f = e^c;
// assign g = f^d;

// AOI
assign e = a&b;
assign f = c&d;
assign g = ~(f|d);

endmodule
