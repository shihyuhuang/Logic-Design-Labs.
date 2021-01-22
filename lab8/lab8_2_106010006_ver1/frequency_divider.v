`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/29 23:25:18
// Design Name: 
// Module Name: frequency_divider
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


module frequency_divider(
    
    input rst,
    input clk,
    input [30:0]x,
    output clk_out
    
    );
    reg [30:0]cnt;
    
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
    
    assign clk_out = cnt[x-1];
endmodule

