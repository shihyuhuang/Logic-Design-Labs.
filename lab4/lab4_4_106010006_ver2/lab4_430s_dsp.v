`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 09:26:28
// Design Name: 
// Module Name: lab4_430s_dsp
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

module lab4_430s_dsp(
A,
B, 
clk, // global clock input
rst_n // active low reset
);
output reg [7:0]A,B;
input clk; // global clock input
input rst_n; // active low reset
reg [2:0]a;
reg [3:0]b;
reg [3:0] b_tmp;
reg [2:0] a_tmp;
reg tmp;
wire qclk; 

lab4_4fre U0 (.clk(clk),.rst_n(rst_n),.fout(qclk));

// Flip flops
always @(posedge qclk or negedge rst_n)
if (~rst_n)begin
 b <= 4'd0;
 a <= 3'd3;
end
else begin
 b <= b_tmp;
 a <= a_tmp ;
end

always @*
if(b == 0) b_tmp = 4'd9;
else b_tmp = b - 4'd1;

always @*
if(b == 0) tmp = 0;
else tmp = 1;


always @*
if((tmp==0)&&(a==0)) a_tmp =3'd2;
else if((tmp == 0)&&(a!==0)) a_tmp = a - 3'd1;
else a_tmp = a;


always @*
case (a)
3'd0: A = `SS_0;
3'd1: A = `SS_1;
3'd2: A = `SS_2;
3'd3: A = `SS_3;
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

endmodule