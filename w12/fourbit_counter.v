`timescale 1ns / 1ps

module decade_counter(
    input wire x,
    input wire clk,
    input wire rst,
    output wire [3:0] z
    );

    parameter q0 = 4'd0,
              q1 = 4'd1,
              q2 = 4'd2,
              q3 = 4'd3,
              q4 = 4'd4,
              q5 = 4'd5,
              q6 = 4'd6,
              q7 = 4'd7,
              q8 = 4'd8,
              q9 = 4'd9;
              
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


