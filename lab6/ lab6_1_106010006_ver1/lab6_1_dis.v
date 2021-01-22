`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 00:35:42
// Design Name: 
// Module Name: lab6_1_dis
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
`define SS_F 8'b01110001

module lab6_1_dis(
clk,
rst_n,
a,
b,
c,
d,
BCD_dsp,
bit_dsp
);
input clk; 
input rst_n; 
input [3:0] a,b,c,d;
output reg [7:0] BCD_dsp;
output reg [3:0] bit_dsp;
reg c_tmp;
reg [19:0] cnt,cnt_tmp;
wire [1:0] cl;
reg [7:0]A,B,C,D;


always @*
case (a)
4'd0: A = `SS_0;
4'd1: A = `SS_1;
4'd2: A = `SS_2;
default: A = `SS_F;
endcase

always @*
case (b)
4'd0: B = `SS_0;
4'd1: B = `SS_1;
4'd2: B = `SS_2;
4'd3: B = `SS_3;
4'd4: B = `SS_4;
4'd5: B = `SS_5;
4'd6: B = `SS_6;
4'd7: B = `SS_7;
4'd8: B = `SS_8;
4'd9: B = `SS_9;
default: B = `SS_F;
endcase

always @*
case (c)
4'd0: C = `SS_0;
4'd1: C = `SS_1;
4'd2: C = `SS_2;
4'd3: C = `SS_3;
4'd4: C = `SS_4;
4'd5: C = `SS_5;
4'd6: C = `SS_6;
4'd7: C = `SS_7;
4'd8: C = `SS_8;
4'd9: C = `SS_9;
default: C = `SS_F;
endcase

always @*
case (d)
4'd0: D = `SS_0;
4'd1: D = `SS_1;
4'd2: D = `SS_2;
4'd3: D = `SS_3;
4'd4: D = `SS_4;
4'd5: D = `SS_5;
4'd6: D = `SS_6;
4'd7: D = `SS_7;
4'd8: D = `SS_8;
4'd9: D = `SS_9;
default: D = `SS_F;
endcase




always @*
cnt_tmp = cnt+1;

always @(posedge clk or negedge rst_n)
if (~rst_n) cnt <= 20'b0;
else cnt <= cnt_tmp;

assign cl= cnt[19:18];

always @*
case(cl)
2'd0: BCD_dsp = D;
2'd1: BCD_dsp = C;
2'd2: BCD_dsp = B;
default: BCD_dsp = A;
endcase

always @*
case(cl)
2'd0: bit_dsp = 4'b1110;
2'd1: bit_dsp = 4'b1101;
2'd2: bit_dsp = 4'b1011;
default: bit_dsp = 4'b0111;
endcase


endmodule
