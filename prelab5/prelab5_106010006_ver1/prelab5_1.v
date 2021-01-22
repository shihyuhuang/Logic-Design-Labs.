`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 21:00:34
// Design Name: 
// Module Name: prelab5_1
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


module prelab5_1(
clk, 
rst_n,
in,
stateled,
endled,
a,
b
);
input clk; 
input rst_n; 
input in;
output reg [2:0]a;
output reg [3:0]b;
output reg [14:0]endled;
output stateled;
reg [3:0] b_tmp;
reg [2:0] a_tmp;


prelab5_1sta Uo (.count_enable(en),.clk(clk),.rst_n(rst_n),.in(in),.stateled(stateled));

always @(posedge clk or posedge rst_n)
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

endmodule