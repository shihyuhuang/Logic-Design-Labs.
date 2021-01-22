`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/13 15:33:01
// Design Name: 
// Module Name: lab09_3
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


module lab11_3(
    input rst,
    input clk,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output [15:0]test_LED,
    output hsync,
    output vsync        
    );
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire clk_20HZ;
    freq_div A0(.rst(rst), .f_cst(clk), .freq(2499999), .fout(clk_20HZ));
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire vavid_in;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1 && vavid_in==1) ? pixel :12'h0;
    clock_divisor clk_wiz_0_inst(
        .clk(clk),
        .clk1(clk_25MHz),
        .clk22(clk_22)
    );
    wire [2:0]brick;
    wire [9:0]brick_x;
    reg [9:0]brick_y;
    wire [9:0]brick_y_tmp;
    
    wire in;
    assign test_LED[15] = in;
    assign in = (rst==1 || brick_y==400)? 1:0;
    always@(posedge clk_20HZ or posedge rst)
        if(rst==1 || brick_y==400)
            brick_y <=0;
        else 
            brick_y <= brick_y_tmp;    
    assign brick_y_tmp = brick_y+1;
    assign test_LED[12:3] = brick_y;
    random_num_gen U0(.clk(clk), .in(in), .f(brick));
    assign brick_x = 60;
    //counter
    
    assign test_LED[2:0] = brick;
    
    mem_addr_gen G0(.brick(brick+1), .brick_x(brick_x), .brick_y(brick_y), .h_cnt(h_cnt), .v_cnt(v_cnt), .pixel_addr(pixel_addr), .vavid_in(vavid_in));
    
    blk_mem_gen_1 blk_mem_gen_1_inst(
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
