`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 01:07:20
// Design Name: 
// Module Name: lab3_1
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


`define FREQ_DIV_BIT 27
module lab3_1(
fout, // divided clock output
clk, // global clock input
rst_n // active low reset
);
output fout; // divided output
input clk; // global clock input
input rst_n; // active low reset
reg fout; // clk output (in always block)
reg [`FREQ_DIV_BIT-2:0] cnt; // remainder of the counter
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow
always @*
cnt_tmp = {fout,cnt} + `FREQ_DIV_BIT'd1;
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) 
{fout, cnt}<=`FREQ_DIV_BIT'd0;
else 
{fout,cnt}<=cnt_tmp;
endmodule