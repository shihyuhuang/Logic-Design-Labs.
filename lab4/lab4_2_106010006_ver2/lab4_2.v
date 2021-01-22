`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/17 12:03:18
// Design Name: 
// Module Name: lab4_2
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


module lab4_2(
rst_n,
clk,
BCD_dsp
    );
input rst_n,clk;
output [7:0]BCD_dsp;
wire [3:0]b;
lab4_2BCDup U2 (.clk(clk),.rst_n(rst_n),.b(b));
lab4_2BCD7seg U3 (.b(b),.BCD_dsp(BCD_dsp));

endmodule
