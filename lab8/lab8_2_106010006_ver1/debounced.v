`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/29 23:53:13
// Design Name: 
// Module Name: debounced
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounced(
    
    input clk,
    input rst,
    input btn,
    output btn_out
    
    );
    
    reg [3:0]btn_window;
    reg btn_out;
    
    always @(posedge clk or posedge rst)begin
        if (rst) begin
            btn_window <= 4'b0;
            btn_out <= 1'b0;
        end
        else begin
            btn_window<={btn, btn_window[3:1]};
            if (btn_window[3:0] == 4'b1111) begin
                btn_out <= 1'b1;
            end
            else begin
                btn_out <= 1'b0;
            end
        end
    end
endmodule
