`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/10 22:53:05
// Design Name: 
// Module Name: prelab3_1
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

module prelab3_1(
q, // output
clk, // global clock
rst_n // active low reset
);
output [3:0] q; // output
input clk; // global clock
input rst_n; // active low reset
reg [3:0] q; // output (in always block)
reg [3:0] q_tmp; // input to dff (in always block)
// Combinational logics
always @*
q_tmp = q + 4'd1;
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) q<=4'd0;
else q<=q_tmp;
endmodule
