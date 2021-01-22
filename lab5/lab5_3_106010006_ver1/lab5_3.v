`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 18:30:10
// Design Name: 
// Module Name: lab5_3
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


module lab5_3(
clk, 
rst_n,
in,
mode,
stateled,
endled,
BCD_dsp,
bit_dsp
);
input clk; 
input rst_n; 
input in;
input mode;
output reg [7:0] BCD_dsp;
output reg [3:0] bit_dsp;
reg [7:0]A,B,C;
output reg [14:0]endled;
output stateled; 
reg [2:0]a;
reg [3:0]b;
reg c;
reg [3:0] b_tmp;
reg [2:0] a_tmp;
reg c_tmp;
reg [19:0] cnt,cnt_tmp;
reg [2:0]reset,reset_tmp;

lab5_3sta Uo (.count_enable(en),.count_enable2(modech),.clk(clk),.rst_n(rst_n),.mode(mode),.in(in),.stateled(stateled));
lab5_3fre1hz U0 (.clk(clk),.rst_n(rst_n),.fout(clk_1));

always @(posedge clk_1 or posedge rst_n)
if (rst_n)begin
b <= 4'd0;
a <= 3'd3;
c <= 1'd0;
end
else begin
 b <= b_tmp;
 a <= a_tmp;
 c <= c_tmp;
end

always @*
if((reset==2)&&(modech==0))begin
 b_tmp <= 4'd0;
 a_tmp <= 3'd3;
 c_tmp <= 1'd0;
end
else if((reset==2)&&(modech==1))begin
 b_tmp <= 4'd0;
 a_tmp <= 3'd0;
 c_tmp <= 1'd1;
end
else begin
     if(en == 0) begin
     b_tmp = b;
     a_tmp = a;
     c_tmp = c;
     end
     else begin
          if((c==0)&&(a==0)&&(b==0))begin
          b_tmp = b;
          a_tmp = a;
          c_tmp = c;
          end
          else if((c==0)&&(a!==0)&&(b!==0)) begin
          b_tmp = b - 4'd1;
          a_tmp = a;
          c_tmp = c;
          end
          else if((c==0)&&(a!==0)&&(b==0))begin
          b_tmp = 4'd9;
          a_tmp = a - 3'd1;
          c_tmp = c;
          end
          else if((c==0)&&(a==0)&&(b!==0)) begin
          b_tmp = b - 4'd1;
          a_tmp = a;
          c_tmp = c;
          end
          else begin
          b_tmp = 4'd9;
          a_tmp = 3'd5;
          c_tmp = c - 1'd1;
          end
      end
end

always @(posedge clk_1 or posedge rst_n)
if (rst_n)begin
reset <= 3'd0;
end
else begin
reset <= reset_tmp;
end

always @*
if(in==1)
reset_tmp = reset+1;
else
reset_tmp = 0;




always@*
if((a==0)&&(b==0)&&(c==0))
endled = 15'b111111111111111;
else
endled = 15'd0;

always @*
case (a)
3'd0: A = `SS_0;
3'd1: A = `SS_1;
3'd2: A = `SS_2;
3'd3: A = `SS_3;
3'd4: A = `SS_4;
3'd5: A = `SS_5;
3'd6: A = `SS_6;
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
1'd0: C = `SS_0;
1'd1: C = `SS_1;
default: C = `SS_F;
endcase

//+1
always @*
cnt_tmp = cnt+1;
// Flip flops
always @(posedge clk or posedge rst_n)
if (rst_n) cnt <= 20'b0;
else cnt <= cnt_tmp;
/*��X�̥��䪺bit*/
wire [1:0] cl;
assign cl= cnt[19:18];
/*��ܭn�G���^��r*/
always @*
case(cl)
2'b00: BCD_dsp = B;
2'b01: BCD_dsp = C;
default: BCD_dsp = A;
endcase
/*��ܭn�G���ӿO�A0���G1�����G*/
always @*
case(cl)
2'b00: bit_dsp = 4'b1110;
2'b01: bit_dsp = 4'b1011;
default: bit_dsp = 4'b1101;
endcase


endmodule
