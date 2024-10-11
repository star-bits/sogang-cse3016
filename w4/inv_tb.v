`timescale 1ns / 1ps
module inv_tb;
reg aa, bb, cc, dd;
wire ee, ff, gg;
inv u_test(
.a(aa),
.b(bb),
.c(cc),
.d(dd),
.e(ee),
.f(ff),
.g(gg)
);
initial begin
aa = 1'b0;
bb = 1'b0;
cc = 1'b0;
dd = 1'b0;
end
always@(aa or bb or cc or dd) begin
aa <= #400 ~aa;
bb <= #200 ~bb;
cc <= #100 ~cc;
dd <= #50 ~dd;
end
initial begin
#1000
$finish;
end
endmodule
