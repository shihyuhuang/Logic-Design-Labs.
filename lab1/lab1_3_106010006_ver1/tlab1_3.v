`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 14:06:35
// Design Name: 
// Module Name: tlab1_3
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


module testlab3;
reg [3:0]In;
reg [1:0]En;
wire [7:0]D;
lab3 U2(.d(D),.in(In[2:0]),.en(En[0]));
initial
begin
for (In = 4'b0000; In<= 4'b0111; In = In + 4'b0001)
for (En = 2'b00; En<= 2'b01; En = En + 2'b01)
#10;
end
endmodule
