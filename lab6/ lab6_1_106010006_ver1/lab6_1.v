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


module lab6_1(
clk,
rst_n,
s_12_24,
s_clk,
s_hm_s,
BCD_dsp,
bit_dsp,
led
);
input clk;
input rst_n;
input s_12_24,s_clk,s_hm_s;
output [7:0] BCD_dsp;
output [3:0] bit_dsp;
output led;
wire [3:0]a,b,c,d;

lab6_1_dis U0 (.clk(clk),.rst_n(rst_n),.a(a),.b(b),.c(c),.d(d),.BCD_dsp(BCD_dsp),.bit_dsp(bit_dsp));
lab6_1_time_counter U1 (.clk_1(clk_1),.qclk(qclk),.s_12_24(s_12_24),.s_clk(s_clk),.s_hm_s(s_hm_s),
.rst_n(rst_n),.a(a),.b(b),.c(c),.d(d),.led(led));
lab6_1_qclk U2 (.fout(qclk),.clk(clk),.rst_n(rst_n));
lab6_1fre1hz U3 (.fout(clk_1),.clk(clk),.rst_n(rst_n));


endmodule
