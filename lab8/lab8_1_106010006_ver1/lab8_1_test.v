`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/29 21:54:44
// Design Name: 
// Module Name: Lab_8_1_T
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


module Lab_8_1_T;

reg clk;
reg rst;
wire audio_mclk;
wire audio_lrck;
wire audio_sck;
wire audio_sdin;

Lab_8_1_M U10(.clk,.rst,.audio_mclk,.audio_lrck,.audio_sck,.audio_sdin);

always
#1 clk = ~clk;

initial
begin
clk = 0; rst = 1;
#5 rst = 0;
end

endmodule
