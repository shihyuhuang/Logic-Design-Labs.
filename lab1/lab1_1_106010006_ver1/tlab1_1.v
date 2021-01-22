`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/02 22:11:26
// Design Name: 
// Module Name: tlab1_1
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


module test_lab1;
wire S,Cout;
reg X,Y,Cin;
lab1 U0(.cout(Cout),.s(S),.x(X),.y(Y),.cin(Cin));
initial
begin
 X=0;Y=0;Cin=0;
 #10 X=0;Y=0;Cin=1;
 #10 X=0;Y=1;Cin=0;
 #10 X=0;Y=1;Cin=1;
 #10 X=1;Y=0;Cin=0;
 #10 X=1;Y=0;Cin=1;
 #10 X=1;Y=1;Cin=0;
 #10 X=1;Y=1;Cin=1;
end
endmodule

