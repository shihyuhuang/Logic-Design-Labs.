`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/10 21:58:44
// Design Name: 
// Module Name: lab2_3
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


module lab2_2(
input [3:0]i,
output [3:0]d,
output reg [7:0]D_ssd
    );
/*與上一題一樣，定義7-seg，只是增加了A~E*/
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
    `define SS_A 8'b00010001
    `define SS_B 8'b00000001
    `define SS_C 8'b01100011
    `define SS_D 8'b00000011 
    `define SS_E 8'b01100001
    `define SS_F 8'b01110001

    /*多工器增加了10~14的選項定義為A~E*/
    always @*
     case (i)
     4'd0: D_ssd = `SS_0;
     4'd1: D_ssd = `SS_1;
     4'd2: D_ssd = `SS_2;
     4'd3: D_ssd = `SS_3;
     4'd4: D_ssd = `SS_4;
     4'd5: D_ssd = `SS_5;
     4'd6: D_ssd = `SS_6;
     4'd7: D_ssd = `SS_7;
     4'd8: D_ssd = `SS_8;
     4'd9: D_ssd = `SS_9;
     4'd10: D_ssd = `SS_A;
     4'd11: D_ssd = `SS_B;
     4'd12: D_ssd = `SS_C;
     4'd13: D_ssd = `SS_D;
     4'd14: D_ssd = `SS_E;
     default: D_ssd = `SS_F;
     endcase
/*將input i設定給output d控制4個led燈來顯示input*/     
assign d[0] = i[0];
assign d[1] = i[1];
assign d[2] = i[2];
assign d[3] = i[3];
      
endmodule

