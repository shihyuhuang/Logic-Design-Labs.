`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 03:33:57
// Design Name: 
// Module Name: lab3_3shif
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

module prelab3_2(
q, // shifter output
clk, // global clock
rst_n // active low reset
);
output [7:0] q; // output
input clk; // global clock
input rst_n; // active low reset
reg [7:0] q; // output
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n)
begin
q<=8'b01010101;
end
else
begin
q[0]<=q[7];
q[1]<=q[0];
q[2]<=q[1];
q[3]<=q[2];
q[4]<=q[3];
q[5]<=q[4];
q[6]<=q[5];
q[7]<=q[6];
end
endmodule