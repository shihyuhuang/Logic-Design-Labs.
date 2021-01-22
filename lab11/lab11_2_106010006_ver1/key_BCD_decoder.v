`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/26 17:33:31
// Design Name: 
// Module Name: key_BCD_decoder
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

`define KEY_0 {1'b0 , 8'h70}
`define KEY_1 {1'b0 , 8'h69}
`define KEY_2 {1'b0 , 8'h72}
`define KEY_3 {1'b0 , 8'h7A}
`define KEY_4 {1'b0 , 8'h6B}
`define KEY_5 {1'b0 , 8'h73}
`define KEY_6 {1'b0 , 8'h74}
`define KEY_7 {1'b0 , 8'h6C}
`define KEY_8 {1'b0 , 8'h75}
`define KEY_9 {1'b0 , 8'h7D}
`define KEY_A {1'b0 , 8'h79}
`define KEY_S {1'b0 , 8'h7B}
`define KEY_M {1'b0 , 8'h7C}
`define KEY_ENT {1'b0 , 8'h71}

`define SSD_A 4'b1010
`define SSD_S 4'b1011
`define SSD_M 4'b1100
`define SSD_Z 4'b1101

///////////把key轉成BCD，除了上面define的之外都output 0
module key_BCD_decoder(
    input [8:0]key,
    output reg [3:0]BCD
    );
    
    always@*
        case(key)
        `KEY_0:BCD <= 0;
        `KEY_1:BCD <= 1;
        `KEY_2:BCD <= 2;
        `KEY_3:BCD <= 3;
        `KEY_4:BCD <= 4;
        `KEY_5:BCD <= 5;
        `KEY_6:BCD <= 6;
        `KEY_7:BCD <= 7;
        `KEY_8:BCD <= 8;
        `KEY_9:BCD <= 9;
        `KEY_A:BCD <= `SSD_A;
        `KEY_S:BCD <= `SSD_S;
        `KEY_M:BCD <= `SSD_M;                      
        default:BCD <= 0;
        endcase  
    
    
endmodule
