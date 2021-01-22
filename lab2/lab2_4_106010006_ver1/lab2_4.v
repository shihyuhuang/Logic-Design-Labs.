`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/10 22:07:53
// Design Name: 
// Module Name: lab2_4
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


module lab2_2(
input [3:0]A,B,
output [3:0]Aled,Bled,
output reg X
);
/*�N4-bit input A,B���O�]�w��Aled,Bled�A��input��ܦAled�O�W*/
    assign Aled[0]=A[0];
    assign Aled[1]=A[1];
    assign Aled[2]=A[2];
    assign Aled[3]=A[3];
   
    assign Bled[0]=B[0];
    assign Bled[1]=B[1];
    assign Bled[2]=B[2];
    assign Bled[3]=B[3];
   
/*���A�PB���j�p�A�YA > B�NX�]��1�A�YA ? B�h�NX�]��0*/
always@*
if(A>B)
X=1;
else
X=0;
    
endmodule

