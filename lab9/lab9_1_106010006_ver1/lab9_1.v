
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
`define SS_S 8'b01001001
`define SS_M 8'b00010011
`define SS_A 8'b00010001

`define KEY_0 {1'b0 , 8'h45}
`define KEY_1 {1'b0 , 8'h16}
`define KEY_2 {1'b0 , 8'h1E}
`define KEY_3 {1'b0 , 8'h26}
`define KEY_4 {1'b0 , 8'h25}
`define KEY_5 {1'b0 , 8'h2E}
`define KEY_6 {1'b0 , 8'h36}
`define KEY_7 {1'b0 , 8'h3D}
`define KEY_8 {1'b0 , 8'h3E}
`define KEY_9 {1'b0 , 8'h46}
`define KEY_A {1'b0 , 8'h1C}
`define KEY_S {1'b0 , 8'h1B}
`define KEY_M {1'b0 , 8'h3A}
`define KEY_ENT {1'b0 , 8'h5A}

`define SSD_A 4'b1010
`define SSD_S 4'b1011
`define SSD_M 4'b1100
`define SSD_ent 4'b1101

module lab9_1(
    input rst,
    input clk,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output reg [3:0]bit_dsp,
    output wire [7:0]BCD_dsp
    );

    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid;
    reg [3:0]a;
    reg [7:0]A;

    KeyboardDecoder U0(.key_down(key_down),.last_change(last_change),
        .key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),
        .rst(rst),.clk(clk));



 always@(posedge key_down[last_change] or posedge rst)
    if (rst)
        a <= 0;
    else begin
       case(last_change)
        `KEY_0:a <= 0;
        `KEY_1:a <= 1;
        `KEY_2:a <= 2;
        `KEY_3:a <= 3;
        `KEY_4:a <= 4;
        `KEY_5:a <= 5;
        `KEY_6:a <= 6;
        `KEY_7:a <= 7;
        `KEY_8:a <= 8;
        `KEY_9:a <= 9;
        `KEY_A:a <= `SSD_A;
        `KEY_S:a <= `SSD_S;
        `KEY_M:a <= `SSD_M; 
        `KEY_ENT:a <= `SSD_ent;                
        default:a <= 0;
        endcase  
     end 

always @*
case (a)
4'd0: A = `SS_0;
4'd1: A = `SS_1;
4'd2: A = `SS_2;
4'd3: A = `SS_3;
4'd4: A = `SS_4;
4'd5: A = `SS_5;
4'd6: A = `SS_6;
4'd7: A = `SS_7;
4'd8: A = `SS_8;
4'd9: A = `SS_9;
4'd10: A = `SS_A;
4'd11: A = `SS_S;
4'd12: A = `SS_M;
default: A = `SS_F;
endcase

        
assign BCD_dsp = A;

always @*
if(a==`SSD_ent)
bit_dsp = 4'b1111;
else
bit_dsp = 4'b1110;

endmodule