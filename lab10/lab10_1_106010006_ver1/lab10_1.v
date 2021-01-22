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

module lab10_1(
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
wire clk_1;
reg [21:0]tone;
reg [3:0]a;
       
lab10_1_frequency_divider U0(.rst(rst),.clk(clk),.x(2),.clk_out(audio_mclk));
lab10_1_frequency_divider U1(.rst(rst),.clk(clk),.x(4),.clk_out(audio_sck));
lab10_1_frequency_divider U2(.rst(rst),.clk(clk),.x(9),.clk_out(audio_lrck));
lab10_1_fre1hz U3(.rst(rst),.clk(clk),.fout(clk_1));

  lab10_1_note_gun U4 (
  .clk(clk), // clock from crystal
  .rst(rst), // active low reset
  .note_div(tone), // div for note generation
  .audio_left(audio_left), // left sound audio
  .audio_right(audio_right) // right sound audio
    );





   always@*
           case(a)
            4'd0: tone = 22'd227273; 
            4'd1: tone = 22'd204082; 
            4'd2: tone = 22'd191571; 
            4'd3: tone = 22'd170648; 
            4'd4: tone = 22'd151515; 
            4'd5: tone = 22'd143266; 
            4'd6: tone = 22'd127551; 
            4'd7: tone = 22'd113636; 
            4'd8: tone = 22'd101215; 
            4'd9: tone = 22'd95420; 
            4'd10: tone = 22'd85034; 
            4'd11: tone = 22'd75758; 
            4'd12: tone = 22'd71633; 
            default: tone = 22'd63776; 
      endcase

  always @(posedge clk_1 or posedge rst) 
        if(rst) begin
            a <= 4'd0;
        end
        else begin 
          if(a==13)
            a <= 4'd0;
        else 
            a <= a + 1;
        end



      always @(posedge clk or posedge rst) begin
        if(rst) begin
            cnt <= 30'd0;
        end
        else begin
                cnt <= cnt + 1;
        end
        audio_s <= cnt[7:4];
    end

    always @*
     begin
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