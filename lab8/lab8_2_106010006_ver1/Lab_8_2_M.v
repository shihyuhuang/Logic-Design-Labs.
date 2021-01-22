`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/29 23:08:38
// Design Name: 
// Module Name: Lab_8_2_M
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
module Lab_8_2_M(
    
    input rst,
    input clk,
    
    input voice_up_btn,
    input voice_down_btn,
    input Do_btn,
    input Re_btn,
    input Mi_btn,
    
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    
    output [3:0]ssd,
    output [0:7]display
    
    );
    
    wire voice_up_btn_debounced;
    wire voice_down_btn_debounced;
    wire voice_up_btn_onepalse;
    wire voice_down_btn_onepalse;
    
    wire [15:0]audio_left;
    wire [15:0]audio_right;
    
    reg [3:0]audio_s;
    
    reg [15:0]audio_max;
    reg [15:0]audio_min;
    reg [15:0]audio_max_next;
    reg [15:0]audio_min_next;
    
    reg [21:0]tone;
    
    
    reg [3:0]digit_0;
    reg [3:0]digit_1;
    reg [3:0]digit,digit_next;
    
    reg audio_sdin;
    
    
    reg [30:0]cnt;
    reg [3:0]ssd;
    reg [0:7]display;
    
    debounced A0(.clk,.rst,.btn(voice_up_btn),.btn_out(voice_up_btn_debounced));
    debounced A1(.clk,.rst,.btn(voice_down_btn),.btn_out(voice_down_btn_debounced));
    onepalse A2(.clk,.rst,.push_debounced(voice_up_btn_debounced),.push_onepulse(voice_up_btn_onepalse));
    onepalse A3(.clk,.rst,.push_debounced(voice_down_btn_debounced),.push_onepulse(voice_down_btn_onepalse));
    

    
    assign audio_mclk = cnt[1];
    assign audio_sck = cnt[3];
    assign audio_lrck = cnt[8];
    

    always @(posedge clk) begin
        if(Do_btn)
            tone <= 22'd191571;
        else if(Re_btn)
            tone <= 22'd170648;
        else if(Mi_btn)
            tone <= 22'd151515;
        else
            tone <= 22'd0;
    end
    
    note_gun Ung ( .clk(clk), // clock from crystal
    .rst,
    .audio_max,
    .audio_min, // active low reset
    .note_div(tone), // div for note generation
    .audio_left, // left sound audio
    .audio_right // right sound audio
    );
    
    always@(posedge voice_up_btn_onepalse or posedge voice_down_btn_onepalse or posedge rst)begin
        if(rst) begin
            digit_next <= 4'd15;
            audio_min_next <= 16'h5FFF ;
            audio_max_next <= 16'hB000 ;
        end
        else if(voice_up_btn_onepalse == 1 && digit < 4'b1111) begin
            audio_min_next <= audio_min - 16'd1280;
            digit_next <= digit + 4'b0001;
        end
        else if(voice_down_btn_onepalse == 1 && digit > 4'd0) begin
            audio_min_next <= audio_min + 16'd1280;
            digit_next <= digit - 4'd0001;
        end
        else;
    end
    
    always @(posedge audio_sck)begin
        digit <= digit_next;
        audio_max <= audio_max_next;
        audio_min <= audio_min_next;
    end
    
    
    always @(posedge clk or posedge rst) begin
        if(cnt[19])
                ssd <= 4'b1110;
            else
                ssd <= 4'b1101;
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
   always @ (clk) begin
        digit_0 = digit % 10;
        digit_1 = digit / 10;
             if(ssd == 4'b1110) begin
                 case(digit_0)
                     4'd0: display = `SSD_ZERO;
                     4'd1: display = `SSD_ONE;
                     4'd2: display = `SSD_TWO;
                     4'd3: display = `SSD_THREE;
                     4'd4: display = `SSD_FOUR;
                     4'd5: display = `SSD_FIVE;
                     4'd6: display = `SSD_SIX;
                     4'd7: display = `SSD_SEVEN;
                     4'd8: display = `SSD_EIGHT;
                     4'd9: display = `SSD_NINE;
                     default: display = `SSD_DEF;
                 endcase
             end
             else if(ssd == 4'b1101) begin
                 case(digit_1)
                     4'd0: display = `SSD_ZERO;
                     4'd1: display = `SSD_ONE;
                     4'd2: display = `SSD_TWO;
                     4'd3: display = `SSD_THREE;
                     4'd4: display = `SSD_FOUR;
                     4'd5: display = `SSD_FIVE;
                     4'd6: display = `SSD_SIX;
                     4'd7: display = `SSD_SEVEN;
                     4'd8: display = `SSD_EIGHT;
                     4'd9: display = `SSD_NINE;
                     default: display = `SSD_DEF;
                 endcase
             end
         end
     
endmodule