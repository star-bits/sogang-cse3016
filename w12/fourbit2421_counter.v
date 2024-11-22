`timescale 1ns / 1ps
              
  module decade_counter(
      input wire x,
      input wire clk,
      input wire rst,
      output wire [3:0] z
      );
  
    parameter q0 = 4'b0000, // 0
                q1 = 4'b0001, // 1
                q2 = 4'b0010, // 2
                q3 = 4'b0011, // 3
                q4 = 4'b0100, // 4
                q5 = 4'b1011, // 5
                q6 = 4'b1100, // 6
                q7 = 4'b1101, // 7
                q8 = 4'b1110, // 8
                q9 = 4'b1111; // 9
                
      reg [3:0] current_state, next_state;
      
      assign z = current_state;
      
      always @(posedge clk or posedge rst) begin
          if (rst)
              current_state <= q0;
          else
              current_state <= next_state;
      end
      
      always @(*) begin
          if (x) begin
              case (current_state)
                  q0: next_state = q1;
                  q1: next_state = q2;
                  q2: next_state = q3;
                  q3: next_state = q4;
                  q4: next_state = q5;
                  q5: next_state = q6;
                  q6: next_state = q7;
                  q7: next_state = q8;
                  q8: next_state = q9;
                  q9: next_state = q0;
                  default: next_state = q0;
              endcase
                      end else begin
                          next_state = current_state;
                      end
                  end
              
              endmodule



