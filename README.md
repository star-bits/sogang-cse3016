# 컴퓨터공학실험II (컴실2)

## 1주차 + 2주차

- 'Vivado 2017.3' 프로그램을 실행. ('Vivado HLS 2017.3' 프로그램이 아니라.)
- 새로 RTL Project를 만들고, `inv.v` 파일을 만들고, Default Part로 `xc7a75tfgg484-1`를 추가함.
- Sources 창의 Design Sources 아래 inv 파일 확인.
- Flow Navigator 창의 Project Manager 아래의 Add Sources를 클릭하고 simulation source를 선택함. 이름은 `inv_tb.v`.
- Sources 창의 Simulation Sources 아래 inv_tb 파일 확인.
- Flow Navigator 창의 Simulation - Run Simulation - Run Behavioral Simulation 클릭.

## 4주차
- [inv.v](https://github.com/star-bits/sogang-cse3016/blob/main/w4/inv.v)
- [inv_tb.v](https://github.com/star-bits/sogang-cse3016/blob/main/w4/inv_tb.v)
- [inv.xdc](https://github.com/star-bits/sogang-cse3016/blob/main/w4/inv.xdc)
- RTL ANALYSIS - Open Elaborated Design - Window - I/O Ports
- Run Synthesis
- Run Implementation
- Generate Bitstream - Open Target - Auto Connect - Program Device - Program

## 10주차

BCD design code
```verilog
`timescale 1ns / 1ps

module inv(a, b, cin, sum, dout);
input [3:0] a, b;
input cin;          
output [3:0] sum;
output dout;

wire [3:0] s;               
wire c1, c2, c3, cout;
assign s[0] = a[0] ^ b[0] ^ cin;                    
assign c1 = (a[0] & b[0]) | (a[0] & cin) | (b[0] & cin); 
assign s[1] = a[1] ^ b[1] ^ c1;                      
assign c2 = (a[1] & b[1]) | (a[1] & c1) | (b[1] & c1); 
assign s[2] = a[2] ^ b[2] ^ c2;                    
assign c3 = (a[2] & b[2]) | (a[2] & c2) | (b[2] & c2);  
assign s[3] = a[3] ^ b[3] ^ c3;                      
assign cout = (a[3] & b[3]) | (a[3] & c3) | (b[3] & c3);

wire oc;
assign oc = (cout | (s[3] & s[2]) | (s[3] & s[1]));

wire [3:0] o = {1'b0, oc, oc, 1'b0};
wire d1, d2, d3;
assign sum[0] = o[0] ^ s[0] ^ 0;                    
assign d1 = (o[0] & s[0]) | (o[0] & 0) | (s[0] & 0); 
assign sum[1] = o[1] ^ s[1] ^ d1;                      
assign d2 = (o[1] & s[1]) | (o[1] & d1) | (s[1] & d1); 
assign sum[2] = o[2] ^ s[2] ^ d2;                    
assign d3 = (o[2] & s[2]) | (o[2] & d2) | (s[2] & d2);  
assign sum[3] = o[3] ^ s[3] ^ d3;                      
assign dout = oc;   

endmodule
```

BCD testbench code
```verilog
`timescale 1ns / 1ps

module inv_tb;
reg [3:0] a, b;
reg cin;
wire [3:0] sum;
wire dout;

inv u_test(a, b, cin, sum, dout);

initial begin
a = 4'D0;
b = 4'D0;
cin = 1'b0;
end

always@(a or b or cin) begin
a <= #10 a+4'D1;
b <= #20 a-4'D1;
cin <= #30 ~cin;
end

initial begin
#1000
$finish;
end

endmodule
```
