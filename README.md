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
