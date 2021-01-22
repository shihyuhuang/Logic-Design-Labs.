
`define  STAT_stop 0
`define  STAT_start 1
`define  STAT_resume 1
`define  STAT_pause 0
`define  EN  1
`define  DIS 0



module lab7_3_state_down(
clk_100, 
rst_n,
de_start_stop,
de_s_hour_pause_resume,
start_enable,
resume_enable,
count_up_down,
reset_down
);

output reg start_enable, resume_enable; 
input clk_100; 
input rst_n;
input count_up_down;
input [2:0] reset_down;
input de_start_stop, de_s_hour_pause_resume;
reg state1,state2; 
reg next_state1,next_state2; 


always @(posedge clk_100 or negedge rst_n)
 if (~rst_n)
 state1 <= `STAT_stop;
 else if (reset_down == 3'd2) 
 state1 <= `STAT_stop;
 else
 state1 <= next_state1;
 

always @*
if(count_up_down==1)begin
 case (state1)
 `STAT_stop:
      if (de_start_stop)
      begin
      next_state1 = `STAT_start;
      start_enable = `EN;
      end
      else
      begin
      next_state1 = `STAT_stop;
      start_enable = `DIS;
      end
 `STAT_start:
      if (de_start_stop)
      begin
      next_state1 = `STAT_stop;
      start_enable = `DIS;
      end
      else
      begin
      next_state1 = `STAT_start;
      start_enable = `EN;
      end default:
      begin
      next_state1 = `STAT_start;
      start_enable = `EN;
      end
endcase
end
else begin
next_state1 = `STAT_stop;
start_enable = `DIS;
end

always @(posedge clk_100 or negedge rst_n)
 if (~rst_n)
 state2 <= `STAT_resume;
 else
 state2 <= next_state2;
 

always @*
if (count_up_down==1)begin
 case (state2)
 `STAT_pause:
      if (de_s_hour_pause_resume)
      begin
      next_state2 = `STAT_resume;
      resume_enable = `EN;
      end
      else
      begin
      next_state2 = `STAT_pause;
      resume_enable = `DIS;
      end
 `STAT_resume:
      if (de_s_hour_pause_resume)
      begin
      next_state2 = `STAT_pause;
      resume_enable = `DIS;
      end
      else
      begin
      next_state2 = `STAT_resume;
      resume_enable = `EN;
      end default:
      begin
      next_state2 = `STAT_resume;
      resume_enable = `EN;
      end
endcase
end
else begin
next_state2 = `STAT_resume;
resume_enable = `EN;
end

endmodule
