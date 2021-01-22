`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/17 10:23:49
// Design Name: 
// Module Name: lab4_1
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

module lab4_1(
b, // output
clk, // global clock
rst_n // active low reset
);
output [3:0] b; // output
input clk; // global clock
input rst_n; // active low reset
lab4_1fre U0 (.clk(clk),.rst_n(rst_n),.fout(qclk));
reg [3:0] b; // output (in always block)
reg [3:0] b_tmp; // input to dff (in always block)
// Combinational logics
always @*
b_tmp = b + 4'd1;
// Sequential logics: Flip flops
always @(posedge qclk or negedge rst_n)
if (~rst_n) b<=4'd0;
else b<=b_tmp;

endmodule