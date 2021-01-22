`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 14:05:47
// Design Name: 
// Module Name: lab1_3
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

module lab3(
input [2:0]in,
input en,
output[7:0]d
);
assign d[0] = ~in[2] & ~in[1] & ~in[0] & en;
assign d[1] = ~in[2] & ~in[1] & in[0] & en;
assign d[2] = ~in[2] & in[1] & ~in[0] & en;
assign d[3] = ~in[2] & in[1] & in[0] & en;
assign d[4] = in[2] & ~in[1] & ~in[0] & en;
assign d[5] = in[2] & ~in[1] & in[0] & en;
assign d[6] = in[2] & in[1] & ~in[0] & en;
assign d[7] = in[2] & in[1] & in[0] & en;
endmodule
