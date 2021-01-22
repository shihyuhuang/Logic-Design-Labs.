`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 14:03:22
// Design Name: 
// Module Name: tlab1_2
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


module testlab2;
reg [3:0]A, B;
reg [1:0] Ci;
wire Co;
wire [3:0]S;
lab2 U1 (.co(Co),.s(S),.ci(Ci[0]),.A(A),.B(B));
initial
begin
for (A = 4'b0000; A<= 4'b1001; A = A+ 4'b0001)begin
for (B = 4'b0000; B<= 4'b1001; B = B+ 4'b0001)begin
for (Ci = 2'b00; Ci<= 2'b01; Ci = Ci+ 2'b01)
#10;
end
end
end
endmodule
