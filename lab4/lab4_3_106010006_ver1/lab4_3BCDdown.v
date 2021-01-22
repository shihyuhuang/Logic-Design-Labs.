`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 01:21:04
// Design Name: 
// Module Name: lab4_3BCDdown
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


module lab4_3BCDdown(
b, // divided clock output
clk, // global clock input
rst_n // active low reset
);
output [3:0]b; // divided output
input clk; // global clock input
input rst_n; // active low reset
wire qclk;
reg [3:0] b_tmp,b;
lab4_3fre U0 (.clk(clk),.rst_n(rst_n),.fout(qclk));



always @(posedge qclk or negedge rst_n)
if (~rst_n) b <= 4'd9;
else b <= b_tmp;

always @*
if(b == 0) b_tmp <= 4'd9;
else b_tmp <= b - 4'd1;


endmodule
