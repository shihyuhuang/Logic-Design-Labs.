`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 21:40:08
// Design Name: 
// Module Name: lab6_1fre100hz
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


module lab6_2_2qclk(
fout, // divided clock output
clk, // global clock input
rst_n, // active low reset
sqclk
);
output reg fout; // divided output
input clk,sqclk; // global clock input
input rst_n; // active low reset
reg [26:0] c_tmp,c;
reg clk_tmp3,s_c,s_c_tmp;
reg [26:0] d_tmp,d;
reg clk_tmp4,s_d,s_d_tmp;
wire out3,out4;


always @*
if(c == 50000) c_tmp = 0;
else c_tmp = c + 27'd1;
//clk_temp 0.5s
always @*
if(c == 50000) clk_tmp3 = 1;
else clk_tmp3 = 0;
always @*
s_c_tmp = ~s_c ;
assign out3 = s_c;
always @(posedge clk_tmp3 or negedge rst_n)
if (~rst_n) s_c <= 0;
else s_c <= s_c_tmp;
// Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) c <= 27'b0;
else c <= c_tmp;

always @*
if(d == 8000000) d_tmp = 0;
else d_tmp = d + 27'd1;
//clk_temp 0.5s
always @*
if(d == 8000000) clk_tmp4 = 1;
else clk_tmp4 = 0;
always @*
s_d_tmp = ~s_d ;
assign out4 = s_d;
always @(posedge clk_tmp4 or negedge rst_n)
if (~rst_n) s_d <= 0;
else s_d <= s_d_tmp;
// Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) d <= 27'b0;
else d <= d_tmp;

always@*
case(sqclk)
1'd0: fout = out4;
default: fout = out3;
endcase

endmodule
