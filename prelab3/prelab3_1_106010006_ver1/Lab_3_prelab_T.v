`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 23:05:31
// Design Name: 
// Module Name: Lab_3_prelab_T
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


module Lab_3_prelab_T;

reg clk;
reg rst;
wire [3:0]q;

Lab_3_prelab_M U0(.clk,.rst,.q);

always
#5 clk = ~clk;

initial
begin
clk = 0 ; rst = 0;
#20 rst = 1;
#20 rst = 0;
end

endmodule
