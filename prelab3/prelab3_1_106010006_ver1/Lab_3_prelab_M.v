`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 23:04:22
// Design Name: 
// Module Name: Lab_3_prelab_M
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


`define BCD_BIT_WIDTH 4
`define BCD_ZERO 4'd0
`define BCD_ONE 4'd1

module Lab_3_prelab_M(
    q, // output
    clk, // global clock
    rst // active high reset
);
output [`BCD_BIT_WIDTH-1:0] q; // output
input clk; // global clock
input rst; // active high reset
reg [`BCD_BIT_WIDTH-1:0] q; // output (in always block)
reg [`BCD_BIT_WIDTH-1:0] q_tmp; // input to dff (in always block)
// Combinational logics
always @(q)
    q_tmp = q + `BCD_ONE;
// Sequential logics: Flip flops
always @(posedge clk or posedge rst)
    if (rst) q<=`BCD_BIT_WIDTH'd0;
    else q<=q_tmp;

endmodule
