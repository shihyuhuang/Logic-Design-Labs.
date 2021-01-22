
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





`define  STAT_a 0
`define  STAT_b 1



module lab9_1(
    input rst,
    input clk,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output reg [3:0]bit_dsp,
    output reg [7:0]BCD_dsp
    );

    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid;
    reg [4:0]a,b,in,a_tmp,b_tmp;
    wire [4:0]c,c1,c2;
    reg [7:0]A,B,C,D;
    wire push;
    reg state,next_state;
    reg [1:0]give;
    
    reg [19:0] cnt,cnt_tmp;
    wire [1:0] cl;
        
    KeyboardDecoder U0(.key_down(key_down),.last_change(last_change),
        .key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),
        .rst(rst),.clk(clk));

lab9_2_debounce U1 (.clk_100(clk_100),.rst(rst),.pb_in(key_down[last_change]),.out_pulse(push));
lab9_2_qclk U2 (.clk_100(clk_100),.clk(clk),.rst(rst));

 always@(posedge key_down[last_change] or posedge rst)
    if (rst)
       in <= 0;
    else begin
       case(last_change)
        `KEY_0:in <= 0;
        `KEY_1:in <= 1;
        `KEY_2:in <= 2;
        `KEY_3:in <= 3;
        `KEY_4:in <= 4;
        `KEY_5:in <= 5;
        `KEY_6:in <= 6;
        `KEY_7:in <= 7;
        `KEY_8:in <= 8;
        `KEY_9:in <= 9;
        default:in <= 10;
        endcase  
     end 

always @(posedge clk_100 or posedge rst)
 if (rst)
 state <= `STAT_a;
 else
 state <= next_state;
 
always @*
 case (state)
 `STAT_a:
     if ((push==1)&&(in!==10))
     begin
     next_state = `STAT_b;
     give= 2'd1 ;
     end
     else
     begin
     next_state = `STAT_a;
     give = 0;
     end
 `STAT_b:
     if  ((push==1)&&(in!==10))
     begin
     next_state = `STAT_a;
     give=2'd2 ;
     end
     else
     begin
     next_state = `STAT_b;
     give=0;
     end 
  default:
     begin
     next_state = `STAT_a;
     give = 0;
     end
endcase

always @(posedge clk or posedge rst)
if (rst) begin 
a <= 0;
b <= 0;
end
else begin
 a <= a_tmp;
 b <= b_tmp;
 end
 
 always@*
 if (give==0)begin
 a_tmp= a;
 b_tmp=b;
 end
 else if(give==1)
begin
a_tmp=in;
b_tmp=0;
end
else begin
a_tmp=a;
b_tmp=in;
end





assign c = a+b;
assign c1 = c/10;
assign c2 = c%10;


always @*
case (a)
5'd0: A = `SS_0;
5'd1: A = `SS_1;
5'd2: A = `SS_2;
5'd3: A = `SS_3;
5'd4: A = `SS_4;
5'd5: A = `SS_5;
5'd6: A = `SS_6;
5'd7: A = `SS_7;
5'd8: A = `SS_8;
5'd9: A = `SS_9;
default: A = `SS_F;
endcase

always @*
case (b)
5'd0: B = `SS_0;
5'd1: B = `SS_1;
5'd2: B = `SS_2;
5'd3: B = `SS_3;
5'd4: B = `SS_4;
5'd5: B = `SS_5;
5'd6: B = `SS_6;
5'd7: B = `SS_7;
5'd8: B = `SS_8;
5'd9: B = `SS_9;
default: B = `SS_F;
endcase

always @*
case (c1)
5'd0: C = `SS_0;
5'd1: C = `SS_1;
default: C = `SS_F;
endcase

always @*
case (c2)
5'd0: D = `SS_0;
5'd1: D = `SS_1;
5'd2: D = `SS_2;
5'd3: D = `SS_3;
5'd4: D = `SS_4;
5'd5: D = `SS_5;
5'd6: D = `SS_6;
5'd7: D = `SS_7;
5'd8: D = `SS_8;
5'd9: D = `SS_9;
default: D = `SS_F;
endcase


always @*
cnt_tmp = cnt+1;

always @(posedge clk or posedge rst)
if (rst) cnt <= 20'b0;
else cnt <= cnt_tmp;

assign cl= cnt[19:18];

always @*
case(cl)
2'd0: BCD_dsp = D;
2'd1: BCD_dsp = C;
2'd2: BCD_dsp = B;
default: BCD_dsp = A;
endcase

always @*
case(cl)
2'd0: bit_dsp = 4'b1110;
2'd1: bit_dsp = 4'b1101;
2'd2: bit_dsp = 4'b1011;
default: bit_dsp = 4'b0111;
endcase


endmodule