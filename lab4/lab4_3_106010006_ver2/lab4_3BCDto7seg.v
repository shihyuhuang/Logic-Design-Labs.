`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 01:27:45
// Design Name: 
// Module Name: lab4_3BCDto7seg
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


`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001

module lab4_3BCDto7seg(
b,
BCD_dsp
    );
input [3:0]b;
output reg [7:0]BCD_dsp;
always @*
case (b)
4'd0: BCD_dsp = `SS_0;
4'd1: BCD_dsp = `SS_1;
4'd2: BCD_dsp = `SS_2;
4'd3: BCD_dsp = `SS_3;
4'd4: BCD_dsp = `SS_4;
4'd5: BCD_dsp = `SS_5;
4'd6: BCD_dsp = `SS_6;
4'd7: BCD_dsp = `SS_7;
4'd8: BCD_dsp = `SS_8;
default: BCD_dsp = `SS_9;
endcase
endmodule

