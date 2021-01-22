`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/08 14:02:03
// Design Name: 
// Module Name: scoll_FSM
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


module scoll_FSM(
    input rst,
    input clk,
    input btn,
    output reg is_scoll
    );
    wire clk_div;
    freq_div U0(.rst(rst), .f_cst(clk), .freq(4999999) ,.fout(clk_div));
    
    reg btn_tmp,is_scoll_tmp;
    //Flip flop fot sp_btn
    always @(posedge clk_div or posedge rst)
        if (rst) btn_tmp <= 0;
        else btn_tmp <= btn;
    //Flip flop 
    always @(posedge clk_div or posedge rst)
        if (rst) is_scoll <= 0;
        else is_scoll <= is_scoll_tmp;
    
        
     wire [1:0]in;
     assign in = {btn,btn_tmp};
     
     always@*
     if(in==2'b10)
        is_scoll_tmp = ~is_scoll;
     else
        is_scoll_tmp = is_scoll;
        
endmodule
