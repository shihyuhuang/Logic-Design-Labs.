`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/17 00:09:28
// Design Name: 
// Module Name: lab3_4
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



`define SS_N 8'b11010101
`define SS_T 8'b11100001
`define SS_H 8'b10010001
`define SS_U 8'b10000011
`define SS_E 8'b01100001


module lab3_4(
    input clk,
    input rst_n,
    output [7:0]BCD_dsp,
    output [3:0]bit_dsp
    );
    
    wire qclk;
    
    lab3_4fre U0 (.clk(clk),.rst_n(rst_n),.fout(qclk));
    lab3_4ssd_ctl U1 (.dsp3(q5),.dsp2(q4),.dsp1(q3),.dsp0(q2),
                .clk(clk),.BCD(BCD_dsp),.BCD_c(bit_dsp),.rst_n(rst_n));
    reg [7:0]q0,q1,q2,q3,q4,q5;
    
    always @(posedge qclk or negedge rst_n)
        if (~rst_n) begin
            q5<=`SS_N;
            q4<=`SS_T;
            q3<=`SS_H;
            q2<=`SS_U;
            q2<=`SS_E;
            q0<=`SS_E;
            
        end
        else begin
            q0<=q5;
            q1<=q0;
            q2<=q1;
            q3<=q2;
            q4<=q3;
            q5<=q4;
                                   
        end
    
endmodule
