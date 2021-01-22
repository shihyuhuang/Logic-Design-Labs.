`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 21:52:42
// Design Name: 
// Module Name: lab5_1debo
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


module lab5_2de(

clk, // clock control
rst_n, // reset
pb_in, //push button input
out_pulse // debounced push button output
);
// declare the I/Os
input clk; // clock control
input rst_n; // reset
input pb_in; //push button input
output out_pulse; // debounced push button output
reg pb_debounced; // debounced push button output
// declare the internal nodes
reg [3:0] debounce_window; // shift register flip flop
reg pb_debounced_next; // debounce result
// Shift register
reg out_pulse; // output one pulse
// Declare internal nodes
reg in_trig_delay;

lab5_2fre100hz U9 (.clk(clk),.rst_n(rst_n),.fout(clk_100));



always @(posedge clk_100 or posedge rst_n)
if (rst_n)
debounce_window <= 4'd0;
else
debounce_window <= {debounce_window[2:0], pb_in};
// debounce circuit
always @*
if (debounce_window == 4'b1111)
pb_debounced_next = 1'b1;
else
pb_debounced_next = 1'b0;
always @(posedge clk_100 or posedge rst_n)
if (rst_n)
pb_debounced <= 1'b0;
else
pb_debounced <= pb_debounced_next;

always @(posedge clk_100 or posedge rst_n)
if (rst_n)
in_trig_delay <= 1'b0;
else
in_trig_delay <= pb_debounced;
// Pulse generation
assign out_pulse_next = pb_debounced &
(~in_trig_delay);
always @(posedge clk_100 or posedge rst_n)
if (rst_n)
out_pulse <=1'b0;
else
out_pulse <= out_pulse_next;



endmodule