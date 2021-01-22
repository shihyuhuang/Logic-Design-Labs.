`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/30 00:09:08
// Design Name: 
// Module Name: note_gun
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


module note_gun( clk, // clock from crystal
rst, // active low reset
note_div,

audio_max,
audio_min,
 // div for note generation
audio_left, // left sound audio
audio_right // right sound audio
);
// I/O declaration
input [15:0]audio_max;
input [15:0]audio_min;

input clk; // clock from crystal
input rst; // active low reset
input [21:0] note_div; // div for note generation
output [15:0] audio_left; // left sound audio
output [15:0] audio_right; // right sound audio
// Declare internal signals
reg [21:0] clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next; // Note frequency generation
always @(posedge clk or negedge rst)
if (rst) begin
clk_cnt <= 22'd0;
b_clk <= 1'b0;
end else begin
clk_cnt <= clk_cnt_next;
b_clk <= b_clk_next;
end
always @*
if (clk_cnt == note_div) begin
clk_cnt_next = 22'd0;
b_clk_next = ~b_clk;
end else begin
clk_cnt_next = clk_cnt + 1'b1;
b_clk_next = b_clk;
end
// Assign the amplitude of the note
assign audio_left = (b_clk == 1'b0) ? audio_max : audio_min;
assign audio_right = (b_clk == 1'b0) ? audio_max : audio_min;
endmodule

