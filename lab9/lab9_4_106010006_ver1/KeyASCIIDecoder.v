`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/02 20:29:17
// Design Name: 
// Module Name: KeyASCIIDecoder
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
`define KEY_A {1'b0 , 8'h1C}
`define KEY_B {1'b0 , 8'h32}
`define KEY_C {1'b0 , 8'h21}
`define KEY_D {1'b0 , 8'h23}
`define KEY_E {1'b0 , 8'h24}
`define KEY_F {1'b0 , 8'h2B}
`define KEY_G {1'b0 , 8'h34}
`define KEY_H {1'b0 , 8'h33}
`define KEY_I {1'b0 , 8'h43}
`define KEY_J {1'b0 , 8'h3B}
`define KEY_K {1'b0 , 8'h42}
`define KEY_L {1'b0 , 8'h4B}
`define KEY_M {1'b0 , 8'h3A}
`define KEY_N {1'b0 , 8'h31}
`define KEY_O {1'b0 , 8'h44}
`define KEY_P {1'b0 , 8'h4D}
`define KEY_Q {1'b0 , 8'h15}
`define KEY_R {1'b0 , 8'h2D}
`define KEY_S {1'b0 , 8'h1B}
`define KEY_T {1'b0 , 8'h2C}
`define KEY_U {1'b0 , 8'h3C}
`define KEY_V {1'b0 , 8'h2A}
`define KEY_W {1'b0 , 8'h1D}
`define KEY_X {1'b0 , 8'h22}
`define KEY_Y {1'b0 , 8'h35}
`define KEY_Z {1'b0 , 8'h1A}

`define ASCII_A 8'h41
`define ASCII_B 8'h42
`define ASCII_C 8'h43
`define ASCII_D 8'h44
`define ASCII_E 8'h45
`define ASCII_F 8'h46
`define ASCII_G 8'h47
`define ASCII_H 8'h48
`define ASCII_I 8'h49
`define ASCII_J 8'h4A
`define ASCII_K 8'h4B
`define ASCII_L 8'h4C
`define ASCII_M 8'h4D
`define ASCII_N 8'h4E
`define ASCII_O 8'h4F
`define ASCII_P 8'h50
`define ASCII_Q 8'h51
`define ASCII_R 8'h52
`define ASCII_S 8'h53
`define ASCII_T 8'h54
`define ASCII_U 8'h55
`define ASCII_V 8'h56
`define ASCII_W 8'h57
`define ASCII_X 8'h58
`define ASCII_Y 8'h59
`define ASCII_Z 8'h5A

module KeyASCIIDecoder(
    input [8:0]key,
    input Caps,///大寫是1
    output reg [7:0]ASCII
    );
    reg [7:0]ASCII_;
    wire en;
    always@*
    case(key)
    `KEY_A: ASCII_ = `ASCII_A;
    `KEY_B: ASCII_ = `ASCII_B;
    `KEY_C: ASCII_ = `ASCII_C;
    `KEY_D: ASCII_ = `ASCII_D;
    `KEY_E: ASCII_ = `ASCII_E;
    `KEY_F: ASCII_ = `ASCII_F;
    `KEY_G: ASCII_ = `ASCII_G;
    `KEY_H: ASCII_ = `ASCII_H;
    `KEY_I: ASCII_ = `ASCII_I;
    `KEY_J: ASCII_ = `ASCII_J;
    `KEY_K: ASCII_ = `ASCII_K;
    `KEY_L: ASCII_ = `ASCII_L;
    `KEY_M: ASCII_ = `ASCII_M;
    `KEY_N: ASCII_ = `ASCII_N;
    `KEY_O: ASCII_ = `ASCII_O;
    `KEY_P: ASCII_ = `ASCII_P; 
    `KEY_Q: ASCII_ = `ASCII_Q;
    `KEY_R: ASCII_ = `ASCII_R;
    `KEY_S: ASCII_ = `ASCII_S;
    `KEY_T: ASCII_ = `ASCII_T;
    `KEY_U: ASCII_ = `ASCII_U;
    `KEY_V: ASCII_ = `ASCII_V;
    `KEY_W: ASCII_ = `ASCII_W;
    `KEY_X: ASCII_ = `ASCII_X;
    `KEY_Y: ASCII_ = `ASCII_Y;
    `KEY_Z: ASCII_ = `ASCII_Z;
    default: ASCII_ = 0;
    endcase
    ///大小寫
    assign en = (ASCII_ == 0) ? 1:0;
    always@*
    if(en)
        ASCII = 0;
    else if(Caps==1)
        ASCII = ASCII_;
   else
        ASCII = ASCII_ + 32;
        
    
endmodule
