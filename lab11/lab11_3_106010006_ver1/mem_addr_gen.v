`define brcik1_x 0
`define brcik1_y 0
`define brcik2_x 100                  
`define brcik2_y 0
`define brcik3_x 180                  
`define brcik3_y 0
`define brcik4_x 260                  
`define brcik4_y 0
`define brcik5_x 340                  
`define brcik5_y 0
`define brcik6_x 420                  
`define brcik6_y 0
`define brcik7_x 500                  
`define brcik7_y 0


module mem_addr_gen(
   input [2:0]brick,
   input [9:0]brick_x,
   input [9:0]brick_y,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output reg [16:0]pixel_addr,
   output reg vavid_in
   );
    reg [9:0]sx,sy;
    always@*
    if(h_cnt > 220 && h_cnt <= 420 && v_cnt > 40 && v_cnt <= 440 )begin//讓他在螢幕中間
        if(h_cnt > 220+brick_x && h_cnt <= 300+brick_x && v_cnt > 40+brick_y && v_cnt <= 80+brick_y)
            pixel_addr = sx + (v_cnt - brick_y - 40)*580 + (h_cnt - brick_x -220);
        else
            pixel_addr = 0;
        vavid_in = 1;
    end    
    else begin//讓超出遊戲範圍的都變黑色
        pixel_addr = 0;
        vavid_in = 0;
    end
    
    
    always@(brick)
    case(brick)
    3'b001:begin
        sx = `brcik1_x;
        sy = `brcik1_y;
    end
    3'b010:begin
        sx = `brcik2_x;
        sy = `brcik2_y;
    end
    3'b011:begin
        sx = `brcik3_x;
        sy = `brcik3_y;
    end
    3'b100:begin
        sx = `brcik4_x;
        sy = `brcik4_y;
    end
    3'b101:begin
        sx = `brcik5_x;
        sy = `brcik5_y;
    end
    3'b110:begin
        sx = `brcik6_x;
        sy = `brcik6_y;
    end
    3'b111:begin
        sx = `brcik7_x;
        sy = `brcik7_y;
    end
    default:begin
        sx = `brcik7_x;
        sy = `brcik7_y;
    end
    
    endcase
endmodule
