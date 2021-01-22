`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 03:36:05
// Design Name: 
// Module Name: lab3_3shiftreg
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
module lab3_3shiftreg(
q, // LED output
clk, // global clock
rst_n // active low reset
);
output [7:0] q; // LED output
input clk; // global clock
input rst_n; // active low reset
wire clk_d;
wire [7:0] q; // divided clock
// Insert frequency divider (freq_div.v)
lab3_2 U_FD(
.fout(clk_d), // divided clock output
.clk(clk), // clock from the crystal
.rst_n(rst_n) // active low reset
);
// Insert shifter (shifter.v)
prelab3_2 U_D(
.q(q), // shifter output
.clk(clk_d), // clock from the frequency divider
.rst_n(rst_n) // active low reset
);
endmodule

