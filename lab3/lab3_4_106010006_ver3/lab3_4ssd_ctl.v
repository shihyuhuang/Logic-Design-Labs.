`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/17 00:11:46
// Design Name: 
// Module Name: lab3_4ssd_ctl
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


module lab3_4ssd_ctl(
    input [7:0]dsp0,
    input [7:0]dsp1,
    input [7:0]dsp2,
    input [7:0]dsp3,
    input clk,
    output reg [7:0]BCD,
    output reg [3:0]BCD_c,
    input rst_n
    );
    
    //counter
    reg [19:0] cnt,cnt_tmp;    
    //+1
    always @(cnt)
        cnt_tmp <= cnt+1;        
    // Flip flops
    always @(posedge clk or negedge rst_n)
        if (~rst_n) cnt <= 19'b0;
        else cnt <= cnt_tmp;
    
    reg [7:0]BCD_tmp;
    wire [1:0]en;     
    assign en={cnt[19],cnt[18]};
                
    always @(en)
    case(en)
         2'b00: BCD = dsp0;
         2'b01: BCD = dsp1;
         2'b10: BCD = dsp2;
         2'b11: BCD = dsp3;
         default: BCD_tmp = 8'b11111111;
    endcase
    
    always @(en)
    case(en)
         2'b00: BCD_c = 4'b1110;
         2'b01: BCD_c = 4'b1101;
         2'b10: BCD_c = 4'b1011;
         2'b11: BCD_c = 4'b0111;
         default: BCD_tmp = 4'b0000;
    endcase

endmodule
