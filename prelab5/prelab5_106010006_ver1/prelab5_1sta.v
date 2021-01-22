`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 20:59:32
// Design Name: 
// Module Name: prelab5_1sta
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
`define  ENABLED  1
`define  DISABLED 0
`define STAT_DEF 0

module prelab5_1sta(
 count_enable, // if counter is enabled
 in, //input control
 clk, // global clock signal
 rst_n, // low active reset
 stateled
);
// outputs
output count_enable; // if counter is enabled
output stateled;
// inputs
input clk; // global clock signal
input rst_n; // low active reset
input in; //input control
reg count_enable; // if counter is enabled
reg state; // state of FSM
reg next_state; // next state of FSM
reg [19:0] cnt,cnt_tmp;
always @(posedge clk or posedge rst_n)
 if (rst_n)
 state <= `STAT_PAUSE;
 else
 state <= next_state;
 
// FSM state decision
always @*
 case (state)
 `STAT_PAUSE:
 if (in)
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
 if (in)
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

