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


module lab6_2_2time_counter(
qclk,
rst_n,
mon1,mon2,day1,day2,year1,year2
);
input qclk;
input rst_n;
output reg [3:0] mon1,mon2,day1,day2,year1,year2;
reg [3:0] m1_tmp,d1_tmp,m2_tmp,d2_tmp,y1_tmp,y2_tmp;


always @(posedge qclk or negedge rst_n)
if (~rst_n)begin
year1<= 4'd0;
year2<= 4'd0;
mon1<= 4'd0;
mon2<= 4'd1;
day1<= 4'd0;
day2<= 4'd1;
end
else begin
year1 <= y1_tmp;
year2 <= y2_tmp;
mon1 <= m1_tmp;
mon2 <= m2_tmp;
day1 <= d1_tmp;
day2 <= d2_tmp;
end


always @*
if(((mon1==0)&&(mon2==1))|((mon1==0)&&(mon2==3))|((mon1==0)&&(mon2==5))|((mon1==0)&&(mon2==7))|((mon1==0)&&(mon2==8))|((mon1==1)&&(mon2==0))|((mon1==1)&&(mon2==2)))begin
        if((mon1==1)&&(mon2==2)&&(day1==3)&&(day2==1))begin
                 if((year1==9)&&(year2==9))begin
                  y1_tmp = 0;
                  y2_tmp = 0;
                  m1_tmp = 0;
                  m2_tmp = 4'd1;
                  d1_tmp = 0; 
                  d2_tmp = 4'd1;  
                 end
                else if((year1!==9)&&(year2==9))begin
                  y1_tmp = year1 + 4'd1;
                  y2_tmp = 0;
                  m1_tmp = 0;
                  m2_tmp = 4'd1;
                  d1_tmp = 0; 
                  d2_tmp = 4'd1; 
                end
               else begin
                 y1_tmp = year1;
                 y2_tmp = year2 + 4'd1;
                 m1_tmp = 0;
                 m2_tmp = 4'd1;
                 d1_tmp = 0; 
                 d2_tmp = 4'd1;     
               end
          end
        else if((day1==3)&&(day2==1))begin
               if(mon2==9)begin
                y1_tmp = year1;
                y2_tmp = year2;
                m1_tmp = mon1 + 4'd1;
                m2_tmp = 0;
                d1_tmp = 0;                
                d2_tmp = 4'd1;
                end
                else begin  
                y1_tmp = year1;
                y2_tmp = year2;
                m1_tmp = mon1;
                m2_tmp = mon2 + 4'd1;
                d1_tmp = 0; 
                d2_tmp = 4'd1;
              end 
         end
         else begin 
             if (day2==9)begin
                 y1_tmp = year1;
                 y2_tmp = year2;
                 m1_tmp = mon1;
                 m2_tmp = mon2;
                 d1_tmp = day1 + 4'd1;                 
                 d2_tmp = 0;
               end                            
             else begin 
              y1_tmp = year1;
              y2_tmp = year2;
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
                    y1_tmp = year1;
                    y2_tmp = year2;
                    m1_tmp = mon1 + 4'd1;
                    m2_tmp = 0;
                    d1_tmp = 0;                
                    d2_tmp = 4'd1;
                    end
                  else begin  
                    y1_tmp = year1;
                    y2_tmp = year2;
                    m1_tmp = mon1;
                    m2_tmp = mon2 + 4'd1;
                    d1_tmp = 0; 
                    d2_tmp = 4'd1;
                 end
        end         
         else begin 
             if (day2==9)begin
                 y1_tmp = year1;
                 y2_tmp = year2;
                 m1_tmp = mon1;
                 m2_tmp = mon2;
                 d1_tmp = day1 + 4'd1;                 
                 d2_tmp = 0;
               end                            
             else begin 
              y1_tmp = year1;
              y2_tmp = year2;
              m1_tmp = mon1;
              m2_tmp = mon2;
              d1_tmp = day1; 
              d2_tmp = day2 + 4'd1 ; 
             end 
         end 
end            
else begin   
     if((day1==2)&&(day2==8))begin
             y1_tmp = year1;
             y2_tmp = year2;
             m1_tmp = mon1;
             m2_tmp = mon2 + 4'd1;
             d1_tmp = 0; 
             d2_tmp = 4'd1;
            end
            else begin 
                if (day2==9)begin
                         if(mon2==9)begin
                            y1_tmp = year1;
                            y2_tmp = year2;
                            m1_tmp = mon1 + 4'd1;
                            m2_tmp = 0;
                            d1_tmp = 0;                
                            d2_tmp = 4'd1;
                            end
                          else begin
                           y1_tmp = year1;
                           y2_tmp = year2;  
                           m1_tmp = mon1;
                           m2_tmp = mon2;
                           d1_tmp = day1 + 4'd1;                 
                           d2_tmp = 0;
                          end
                 end                            
                else begin
                 y1_tmp = year1;
                 y2_tmp = year2; 
                 m1_tmp = mon1;
                 m2_tmp = mon2;
                 d1_tmp = day1; 
                 d2_tmp = day2 + 4'd1 ; 
                end 
            end 
end      

 


endmodule

