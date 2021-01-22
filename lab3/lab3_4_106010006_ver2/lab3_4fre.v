`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/17 00:10:47
// Design Name: 
// Module Name: lab3_4fre
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


module lab3_4fre(
    input clk,
    output fout,
    input rst_n
    );
    
    //def  cnt
    reg [26:0]cnt,cnt_tmp;
    
    //def  clk_temp
    reg clk_tmp,s_cnt,s_cnt_tmp;    
    
    // Combinational logics
    always @(cnt)
        if(cnt == 49999999) cnt_tmp <= 0;
        else cnt_tmp <= cnt + 1;
    //clk_temp 0.5s
    always @(cnt)
        if(cnt == 49999999) clk_tmp <= 1;
        else clk_tmp <= 0;
        
    //slow 
    always @(s_cnt)
        s_cnt_tmp <= ~s_cnt ;  
        
    assign fout = s_cnt;
       
    //Flip flop with 0.5s freq
    always @(posedge clk_tmp or negedge rst_n)
        if (~rst_n) s_cnt <= 0;
        else s_cnt <= s_cnt_tmp;                    
    // Flip flops
    always @(posedge clk or negedge rst_n)
        if (~rst_n) cnt <= 27'b0;
        else cnt <= cnt_tmp;
        
endmodule