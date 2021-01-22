
`define  STAT_stop 0
`define  STAT_start 1
`define  STAT_resume 1
`define  STAT_pause 0
`define  EN  1
`define  DIS 0



module lab7_2_state(
clk_100, 
rst_n,
de_start_stop,
de_pause_resume,
start_enable,
resume_enable,
reset
);

output reg start_enable, resume_enable; 
input clk_100; 
input rst_n;
input [2:0] reset;
input de_start_stop, de_pause_resume;
reg state1,state2; 
reg next_state1,next_state2; 


always @(posedge clk_100 or negedge rst_n)
 if (~rst_n)
 state1 <= `STAT_stop;
 else if (reset == 3'd2) 
 state1 <= `STAT_stop;
 else
 state1 <= next_state1;
 

always @*
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


always @(posedge clk_100 or negedge rst_n)
 if (~rst_n)
 state2 <= `STAT_resume;
 else
 state2 <= next_state2;
 

always @*
 case (state2)
 `STAT_pause:
      if (de_pause_resume)
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
      if (de_pause_resume)
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

endmodule
