`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/10 23:37:49
// Design Name: 
// Module Name: prelab3_2t
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


module prelab3_2t;
reg clk,rst_n; 
wire [7:0]q; 
prelab3_2 U0(.q(q),.clk(clk),.rst_n(rst_n));

initial begin 
clk=0;
forever #5 clk=~clk;
end

initial begin
rst_n=0;
#20;
rst_n=1;
end
endmodule

