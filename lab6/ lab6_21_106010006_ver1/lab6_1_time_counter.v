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


module lab6_2_time_counter(
clk_1,
qclk,
s_clk,
rst_n,
a,
b,
c,
d
);
input clk_1,qclk;
input s_clk;
input rst_n;
output [3:0] a,b,c,d;
reg clkch;
reg [3:0] mon1,mon2,day1,day2;
reg [3:0] m1_tmp,d1_tmp,m2_tmp,d2_tmp;


always@*
if(s_clk==0)
clkch = clk_1;
else
clkch = qclk;


always @(posedge clkch or negedge rst_n)
if (~rst_n)begin
mon1<= 4'd0;
mon2<= 4'd1;
day1<= 4'd0;
day2<= 4'd1;
end
else begin
mon1 <= m1_tmp;
mon2 <= m2_tmp;
day1 <= d1_tmp;
day2 <= d2_tmp;
end



always @*
if(((mon1==0)&&(mon2==1))|((mon1==0)&&(mon2==3))|((mon1==0)&&(mon2==5))|((mon1==0)&&(mon2==7))|((mon1==0)&&(mon2==8))|((mon1==1)&&(mon2==0))|((mon1==1)&&(mon2==2)))begin
        if((mon1==1)&&(mon2==2)&&(day1==3)&&(day2==1))begin
           m1_tmp = 0;
           m2_tmp = 4'd1;
           d1_tmp = 0; 
           d2_tmp = 4'd1;   
          end
        else if((day1==3)&&(day2==1))begin
                if(mon2==9)begin
                m1_tmp = mon1 + 4'd1;
                m2_tmp = 0;
                d1_tmp = 0;                
                d2_tmp = 4'd1;
                end
                else begin  
                m1_tmp = mon1;
                m2_tmp = mon2 + 4'd1;
                d1_tmp = 0; 
                d2_tmp = 4'd1;
              end 
         end
         else begin 
             if (day2==9)begin
                 m1_tmp = mon1;
                 m2_tmp = mon2;
                 d1_tmp = day1 + 4'd1;                 
                 d2_tmp = 0;
               end                            
             else begin 
              m1_tmp = mon1;
              m2_tmp = mon2;
              d1_tmp = day1; 
              d2_tmp = day2 + 4'd1; 
             end 
        end     
end    
else if(((mon1==0)&&(mon2==4))|((mon1==0)&&(mon2==6))|((mon1==0)&&(mon2==9))|((mon1==1)&&(mon2==1)))begin
        if ((day1==3)&&(day2==0))begin
                  if(mon2==9)begin
                    m1_tmp = mon1 + 4'd1;
                    m2_tmp = 0;
                    d1_tmp = 0;                
                    d2_tmp = 4'd1;
                    end
                  else begin  
                    m1_tmp = mon1;
                    m2_tmp = mon2 + 4'd1;
                    d1_tmp = 0; 
                    d2_tmp = 4'd1;
                 end
        end         
         else begin 
             if (day2==9)begin
                 m1_tmp = mon1;
                 m2_tmp = mon2;
                 d1_tmp = day1 + 4'd1;                 
                 d2_tmp = 0;
               end                            
             else begin 
              m1_tmp = mon1;
              m2_tmp = mon2;
              d1_tmp = day1; 
              d2_tmp = day2 + 4'd1 ; 
             end 
         end 
end            
else begin   
     if((day1==2)&&(day2==8))begin
             m1_tmp = mon1;
             m2_tmp = mon2 + 4'd1;
             d1_tmp = 0; 
             d2_tmp = 4'd1;
            end
            else begin 
                if (day2==9)begin
                         if(mon2==9)begin
                            m1_tmp = mon1 + 4'd1;
                            m2_tmp = 0;
                            d1_tmp = 0;                
                            d2_tmp = 4'd1;
                            end
                          else begin  
                           m1_tmp = mon1;
                           m2_tmp = mon2;
                           d1_tmp = day1 + 4'd1;                 
                           d2_tmp = 0;
                          end
                 end                            
                else begin 
                 m1_tmp = mon1;
                 m2_tmp = mon2;
                 d1_tmp = day1; 
                 d2_tmp = day2 + 4'd1 ; 
                end 
            end 
end      


assign a = mon1;
assign b = mon2;
assign c = day1;
assign d = day2;



endmodule

