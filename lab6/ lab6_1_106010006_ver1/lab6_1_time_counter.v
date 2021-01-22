`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 21:50:16
// Design Name: 
// Module Name: lab6_1_time_counter
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


module lab6_1_time_counter(
clk_1,
qclk,
s_12_24,
s_clk,
s_hm_s,
rst_n,
a,
b,
c,
d,
led
);
input clk_1,qclk;
input s_12_24,s_clk,s_hm_s;
input rst_n;
output reg led;
output reg [3:0] a,b,c,d;
reg clkch;
reg [3:0] h1,h2,m1,m2,s1,s2;
reg [3:0] c24_h1,c24_h2,c24_m1,c24_m2,c24_s1,c24_s2;
reg [3:0] c12_h1,c12_h2,c12_m1,c12_m2,c12_s1,c12_s2;
reg [3:0] c24_h1_tmp,c24_h2_tmp,c24_m1_tmp,c24_m2_tmp,c24_s1_tmp,c24_s2_tmp;
reg [3:0] c12_h1_tmp,c12_h2_tmp,c12_m1_tmp,c12_m2_tmp,c12_s1_tmp,c12_s2_tmp;

always@*
if(s_clk==0)
clkch = clk_1;
else
clkch = qclk;


always @(posedge clkch or negedge rst_n)
if (~rst_n)begin
c24_h1<= 0;
c24_h2<= 0;
c24_m1<= 0;
c24_m2<= 0;
c24_s1<= 0; 
c24_s2<= 0;
end
else begin
c24_h1 <= c24_h1_tmp;
c24_h2 <= c24_h2_tmp;
c24_m1 <= c24_m1_tmp;
c24_m2 <= c24_m2_tmp;
c24_s1 <= c24_s1_tmp;
c24_s2 <= c24_s2_tmp;
end


always @(posedge clkch or negedge rst_n)
if (~rst_n)begin
c12_h1<= 4'd1;
c12_h2<= 4'd2;
c12_m1<= 0;
c12_m2<= 0;
c12_s1<= 0; 
c12_s2<= 0;
end
else begin
c12_h1 <= c12_h1_tmp;
c12_h2 <= c12_h2_tmp;
c12_m1 <= c12_m1_tmp;
c12_m2 <= c12_m2_tmp;
c12_s1 <= c12_s1_tmp;
c12_s2 <= c12_s2_tmp;
end


always @*
if(c24_s2==9)begin
         if(c24_s1==5)begin
                  if(c24_m2==9)begin
                           if(c24_m1==5)begin
                                     if((c24_h1==2)&&(c24_h2==3))begin
                                        c24_h1_tmp = 0;
                                        c24_h2_tmp = 0;
                                        c24_m1_tmp = 0; 
                                        c24_m2_tmp = 0;
                                        c24_s1_tmp = 0;
                                        c24_s2_tmp = 0;
                                       end
                                      else if(c24_h2==9)begin
                                        c24_h1_tmp = c24_h1 + 4'd1;
                                        c24_h2_tmp = 0;
                                        c24_m1_tmp = 0; 
                                        c24_m2_tmp = 0;
                                        c24_s1_tmp = 0;
                                        c24_s2_tmp = 0;
                                        end
                                      else begin
                                        c24_h1_tmp = c24_h1;
                                        c24_h2_tmp = c24_h2 + 4'd1;
                                        c24_m1_tmp = 0; 
                                        c24_m2_tmp = 0;
                                        c24_s1_tmp = 0;
                                        c24_s2_tmp = 0;
                                       end
                           end
                          else begin
                           c24_h1_tmp = c24_h1;
                           c24_h2_tmp = c24_h2;
                           c24_m1_tmp = c24_m1 + 4'd1; 
                           c24_m2_tmp = 0;
                           c24_s1_tmp = 0;
                           c24_s2_tmp = 0;
                          end
                  end
                 else begin
                  c24_h1_tmp = c24_h1;
                  c24_h2_tmp = c24_h2;
                  c24_m1_tmp = c24_m1; 
                  c24_m2_tmp = c24_m2 + 4'd1;
                  c24_s1_tmp = 0;
                  c24_s2_tmp = 0;
                 end
         end
       else begin
        c24_h1_tmp = c24_h1;
        c24_h2_tmp = c24_h2;
        c24_m1_tmp = c24_m1; 
        c24_m2_tmp = c24_m2;
        c24_s1_tmp = c24_s1 + 4'd1;
        c24_s2_tmp = 0;
       end                
end
else begin
c24_h1_tmp = c24_h1;
c24_h2_tmp = c24_h2;
c24_m1_tmp = c24_m1;  
c24_m2_tmp = c24_m2;
c24_s1_tmp = c24_s1;
c24_s2_tmp = c24_s2 + 4'd1;
end



always @*
if ((c12_h1==1)&&(c12_h2==2))begin
 c12_h1_tmp = 0;
 c12_h2_tmp = 0;
 c12_m1_tmp = 0; 
 c12_m2_tmp = 0;
 c12_s1_tmp = 0;
 c12_s2_tmp = c12_s2 + 4'd1;
end
else begin
         if(c12_s2==9)begin
                      if(c12_s1==5)begin
                               if(c12_m2==9)begin
                                        if(c12_m1==5)begin
                                                if((c12_h1==1)&&(c12_h2==1))begin
                                                  c12_h1_tmp = 4'd1;
                                                  c12_h2_tmp = 4'd2;
                                                  c12_m1_tmp = 0; 
                                                  c12_m2_tmp = 0;
                                                  c12_s1_tmp = 0;
                                                  c12_s2_tmp = 0;
                                                 end
                                                else if(c12_h2==9)begin
                                                  c12_h1_tmp = c12_h1 + 4'd1;
                                                  c12_h2_tmp = 0;
                                                  c12_m1_tmp = 0; 
                                                  c12_m2_tmp = 0;
                                                  c12_s1_tmp = 0;
                                                  c12_s2_tmp = 0;
                                                 end
                                                else begin
                                                 c12_h1_tmp = c12_h1;
                                                 c12_h2_tmp = c12_h2 + 4'd1;
                                                 c12_m1_tmp = 0; 
                                                 c12_m2_tmp = 0;
                                                 c12_s1_tmp = 0;
                                                 c12_s2_tmp = 0;
                                                 end
                                         end
                                        else begin
                                          c12_h1_tmp = c12_h1;
                                          c12_h2_tmp = c12_h2;
                                          c12_m1_tmp = c12_m1 + 4'd1; 
                                          c12_m2_tmp = 0;
                                          c12_s1_tmp = 0;
                                          c12_s2_tmp = 0;
                                         end
                                 end
                                else begin
                                  c12_h1_tmp = c12_h1;
                                  c12_h2_tmp = c12_h2;
                                  c12_m1_tmp = c12_m1; 
                                  c12_m2_tmp = c12_m2 + 4'd1;
                                  c12_s1_tmp = 0;
                                  c12_s2_tmp = 0;
                                 end
                        end
                       else begin
                        c12_h1_tmp = c12_h1;
                        c12_h2_tmp = c12_h2;
                        c12_m1_tmp = c12_m1; 
                        c12_m2_tmp = c12_m2;
                        c12_s1_tmp = c12_s1 + 4'd1;
                        c12_s2_tmp = 0;
                       end                
             end
      else begin
         c12_h1_tmp = c12_h1;
         c12_h2_tmp = c12_h2;
         c12_m1_tmp = c12_m1;  
         c12_m2_tmp = c12_m2;
         c12_s1_tmp = c12_s1;
         c12_s2_tmp = c12_s2 + 4'd1;
     end
end

always @*
if(s_12_24==0)begin
 h1 = c24_h1;
 h2 = c24_h2;
 m1 = c24_m1;
 m2 = c24_m2;
 s1 = c24_s1;
 s2 = c24_s2;
 end
else begin
h1 = c12_h1;
h2 = c12_h2;
m1 = c12_m1;
m2 = c12_m2;
s1 = c12_s1;
s2 = c12_s2;
end


always @*
if(s_hm_s==0)begin
 a = 0;
 b = 0;
 c = s1;
 d = s2;
 end
else begin
 a = h1;
 b = h2;
 c = m1;
 d = m2;
end

always@*
if(s_12_24==1)begin
      if(c24_h1 >= 2)
      led=1;
      else if((c24_h1 >= 1)&&(c24_h2 >= 2))begin
       led =1;
       end
      else begin
       led=0; 
       end
end
else
led=0;   


endmodule

