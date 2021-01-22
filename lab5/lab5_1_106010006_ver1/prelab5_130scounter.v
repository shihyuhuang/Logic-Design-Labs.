`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 00:07:24
// Design Name: 
// Module Name: prelab5_130scounter
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


module prelab5_130scounter(
clk, 
rst_n,
in,
stateled,
endled,
BCD_dsp,
bit_dsp
);
input clk; 
input rst_n; 
input in;
output reg [7:0] BCD_dsp;
output reg [3:0] bit_dsp;
reg [7:0]A,B;
output reg [14:0]endled;
output stateled;
wire qclk; 
reg [2:0]a;
reg [3:0]b;
reg [3:0] b_tmp;
reg [2:0] a_tmp;
reg [19:0] cnt,cnt_tmp;

prelab5_1state Uo (.count_enable(en),.clk(clk),.rst_n(rst_n),.in(in),.stateled(stateled));
lab5_1fre1hz U4 (.clk(clk),.rst_n(rst_n),.fout(qclk));

always @(posedge qclk or posedge rst_n)
if (rst_n)begin
 b <= 4'd0;
 a <= 3'd3;
end
else begin
 b <= b_tmp;
 a <= a_tmp;
end

always @*
if(en == 0) begin
b_tmp = b;
a_tmp = a;
end
else
  begin
    if((a==0)&&(b==0))begin
    b_tmp = b;
    a_tmp = a;
    end
    else if((a!==0)&&(b==0))begin
    b_tmp = 4'd9;
    a_tmp = a - 3'd1;
    end
    else begin
    b_tmp = b - 4'd1;
    a_tmp = a;
   end
end

always@*
if((a==0)&&(b==0))
endled = 15'b111111111111111;
else
endled = 15'd0;

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

//+1
always @*
cnt_tmp = cnt+1;
// Flip flops
always @(posedge clk or posedge rst_n)
if (rst_n) cnt <= 20'b0;
else cnt <= cnt_tmp;
/*抓出最左邊的bit*/
wire cl;
assign cl= cnt[19];
/*選擇要亮的英文字*/
always @*
case(cl)
1'd0: BCD_dsp = B;
default: BCD_dsp = A;
endcase
/*選擇要亮哪個燈，0為亮1為不亮*/
always @*
case(cl)
1'd0: bit_dsp = 4'b1110;
default: bit_dsp = 4'b1101;
endcase


endmodule

  
