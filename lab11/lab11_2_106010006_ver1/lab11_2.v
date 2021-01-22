`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/08 17:37:49
// Design Name: 
// Module Name: lab09_2
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

`define SHOW_A 2'b00
`define SHOW_B 2'b01
`define SHOW_F 2'b10

module lab11_2(
    input rst,
    input clk,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output [3:0]bit_dsp,
    output [7:0]BCD_dsp,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync    
    );
    //////////////input
    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid;
    KeyboardDecoder U0(.key_down(key_down),.last_change(last_change),
            .key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),
            .rst(rst),.clk(clk));
    //////////////set
    //decode last_change
    wire [3:0]now;
    key_BCD_decoder D2 (.key(last_change), .BCD(now));
    //////////���� a1,a0 ,b1,b0,now ,sign ,show_stat
    reg [8:0]a1_key,a0_key,b0_key,b1_key; 
    reg [8:0]sign_key; 
    wire a_en,sign_en;
    wire [3:0]a1,a0,b0,b1;    
    wire [3:0]sign;
    reg [1:0]show_stat;
    
    assign a_en = ((last_change == `KEY_S || last_change == `KEY_M ||last_change == `KEY_A) 
                    || show_stat == `SHOW_B || show_stat == `SHOW_F) ? 0:1;
    always@*
    if(sign_key == 0)
        show_stat <= `SHOW_A;
    else if(last_change == `KEY_ENT)
        show_stat <= `SHOW_F;
    else    
        show_stat <= `SHOW_B;
        
    always@(posedge key_down[last_change] or posedge rst)
    if (rst) begin
        a0_key <= 0;
        a1_key <= 0;
    end
    else if(a_en) begin
        a1_key <= a0_key;
        a0_key <= last_change;       
    end
    else begin
        a1_key <= a1_key;
        a0_key <= a0_key;       
    end
    
    assign b_en = ((last_change == `KEY_S || last_change == `KEY_M ||last_change == `KEY_A) 
                    || show_stat == `SHOW_A || show_stat == `SHOW_F) ? 0:1;
    always@(posedge key_down[last_change] or posedge rst)
    if (rst) begin
        b0_key <= 0;
        b1_key <= 0;
    end
    else if(b_en) begin
        b1_key <= b0_key;
        b0_key <= last_change;       
    end
    else begin
        b1_key <= b1_key;
        b0_key <= b0_key;       
    end
    
    assign sign_en = (last_change == `KEY_S || last_change == `KEY_M ||last_change == `KEY_A) ? 1:0;
    always@(posedge key_down[last_change] or posedge rst)
    if (rst) 
        sign_key <= 0;
        else if(sign_en) 
            sign_key <= last_change;
        else 
            sign_key <= sign_key;

    
    key_BCD_decoder D0 (.key(a0_key), .BCD(a0));
    key_BCD_decoder D1 (.key(a1_key), .BCD(a1));
    wire [3:0]sign_;
    key_BCD_decoder D5 (.key(sign_key), .BCD(sign_));
    assign sign =(sign_key == 0) ? `SSD_Z : sign_;
    key_BCD_decoder D3 (.key(b0_key), .BCD(b0));
    key_BCD_decoder D4 (.key(b1_key), .BCD(b1));
    ////////calculate
    //�[
    wire[3:0]f0_a,f1_a,f2_a,f3_a;
    wire f0_cry,f1_cry;
    decimal_adder A0 (.A(a0), .B(b0), .ci(0), .S(f0_a), .co(f0_cry));
    decimal_adder A1 (.A(a1), .B(b1), .ci(f0_cry), .S(f1_a), .co(f2_a[0]));
    assign f3_a = 0;
    
    //��
    wire[3:0]f0_s,f1_s,f2_s,f3_s;
    wire f0_brl,f1_brl,si;
    wire f0_brl_,f1_brl_,si_;
    wire [3:0]ff0,ff0_,ff1,ff1_;
    BCD_miner M0 (.a(a0), .b(b0), .c(0), .f(ff0), .borrow(f0_brl));// a0 - b0 = ff0
    BCD_miner M1 (.a(a1), .b(b1), .c(f0_brl), .f(ff1), .borrow(si));//a- b = ff 
    
    BCD_miner M2 (.a(b0), .b(a0), .c(0), .f(ff0_), .borrow(f0_brl_));// b0 - a0 = ff0
    BCD_miner M3 (.a(b1), .b(a1), .c(f0_brl_), .f(ff1_), .borrow(si_));//b- a = ff_ 
        

    assign f0_s = (si) ? ff0_ : ff0;
    assign f1_s = (si) ? ff1_ : ff1;
    assign f2_s = 0;
    assign f3_s = (si) ? `SSD_S : 0;
    
    //��
    wire[3:0]f0_m,f1_m,f2_m,f3_m;//////ab * cd 
    //              a a1   b a0
    //   *         c  b1  d b0
    //-----------------------
    //             bd1 bd0
    //       ad1 ad0
    //       cb1 cb0
    // ac1 ac0
    //--------------------------
    // 
    wire[3:0]bd0,bd1,ad0,ad1,cb0,cb1,ac0,ac1;
    decimal_muti T0 (.a(a0), .b(b0), .f1(bd1), .f0(bd0));
    decimal_muti T1 (.a(a1), .b(b0), .f1(ad1), .f0(ad0));
    decimal_muti T2 (.a(a0), .b(b1), .f1(cb1), .f0(cb0));
    decimal_muti T3 (.a(a1), .b(b1), .f1(ac1), .f0(ac0));
    
    wire [3:0]tmp1,tmp2,tmp3,tmp4;
    wire cry_tmp1,cry_tmp2,cry_tmp3,cry_tmp4,cry_tmp5,cry_tmp6;
    assign f0_m = bd0;
    decimal_adder T4 (.A(bd1), .B(ad0), .ci(0), .S(tmp1), .co(cry_tmp1));
    decimal_adder T5 (.A(tmp1), .B(cb0), .ci(0), .S(f1_m), .co(cry_tmp2));
     
    decimal_adder T6 (.A(ad1), .B(cry_tmp1), .ci(cry_tmp2), .S(tmp2), .co(cry_tmp3));
    decimal_adder T7 (.A(tmp2), .B(cb1), .ci(0), .S(tmp3), .co(cry_tmp4));
    decimal_adder T8 (.A(tmp3), .B(ac0), .ci(0), .S(f2_m), .co(cry_tmp5));
    
    assign tmp4 = cry_tmp3 + cry_tmp4 + cry_tmp5;
    decimal_adder T9 (.A(tmp4), .B(ac1), .ci(0), .S(f3_m), .co(cry_tmp6));
           
    ////�ھ� sign �M�w f
    reg [3:0]f0,f1,f2,f3;
    always@*
    case(sign)
    `SSD_A :begin
        f0 = f0_a;
        f1 = f1_a;
        f2 = f2_a;
        f3 = f3_a;
    end
    `SSD_S :begin
        f0 = f0_s;
        f1 = f1_s;
        f2 = f2_s;
        f3 = f3_s;
    end
    `SSD_M :begin
        f0 = f0_m;
        f1 = f1_m;
        f2 = f2_m;
        f3 = f3_m;
    end
    default:begin
        f0 = 0;
        f1 = 0;
        f2 = 0;
        f3 = 0;
    end
    endcase                  
    ///////output
    reg [3:0]dsp0,dsp1,dsp2,dsp3;
    always @*
    case(show_stat)
        `SHOW_A:begin
            dsp0 = a0;
            dsp1 = a1;
            dsp2 = 0;
            dsp3 = sign;
        end
        `SHOW_B:begin
            dsp0 = b0;
            dsp1 = b1;
            dsp2 = 0;
            dsp3 = sign;
        end
        `SHOW_F:begin
            dsp0 = f0;
            dsp1 = f1;
            dsp2 = f2;
            dsp3 = f3;
        end
        default:begin
            dsp0 = a0;
            dsp1 = a1;
            dsp2 = 0;
            dsp3 = sign;
        end
    endcase
    ssd_ctl C0 (.f_cst(clk),.rst(rst),.dsp0(dsp0),.dsp1(dsp1),.dsp2(dsp2),.dsp3(dsp3),
                 .BCD(BCD_dsp),.BCD_c(bit_dsp));        
    //////////////////////////////////////////////////////////////////////
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel :12'h0;
    wire is_scoll,clk_div;
    clock_divisor clk_wiz_0_inst(
        .clk(clk),
        .clk1(clk_25MHz),
        .clk22(clk_22)
    );
    mem_addr_gen G0(.dsp0(dsp0), .dsp1(dsp1), .dsp2(dsp2), .dsp3(dsp3), .h_cnt(h_cnt), .v_cnt(v_cnt), .pixel_addr(pixel_addr));
    
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(pixel)
    ); 
      vga_controller   vga_inst(
        .pclk(clk_25MHz),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
      );
    
    
endmodule
