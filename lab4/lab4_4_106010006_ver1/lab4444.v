`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 14:25:21
// Design Name: 
// Module Name: lab4444
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


module lab4_4ssd_ctl(
clk,
rst_n,
BCD_dsp,
bit_dsp
);
input clk;
output reg [7:0] BCD_dsp;
output reg [3:0] bit_dsp;
input rst_n;
//counter
reg [19:0] cnt,cnt_tmp;
wire [7:0]A,B;
lab4_430s_dsp U2 (.A(A),.B(B),.clk(clk),.rst_n(rst_n));

//+1
always @*
cnt_tmp = cnt+1;
// Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) cnt <= 20'b0;
else cnt <= cnt_tmp;
/*抓出最左邊的bit*/
wire en;
assign en= cnt[19];
/*選擇要亮的英文字*/
always @*
case(en)
1'd0: BCD_dsp = B;
default: BCD_dsp = A;
endcase
/*選擇要亮哪個燈，0為亮1為不亮*/
always @*
case(en)
1'd0: bit_dsp = 4'b1110;
default: bit_dsp = 4'b1101;
endcase

endmodule
