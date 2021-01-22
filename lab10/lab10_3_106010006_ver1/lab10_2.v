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
`define SS_F 8'b01110001
`define KEY_a {1'b0 , 8'h1C}
`define KEY_b {1'b0 , 8'h32}
`define KEY_c {1'b0 , 8'h21}
`define KEY_d {1'b0 , 8'h23}
`define KEY_e {1'b0 , 8'h24}
`define KEY_f {1'b0 , 8'h2B}
`define KEY_g {1'b0 , 8'h34}
`define KEY_SFT {1'b0 , 8'h12}
`define KEY_CAP_LOCK {1'b0 , 8'h58}
`define A_c 4'd0
`define A_d 4'd1
`define A_e 4'd2
`define A_f 4'd3
`define A_g 4'd4
`define A_a 4'd5
`define A_b 4'd6

module lab10_2(
rst,
clk,
audio_mclk,
audio_lrck,
audio_sck,
audio_sdin,
PS2_DATA,
PS2_CLK,
bit_dsp,
BCD_dsp,
mode
);
input rst;
input clk,mode;
output audio_mclk,audio_lrck,audio_sck;
output reg [3:0]bit_dsp;
output reg [7:0]BCD_dsp;
output reg audio_sdin;
reg [3:0]audio_s;
reg [30:0]bnt;
wire [15:0]audio_left,audio_left2;
wire [15:0]audio_right,audio_right2;
wire clk_1;
reg [7:0]S1,S2;
reg [21:0]tone,tone2;
reg [4:0]in;
reg [4:0]in1,in2;
reg [19:0] cnt,cnt_tmp;
wire [1:0] cl;
inout PS2_DATA;
inout PS2_CLK;
 wire [511:0]key_down;
   wire [8:0]last_change;
   wire key_valid;
  
   reg caps_lock,caps;
   reg [7:0]ASCII_;     
          
lab10_2_frequency_divider U0(.rst(rst),.clk(clk),.x(2),.clk_out(audio_mclk));
lab10_2_frequency_divider U1(.rst(rst),.clk(clk),.x(4),.clk_out(audio_sck));
lab10_2_frequency_divider U2(.rst(rst),.clk(clk),.x(9),.clk_out(audio_lrck));

  lab10_2_note_gun U3 (
  .clk(clk), // clock from crystal
  .rst(rst), // active low reset
  .note_div(tone), // div for note generation
  .audio_left(audio_left), // left sound audio
  .audio_right(audio_right) // right sound audio
    );
    
  lab10_2_note_gun U4 (
     .clk(clk), // clock from crystal
     .rst(rst), // active low reset
     .note_div(tone2), // div for note generation
     .audio_left(audio_left2), // left sound audio
     .audio_right(audio_right2) // right sound audio
       );
 
    
KeyboardDecoder U5(.key_down(key_down),.last_change(last_change),
            .key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),
            .rst(rst),.clk(clk));



    always@(posedge key_down[`KEY_CAP_LOCK] or posedge rst)
    if(rst)
        caps_lock <= 0;
    else
        caps_lock <= ~caps_lock;
       
    always@*
    if((caps_lock==1 && key_down[`KEY_SFT]==0) || (caps_lock==0 && key_down[`KEY_SFT]==1))
        caps = 1;
    else
        caps = 0;
 
 always@(posedge key_down[last_change] or posedge rst)
           if (rst)
              ASCII_  <= 15;
           else begin
             case(last_change)
            `KEY_a: ASCII_ = `A_a;
            `KEY_b: ASCII_ = `A_b;
            `KEY_c: ASCII_ = `A_c;
            `KEY_d: ASCII_ = `A_d;
            `KEY_e: ASCII_ = `A_e;
            `KEY_f: ASCII_ = `A_f;
            `KEY_g: ASCII_ = `A_g;
            default: ASCII_ = 15;
            endcase
            end 
 

    always@*
    if(caps==1)
        in = ASCII_;
     else
        in = ASCII_ +7;

 always@*
        case(last_change)
            `KEY_c: tone2 = 22'd191571;
            `KEY_d: tone2 = 22'd170648;
            `KEY_e: tone2 = 22'd151515;
            `KEY_f: tone2 =  22'd143266;
            `KEY_g: tone2 =  22'd143266;
            default: tone2 = 0;
            endcase
            


   always@*
           case(in)
            5'd0: tone = 22'd227273; 
            5'd1: tone = 22'd204082; 
            5'd2: tone = 22'd191571; 
            5'd3: tone = 22'd170648; 
            5'd4: tone = 22'd151515; 
            5'd5: tone = 22'd143266; 
            5'd6: tone = 22'd127551; 
            5'd7: tone = 22'd113636; 
            5'd8: tone = 22'd101215; 
            5'd9: tone = 22'd95420; 
            5'd10: tone = 22'd85034; 
            5'd11: tone = 22'd75758; 
            5'd12: tone = 22'd71633; 
            5'd13: tone = 22'd6377; 
            default: tone = 22'd0; 
      endcase


      always @(posedge clk or posedge rst) begin
        if(rst) begin
            bnt <= 30'd0;
        end
        else begin
                bnt <= bnt + 1;
        end
        audio_s <= bnt[7:4];
    end

    always @*
      if(mode==0)begin
        if(audio_lrck)begin
            case(audio_s)
            4'd0 : audio_sdin <= audio_right2[15];
            4'd1 : audio_sdin <= audio_right2[14];
            4'd2 : audio_sdin <= audio_right2[13];
            4'd3 : audio_sdin <= audio_right2[12];
            4'd4 : audio_sdin <= audio_right2[11];
            4'd5 : audio_sdin <= audio_right2[10];
            4'd6 : audio_sdin <= audio_right2[9];
            4'd7 : audio_sdin <= audio_right2[8];
            4'd8 : audio_sdin <= audio_right2[7];
            4'd9 : audio_sdin <= audio_right2[6];
            4'd10 : audio_sdin <= audio_right2[5];
            4'd11 : audio_sdin <= audio_right2[4];
            4'd12 : audio_sdin <= audio_right2[3];
            4'd13 : audio_sdin <= audio_right2[2];
            4'd14 : audio_sdin <= audio_right2[1];
            4'd15 : audio_sdin <= audio_right2[0];
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
  else begin
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
always@*
if((in==15)|(in==22))begin
in1=0;
in2=10;
end
else begin
 in1 =in/10;
 in2 =in%10;
end

always @*
case (in1)
5'd0: S1 = `SS_0;
5'd1: S1 = `SS_1;
5'd2: S1 = `SS_2;
5'd3: S1 = `SS_3;
5'd4: S1 = `SS_4;
5'd5: S1 = `SS_5;
5'd6: S1 = `SS_6;
5'd7: S1 = `SS_7;
5'd8: S1 = `SS_8;
5'd9: S1 = `SS_9;
default: S1 = `SS_F;
endcase

always @*
case (in2)
5'd0: S2 = `SS_0;
5'd1: S2 = `SS_1;
5'd2: S2 = `SS_2;
5'd3: S2 = `SS_3;
5'd4: S2 = `SS_4;
5'd5: S2 = `SS_5;
5'd6: S2 = `SS_6;
5'd7: S2 = `SS_7;
5'd8: S2 = `SS_8;
5'd9: S2 = `SS_9;
default: S2 = `SS_F;
endcase



always @*
cnt_tmp = cnt+1;

always @(posedge clk or posedge rst)
if (rst) cnt <= 20'b0;
else cnt <= cnt_tmp;

assign cl= cnt[19:18];

always @*
case(cl)
2'd0: BCD_dsp = S2;
2'd1: BCD_dsp = S1;
2'd2: BCD_dsp = 0;
default: BCD_dsp = 0;
endcase


always @*
case(cl)
2'd0: bit_dsp = 4'b1110;
2'd1: bit_dsp = 4'b1101;
2'd2: bit_dsp = 4'b1111;
default: bit_dsp = 4'b1111;
endcase



endmodule