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
`define KEY_ENT {1'b0 , 8'hE05A}
`define SSD_A 4'd10
`define SSD_S 4'd11
`define SSD_M 4'd12
`define SSD_ent 4'd13
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


module lab9_3(
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
    wire [3:0] s1,s2,s3,s4;
    reg [7:0]A1,A2,B1,B2,C1,C2,S1,S2,S3,S4,ASM;
    wire push;
    
    reg [19:0] cnt,cnt_tmp;
    wire [1:0] cl;
reg [3:0]in;
reg [6:0] a1,a2,b1,b2;
reg [14:0] sum,sum_tmp;
reg [6:0] a,b;
reg [4:0]en,en_tmp;    
reg [1:0]op,op_tmp; 
        
KeyboardDecoder U0(.key_down(key_down),.last_change(last_change),
        .key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),
        .rst(rst),.clk(clk));

lab9_3_qclk U2 (.clk_100(clk_100),.clk(clk),.rst(rst));
lab9_3_debounce U1 (.clk_100(clk_100),.rst(rst),.pb_in(key_down[last_change]),.out_pulse(push));




 always@*
         case(last_change)
        `KEY_0:in = 0;
        `KEY_1:in = 1;
        `KEY_2:in = 2;
        `KEY_3:in = 3;
        `KEY_4:in = 4;
        `KEY_5:in = 5;
        `KEY_6:in = 6;
        `KEY_7:in = 7;
        `KEY_8:in = 8;
        `KEY_9:in = 9;
        `KEY_A:in = `SSD_A;
        `KEY_S:in = `SSD_S;
        `KEY_M:in = `SSD_M; 
        `KEY_ENT:in = `SSD_ent;
        default:in = 14;        
        endcase  
     


always @(posedge key_down[last_change] or posedge rst)
if (rst)begin
en <= 5'd0;
end
else begin
en <= en_tmp;
end

always @*
if((en==0)&&((in==10)||(in==11)||(in==12)))
en_tmp = en+5'd1;
else if(in==`SSD_ent)
en_tmp = en+5'd1;
else
en_tmp=en;



 always@(posedge key_down[last_change] or posedge rst)
    if (rst) begin
        a1 <= 0;
        a2 <= 0;
    end
    else if((en==0)&&(in!==10)&&(in!==11)&&(in!==12)&&(in!==13)&&(in!==14)) begin
        a2 <= a1;
        a1 <= in;       
    end
    else begin
        a2 <= a2;
        a1 <= a1;       
    end


 always@(posedge key_down[last_change] or posedge rst)
    if (rst) begin
        b1 <= 0;
        b2 <= 0;
    end
    else if((en==1)&&(in!==10)&&(in!==11)&&(in!==12)&&(in!==13)&&(in!==14)) begin
        b2 <= b1;
        b1 <= in;       
    end
    else begin
        b2 <= b2;
        b1 <= b1;       
    end





 always@(posedge clk or posedge rst)
    if (rst) begin
        a <= 0;
        b <= 0;
    end
    else begin
        a<= 10*a2+a1;
        b<= 10*b2+b1;   
    end



always @(posedge key_down[last_change] or posedge rst)
if(rst)
 op<= 0;
else
op<=op_tmp;

always@*
if(in==`SSD_M)
op_tmp=1;
else if (in==`SSD_A)
op_tmp=2;
else if (in==`SSD_S)
op_tmp=3;
else 
op_tmp=op;


always@*
if(op==1)
sum=a*b;
else if(op==2)
sum=a+b;
else begin
   if (a>b)
    sum=a-b;
   else 
   sum=b-a;
 end  






assign s4 = sum/1000;
assign s3 = sum/100%10;
assign s2 = sum/10%10;
assign s1 = sum%10;


always @*
case (in)
4'd10: ASM = `SS_A;
4'd11: ASM = `SS_S;
4'd12: ASM = `SS_M;
default: ASM = `SS_F;
endcase

always @*
case (a1)
6'd0: A1 = `SS_0;
6'd1: A1 = `SS_1;
6'd2: A1 = `SS_2;
6'd3: A1 = `SS_3;
6'd4: A1 = `SS_4;
6'd5: A1 = `SS_5;
6'd6: A1 = `SS_6;
6'd7: A1 = `SS_7;
6'd8: A1 = `SS_8;
6'd9: A1 = `SS_9;
default: A1 = `SS_F;
endcase

always @*
case (a2)
6'd0: A2 = `SS_0;
6'd1: A2 = `SS_1;
6'd2: A2 = `SS_2;
6'd3: A2 = `SS_3;
6'd4: A2 = `SS_4;
6'd5: A2 = `SS_5;
6'd6: A2 = `SS_6;
6'd7: A2 = `SS_7;
6'd8: A2 = `SS_8;
6'd9: A2 = `SS_9;
default: A2 = `SS_F;
endcase

always @*
case (b1)
6'd0: B1 = `SS_0;
6'd1: B1 = `SS_1;
6'd2: B1 = `SS_2;
6'd3: B1 = `SS_3;
6'd4: B1 = `SS_4;
6'd5: B1 = `SS_5;
6'd6: B1 = `SS_6;
6'd7: B1 = `SS_7;
6'd8: B1 = `SS_8;
6'd9: B1 = `SS_9;
default: B1 = `SS_F;
endcase


always @*
case (b2)
6'd0: B2 = `SS_0;
6'd1: B2 = `SS_1;
6'd2: B2 = `SS_2;
6'd3: B2 = `SS_3;
6'd4: B2 = `SS_4;
6'd5: B2 = `SS_5;
6'd6: B2 = `SS_6;
6'd7: B2 = `SS_7;
6'd8: B2 = `SS_8;
6'd9: B2 = `SS_9;
default: B2 = `SS_F;
endcase


always @*
case (s1)
4'd0: S1 = `SS_0;
4'd1: S1 = `SS_1;
4'd2: S1 = `SS_2;
4'd3: S1 = `SS_3;
4'd4: S1 = `SS_4;
4'd5: S1 = `SS_5;
4'd6: S1 = `SS_6;
4'd7: S1 = `SS_7;
4'd8: S1 = `SS_8;
4'd9: S1 = `SS_9;
default: S1 = `SS_F;
endcase

always @*
case (s2)
4'd0: S2 = `SS_0;
4'd1: S2 = `SS_1;
4'd2: S2 = `SS_2;
4'd3: S2 = `SS_3;
4'd4: S2 = `SS_4;
4'd5: S2 = `SS_5;
4'd6: S2 = `SS_6;
4'd7: S2 = `SS_7;
4'd8: S2 = `SS_8;
4'd9: S2 = `SS_9;
default: S2 = `SS_F;
endcase

always @*
case (s3)
4'd0: S3 = `SS_0;
4'd1: S3 = `SS_1;
4'd2: S3 = `SS_2;
4'd3: S3 = `SS_3;
4'd4: S3 = `SS_4;
4'd5: S3 = `SS_5;
4'd6: S3 = `SS_6;
4'd7: S3 = `SS_7;
4'd8: S3 = `SS_8;
4'd9: S3 = `SS_9;
default: S3 = `SS_F;
endcase

always @*
case (s4)
4'd0: S4 = `SS_0;
4'd1: S4 = `SS_1;
4'd2: S4 = `SS_2;
4'd3: S4 = `SS_3;
4'd4: S4 = `SS_4;
4'd5: S4 = `SS_5;
4'd6: S4 = `SS_6;
4'd7: S4 = `SS_7;
4'd8: S4 = `SS_8;
'd9: S4 = `SS_9;
default: S4 = `SS_F;
endcase


always @*
cnt_tmp = cnt+1;

always @(posedge clk or posedge rst)
if (rst) cnt <= 20'b0;
else cnt <= cnt_tmp;

assign cl= cnt[19:18];

always @*
if (in==`SSD_ent)begin
     if(a>b)begin
case(cl)
2'd0: BCD_dsp = S1;
2'd1: BCD_dsp = S2;
2'd2: BCD_dsp = S3;
default: BCD_dsp = S4;
endcase
       end
      else begin
      case(cl)
      2'd0: BCD_dsp = S1;
      2'd1: BCD_dsp = S2;
      2'd2: BCD_dsp = S3;
      default: BCD_dsp = 8'b11111101;
      endcase
end
end
else if ((in==`SSD_A)||(in==`SSD_S)||(in==`SSD_M))begin
case(cl)
2'd0: BCD_dsp = ASM;
2'd1: BCD_dsp =  `SS_0;
2'd2: BCD_dsp =  `SS_0;
default: BCD_dsp =  `SS_0;
endcase
end
else if (en==0) begin
case(cl)
2'd0: BCD_dsp =  A1;
2'd1: BCD_dsp =  A2;
2'd2: BCD_dsp = `SS_0;
default: BCD_dsp = `SS_0;
endcase
end
else begin
case(cl)
2'd0: BCD_dsp =  B1;
2'd1: BCD_dsp =  B2;
2'd2: BCD_dsp = `SS_0;
default: BCD_dsp = `SS_0;
endcase
end




always @*
case(cl)
2'd0: bit_dsp = 4'b1110;
2'd1: bit_dsp = 4'b1101;
2'd2: bit_dsp = 4'b1011;
default: bit_dsp = 4'b0111;
endcase


endmodule

