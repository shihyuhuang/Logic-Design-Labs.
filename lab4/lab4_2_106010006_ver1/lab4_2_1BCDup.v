`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/17 11:31:28
// Design Name: 
// Module Name: lab4_2_1BCDup
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


module lab4_2BCDup(
b, // divided clock output
clk, // global clock input
rst_n // active low reset
);
output [3:0]b; // divided output
input clk; // global clock input
input rst_n; // active low reset
lab4_2fre U0 (.clk(clk),.rst_n(rst_n),.fout(qclk));
reg [3:0] b_tmp,b;
wire qclk;

always @(b)
if(b==9) b_tmp <= 0;
else b_tmp <= b + 4'd1;

always @(posedge qclk or negedge rst_n)
if (~rst_n) b <= 4'b0;
else b <= b_tmp;

endmodule

