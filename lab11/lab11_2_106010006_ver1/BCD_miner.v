`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/10 17:48:10
// Design Name: 
// Module Name: BCD_miner
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


module BCD_miner(
    input [3:0]a,
    input [3:0]b,
    input c,
    output [3:0]f,
    output reg borrow
    );
    
    reg [4:0]ff;
    always @* 
    if(a < b+c )begin
        ff <= 10 - b + a -c;
        borrow <= 1;
    end 
    else begin
        ff <= a - b -c;
        borrow <= 0;        
    end
    
    assign f = {ff[3:0]};
    
endmodule
