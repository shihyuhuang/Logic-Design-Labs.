`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/03 00:08:40
// Design Name: 
// Module Name: lab2_2s
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


module ssd(D_ssd, i, d);
output [3:0] d;
output [7:0] D_ssd;
input [3:0] i;

display U0(.D_ssd(D_ssd),.i(i));

assign d[0] = i[0];
assign d[1] = i[1];
assign d[2] = i[2];
assign d[3] = i[3];

endmodule
