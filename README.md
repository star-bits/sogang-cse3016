# 컴퓨터공학실험II (컴실2)

## 1주차 + 2주차

'Vivado 2017.3' 프로그램을 실행. ('Vivado HLS 2017.3' 프로그램이 아니라.)
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
- Run Synthesis - Run Implementation - Generate Bitstream - Open Target - Auto Connect - Program Device - Program

## 9주차
AND 게이트를 사용한 2 to 4 디코더:
```
module decoder_and (
    input A, B,
    output D_0, D_1, D_2, D_3
);
    assign D_0 = ~A & ~B;
    assign D_1 = ~A &  B;
    assign D_2 =  A & ~B;
    assign D_3 =  A &  B;
endmodule
```
NAND 게이트를 사용한 2 to 4 디코더:
```
module decoder_nand (
    input A, B,
    output D_0, D_1, D_2, D_3
);
    assign D_0 = ~(~A & ~B);
    assign D_1 = ~(~A &  B);
    assign D_2 = ~( A & ~B);
    assign D_3 = ~( A &  B);
endmodule
```

BCD to decimal 디코더:
```
module decoder_bcd2decimal (
input A_0, // 1
input A_1, // 2
input A_2, // 4
input A_3, // 8
output D1, D2, D3, D4, D5, D6, D7, D8, D9
);
assign D1 = ~A_3 & ~A_2 & ~A_1 & A_0;
assign D2 = ~A_3 & ~A_2 & A_1 & ~A_0;
assign D3 = ~A_3 & ~A_2 & A_1 & A_0;
assign D4 = ~A_3 & A_2 & ~A_1 & ~A_0;
assign D5 = ~A_3 & A_2 & ~A_1 & A_0;
assign D6 = ~A_3 & A_2 & A_1 & ~A_0;
assign D7 = ~A_3 & A_2 & A_1 & A_0;
assign D8 = A_3 & ~A_2 & ~A_1 & ~A_0;
assign D9 = A_3 & ~A_2 & ~A_1 & A_0;
endmodule
```

OR 게이트를 사용한 4 to 2 인코더:
```
module encoder_or (
    input A, B, C, D,
    output E_1, E_0
);
    assign E_1 = C | D;
    assign E_0 = B | D;
endmodule
```

4 to 1 line MUX:
```
module mux_4to1 (
    input A, B, C, D, 
    input a, b,    
    output F     
);
    wire s0, s1, s2, s3; // 선택 신호
    wire y0, y1, y2, y3; // AND 게이트의 출력

    assign s0 = ~a & ~b;
    assign s1 = ~a &  b;
    assign s2 =  a & ~b;
    assign s3 =  a &  b;

    assign y0 = A & s0;
    assign y1 = B & s1;
    assign y2 = C & s2;
    assign y3 = D & s3;

    assign F = y0 | y1 | y2 | y3;
endmodule
```

1 to 4 line deMUX:
```
module demux_1to4 (
    input F,        
    input a, b,          
    output A, B, C, D    
);
    wire s0, s1, s2, s3; // 선택 신호

    assign s0 = ~a & ~b;
    assign s1 = ~a &  b;
    assign s2 =  a & ~b;
    assign s3 =  a &  b;

    assign A = F & s0;
    assign B = F & s1;
    assign C = F & s2;
    assign D = F & s3;
endmodule
```
