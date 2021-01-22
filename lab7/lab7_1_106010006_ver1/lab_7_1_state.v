
`define  STAT_PAUSE 0
`define  STAT_COUNT 1
`define  STAT_lap 1
`define  STAT_not_lap 0
`define  lap 1
`define  not_lap 0
`define  EN  1
`define  DIS 0



module lab7_1_state(
clk_100, 
rst_n,
de_lap_reset,
de_start_stop,
count_enable,
lap_enable,
reset
);

output reg count_enable;
output reg lap_enable; 
input clk_100; 
input rst_n;
input [2:0] reset;
input de_lap_reset, de_start_stop;
reg state1,state2; 
reg next_state1,next_state2; 



always @(posedge clk_100 or negedge rst_n)
 if (~rst_n)
 state2 <= `STAT_not_lap;
 else if (reset == 3'd2) 
 state2 <= `STAT_not_lap;
 else
 state2 <= next_state2;
 
always @*
 case (state2)
 `STAT_lap:
     if (de_lap_reset)
     begin
     next_state2 = `STAT_not_lap;
     lap_enable = `not_lap;
     end
     else
     begin
     next_state2 = `STAT_lap;
     lap_enable = `lap;
     end
 `STAT_not_lap:
     if (de_lap_reset)
     begin
     next_state2 = `STAT_lap;
     lap_enable = `lap;
     end
     else
     begin
     next_state2 = `STAT_not_lap;
     lap_enable = `not_lap;
     end 
  default:
     begin
     next_state2 = `STAT_lap;
     lap_enable = `lap;
     end
endcase


 
 always @(posedge clk_100 or negedge rst_n)
 if (~rst_n)
 state1 <= `STAT_PAUSE;
 else if (reset == 3'd2) 
 state1 <= `STAT_PAUSE;
 else
 state1 <= next_state1;
 

always @*
 case (state1)
 `STAT_PAUSE:
      if (de_start_stop)
      begin
      next_state1 = `STAT_COUNT;
      count_enable = `EN;
      end
      else
      begin
      next_state1 = `STAT_PAUSE;
      count_enable = `DIS;
      end
 `STAT_COUNT:
      if (de_start_stop)
      begin
      next_state1 = `STAT_PAUSE;
      count_enable = `DIS;
      end
      else
      begin
      next_state1 = `STAT_COUNT;
      count_enable = `EN;
      end 
 default:
      begin
      next_state1 = `STAT_PAUSE;
      count_enable = `DIS;
      end
endcase


endmodule
