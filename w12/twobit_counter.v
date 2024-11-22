`timescale 1ns / 1ps

module binary_counter(
    input wire x,
    input wire clk,
    input wire rst,
    output wire [1:0] z
);

    parameter q0 = 2'd0,
              q1 = 2'd1,
              q2 = 2'd2,
              q3 = 2'd3;
              
    reg [1:0] current_state, next_state;
    
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
                q3: next_state = q0;
                default: next_state = q0;
            endcase
        end else begin
            next_state = current_state;
        end
    end

endmodule


