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

## 11주차

RS Flip-Flop `inv.v`
```verilog
`timescale 1ns / 1ps

module inv(
input r, s, clk,
output q, nq
);

// NOR
// assign q = ~((c & clk) | nq);
// assign nq = ~((s & clk) | q);

// NAND
assign q = ~(~(r & clk) & nq);
assign nq = ~(~(s & clk) & q);

endmodule
```

RS Flip-Flop `inv_tb.v`
```verilog
`timescale 1ns / 1ps

module inv_tb;
reg r, s, clk;
wire q, nq;

inv u_test(
.r(r),
.s(s),
.clk(clk),
.q(q),
.nq(nq)
);

initial begin
r = 1'b0;
s = 1'b0;
clk = 1'b0;
end

always@(r or s or clk) begin
r <= #200 ~r;
s <= #100 ~s;
clk <= #50 ~clk;
end

initial begin
#800
$finish;
end

endmodule
```

RS Flip-Flop `inv.xdc`
```
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS18} [get_ports r]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS18} [get_ports s]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS18} [get_ports clk]

set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS18} [get_ports q]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS18} [get_ports nq]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets q_OBUF]
```

## 13주차

Up/Down Counter `inv.v`
```verilog
`timescale 1ns / 1ps

module up_down_counter(
    input clk,                 
    input rst,             
    input ud,                  
    output reg [3:0] out,     
    output reg [6:0] segment,  
    output reg digit            
);

    initial begin
        out = 4'b0000;
        segment = 7'b1111111; 
        digit = 1'b1;       
    end

    always @(posedge clk) begin  // clk
        if (rst) begin           // rst
            out <= 4'b0000;   
        end else begin
            if (ud) begin        // ud
                out <= out + 1; 
            end else begin
                out <= out - 1; 
            end
        end
    end

    always @(*) begin
        if (ud) begin
            segment = 7'b0111110;
        end else begin
            segment = 7'b0111101;
        end
    end

endmodule
```

Up/Down Counter `inv_tb.v`
```verilog
`timescale 1ns / 1ps

module up_down_counter_tb;

    reg clk;
    reg rst;
    reg ud;
    wire [3:0] out;
    wire [6:0] segment;
    wire digit;

    up_down_counter uut (
        .clk(clk),
        .rst(rst),
        .ud(ud),
        .out(out),
        .segment(segment),
        .digit(digit)
    );

    initial begin
        clk = 1'b0;    
        rst = 1'b0;     
        ud = 1'b1;     
    end

    always #10 clk = ~clk;

    initial begin
        #400 rst = 1'b1;  
        #20 rst = 1'b0;   
    end

    initial begin
        #600 ud = 1'b0;  
    end

    initial begin
        #1000 $finish;
    end

endmodule
```

Up/Down Counter Simulation
![updowncounter_sim](https://github.com/user-attachments/assets/b0c544ee-5930-4bad-a808-2c68c073b727)

Up/Down Counter `inv.xdc`
```
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS18} [get_ports clk]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS18} [get_ports rst]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS18} [get_ports ud]

set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS18} [get_ports out[3]]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS18} [get_ports out[2]]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS18} [get_ports out[1]]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS18} [get_ports out[0]]

set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS18} [get_ports segment[6]]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS18} [get_ports segment[5]]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS18} [get_ports segment[4]]
set_property -dict {PACKAGE_PIN B22 IOSTANDARD LVCMOS18} [get_ports segment[3]]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS18} [get_ports segment[2]]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS18} [get_ports segment[1]]
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS18} [get_ports segment[0]]

set_property -dict {PACKAGE_PIN E14 IOSTANDARD LVCMOS18} [get_ports digit]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
```


