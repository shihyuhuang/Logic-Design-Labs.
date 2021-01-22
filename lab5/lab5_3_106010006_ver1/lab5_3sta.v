`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 18:29:09
// Design Name: 
// Module Name: lab5_3sta
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



`define  STAT_PAUSE 0
`define  STAT_COUNT 1
`define  STAT_30 0
`define  STAT_60 1
`define  ENABLED  1
`define  DISABLED 0
`define STAT_DEF 0
`define  thi  0
`define  six  1

module lab5_3sta(
 count_enable, // if counter is enabled
 count_enable2,
 in, //input control
 clk, // global clock signal
 mode,
 rst_n,
 stateled
);
// outputs
output count_enable; // if counter is enabled
output reg count_enable2;
output stateled;
// inputs
input clk; // global clock signal
input rst_n;
input in,mode; //input control
reg count_enable; // if counter is enabled
reg state,state2; // state of FSM
reg next_state,next_state2; // next state of FSM


 
lab5_3fre100hz U8 (.clk(clk),.rst_n(rst_n),.fout(clk_100));
lab5_3de U1 (.clk(clk),.rst_n(rst_n),.pb_in(in),.out_pulse(inde));
lab5_3de U6 (.clk(clk),.rst_n(rst_n),.pb_in(mode),.out_pulse(modede));

always @(posedge clk_100 or posedge rst_n)
 if (rst_n)
 state <= `STAT_PAUSE;
 else
 state <= next_state;
 
always @(posedge clk_100 or posedge rst_n)
 if (rst_n)
 state2 <= `STAT_30;
 else
 state2 <= next_state2;
 
// FSM state decision
always @*
 case (state2)
 `STAT_30:
 if (modede)
 begin
 next_state2 = `STAT_60;
 count_enable2 = `six;
 end
 else
 begin
 next_state2 = `STAT_30;
 count_enable2 = `thi;
 end
 `STAT_60:
 if (modede)
 begin
 next_state2 = `STAT_30;
 count_enable2 = `thi;
 end
 else
 begin
 next_state2 = `STAT_60;
 count_enable2 = `six;
 end 
 default:
 begin
 next_state2 = `STAT_DEF;
 count_enable2 = `thi;
 end
 endcase



// FSM state decision
always @*
 case (state)
 `STAT_PAUSE:
 if (inde)
 begin
 next_state = `STAT_COUNT;
 count_enable = `ENABLED;
 end
 else
 begin
 next_state = `STAT_PAUSE;
 count_enable = `DISABLED;
 end
 `STAT_COUNT:
 if (inde)
 begin
 next_state = `STAT_PAUSE;
 count_enable = `DISABLED;
 end
 else
 begin
 next_state = `STAT_COUNT;
 count_enable = `ENABLED;
 end default:
 begin
 next_state = `STAT_DEF;
 count_enable = `DISABLED;
 end
 endcase

assign stateled = state;

endmodule
