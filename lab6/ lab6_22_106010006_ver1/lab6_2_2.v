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


module lab6_2_2(
clk,
rst_n,
switch,
BCD_dsp,
bit_dsp,
sqclk
);
input clk;
input rst_n;
input sqclk;
input switch;
output [7:0] BCD_dsp;
output [3:0] bit_dsp;
wire [3:0] mon1,mon2,day1,day2,year1,year2;

lab6_2_2dis U0 (.clk(clk),.rst_n(rst_n),.switch(switch),.mon1(mon1),.mon2(mon2),.day1(day1),.day2(day2),.year1(year1),.year2(year2)
,.BCD_dsp(BCD_dsp),.bit_dsp(bit_dsp));
lab6_2_2time_counter U1 (.qclk(qclk),.rst_n(rst_n),.mon1(mon1),.mon2(mon2),.day1(day1),.day2(day2),.year1(year1),.year2(year2));
lab6_2_2qclk U2 (.fout(qclk),.clk(clk),.rst_n(rst_n),.sqclk(sqclk));

endmodule
