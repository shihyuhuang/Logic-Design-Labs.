`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 21:11:22
// Design Name: 
// Module Name: prelab5_1tt
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


module prelab5_1tt;
wire [3:0]b;
wire [2:0]a;
wire stateled;
wire endled;
reg rst_n;
reg in;
reg clk;

prelab5_1 U3 (.clk(clk),.rst_n(rst_n),.in(in),.b(b),.a(a),.stateled(stateled),.endled(endled));

always #10 begin
    clk = ~clk; // 將 clock 反相 (0 變 1 、1 變 0)
end

initial
begin
    clk=0;
    in=0;
    rst_n=1;#10
    rst_n=0;#25
    in=1;#20
    in=0;#60
    in=1;#20
    in=0;#60
    in=1;#25
    in=0;#600
    rst_n=1;#80
    rst_n=0;
end

endmodule