`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 14:02:20
// Design Name: 
// Module Name: lab1_2
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


module lab2(
input [3:0]A, B,
input ci,
output reg co,
output reg [3:0]s
);
wire [2:0]ca;
wire [4:0]te;
assign te[0] = A[0]^B[0]^ci;
assign ca[0] = (A[0]&ci)|(B[0]&ci)|(A[0]&B[0]);
assign te[1] = A[1]^B[1]^ca[0];
assign ca[1] = (A[1]&ca[0])|(B[1]&ca[0])|(A[1]&B[1]);
assign te[2] = A[2]^B[2]^ca[1];
assign ca[2] = (A[2]&ca[1])|(B[2]&ca[1])|(A[2]&B[2]);
assign te[3] = A[3]^B[3]^ca[2];
assign te[4] = (A[3]&ca[2])|(B[3]&ca[2])|(A[3]&B[3]);
always @*
if(te>9)begin
{co, s} = te + 6;
//co = 1;
end
else begin
{co, s} = te;
//s = te;
//co = 0;
end
endmodule
