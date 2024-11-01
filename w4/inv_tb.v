`timescale 1ns / 1ps
module inv_tb;
reg A, B, C, D;
wire E, F, G;
inv u_test(
.a(A),
.b(B),
.c(C),
.d(D),
.e(E),
.f(F),
.g(G)
);
initial begin
A = 1'b0;
B = 1'b0;
C = 1'b0;
D = 1'b0;
end
always@(A or B or C or D) begin
A <= #400 ~A;
B <= #200 ~B;
C <= #100 ~C;
D <= #50 ~D;
end
initial begin
#800
$finish;
end
endmodule
