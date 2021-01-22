`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/29 20:59:04
// Design Name: 
// Module Name: Lab_8_1_M
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

`define SSD_ZERO 8'b0000001_1 // 0
`define SSD_ONE 8'b1001111_1 // 1
`define SSD_TWO 8'b0010010_1 // 2
`define SSD_THREE 8'b0000110_1 // 3
`define SSD_FOUR 8'b1001100_1 // 4
`define SSD_FIVE 8'b0100100_1 // 5
`define SSD_SIX 8'b0100000_1 // 6
`define SSD_SEVEN 8'b0001111_1 // 7
`define SSD_EIGHT 8'b0000000_1 // 8
`define SSD_NINE 8'b0000100_1 // 9
`define SSD_DEF 8'b0111000_1 // default

module Lab_8_1_M(
input rst,
input clk,
output audio_mclk,
output audio_lrck,
output audio_sck,
output audio_sdin
);

reg audio_sdin;
reg [3:0]audio_s;
reg [30:0]cnt;
wire [15:0]audio_left;
wire [15:0]audio_right;
       
frequency_divider U0(.rst,.clk,.x(2),.clk_out(audio_mclk));
frequency_divider U1(.rst,.clk,.x(4),.clk_out(audio_sck));
frequency_divider U2(.rst,.clk,.x(9),.clk_out(audio_lrck));

  note_gun U3 (
  .clk(clk), // clock from crystal
  .rst, // active low reset
  .note_div(22'd191571), // div for note generation
  .audio_left, // left sound audio
  .audio_right // right sound audio
    );

      always @(posedge clk or posedge rst) begin
        if(rst) begin
            cnt <= 30'd0;
        end
        else begin
                cnt <= cnt + 1;
        end
        audio_s <= cnt[7:4];
    end

    always @(clk)begin
        if(audio_lrck)begin
            case(audio_s)
            4'd0 : audio_sdin <= audio_right[15];
            4'd1 : audio_sdin <= audio_right[14];
            4'd2 : audio_sdin <= audio_right[13];
            4'd3 : audio_sdin <= audio_right[12];
            4'd4 : audio_sdin <= audio_right[11];
            4'd5 : audio_sdin <= audio_right[10];
            4'd6 : audio_sdin <= audio_right[9];
            4'd7 : audio_sdin <= audio_right[8];
            4'd8 : audio_sdin <= audio_right[7];
            4'd9 : audio_sdin <= audio_right[6];
            4'd10 : audio_sdin <= audio_right[5];
            4'd11 : audio_sdin <= audio_right[4];
            4'd12 : audio_sdin <= audio_right[3];
            4'd13 : audio_sdin <= audio_right[2];
            4'd14 : audio_sdin <= audio_right[1];
            4'd15 : audio_sdin <= audio_right[0];
            endcase
        end
        else if(~audio_lrck)begin
            case(audio_s)
            4'd0 : audio_sdin <= audio_left[15];
            4'd1 : audio_sdin <= audio_left[14];
            4'd2 : audio_sdin <= audio_left[13];
            4'd3 : audio_sdin <= audio_left[12];
            4'd4 : audio_sdin <= audio_left[11];
            4'd5 : audio_sdin <= audio_left[10];
            4'd6 : audio_sdin <= audio_left[9];
            4'd7 : audio_sdin <= audio_left[8];
            4'd8 : audio_sdin <= audio_left[7];
            4'd9 : audio_sdin <= audio_left[6];
            4'd10 : audio_sdin <= audio_left[5];
            4'd11 : audio_sdin <= audio_left[4];
            4'd12 : audio_sdin <= audio_left[3];
            4'd13 : audio_sdin <= audio_left[2];
            4'd14 : audio_sdin <= audio_left[1];
            4'd15 : audio_sdin <= audio_left[0];
            endcase
        end
    end
  
     
    
endmodule
