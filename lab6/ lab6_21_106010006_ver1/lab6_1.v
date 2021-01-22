`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 00:54:27
// Design Name: 
// Module Name: lab6_1
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


module lab6_2(
clk,
rst_n,
s_clk,
BCD_dsp,
bit_dsp
);
input clk;
input rst_n;
input s_clk;
output [7:0] BCD_dsp;
output [3:0] bit_dsp;
wire [3:0]a,b,c,d;

lab6_2_dis U0 (.clk(clk),.rst_n(rst_n),.a(a),.b(b),.c(c),.d(d),.BCD_dsp(BCD_dsp),.bit_dsp(bit_dsp));
lab6_2_time_counter U1 (.clk_1(clk_1),.qclk(qclk),.s_clk(s_clk),.rst_n(rst_n),.a(a),.b(b),.c(c),.d(d));
lab6_2_qclk U2 (.fout(qclk),.clk(clk),.rst_n(rst_n));
lab6_2fre1hz U3 (.fout(clk_1),.clk(clk),.rst_n(rst_n));


endmodule
