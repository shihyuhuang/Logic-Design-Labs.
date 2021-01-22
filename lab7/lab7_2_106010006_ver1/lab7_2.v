module lab7_2(
clk,
rst_n,
set,
start_stop,
pause_resume,
s_hour,
s_min,
BCD_dsp,
bit_dsp,
endled
);
input clk;
input rst_n;
input set, s_hour, s_min;
input start_stop;
input pause_resume;
output [7:0] BCD_dsp;
output [3:0] bit_dsp;
output [14:0] endled;
wire [3:0] h1, h2, m1, m2;
wire [3:0] l_h1, l_h2, l_m1, l_m2;
wire start_enable, resume_enable;
wire start_stop;
wire clk_1, clk_100;
wire de_start_stop, de_pause_resume;
wire [2:0] reset;

lab7_2_SSD U0 (.clk(clk),.rst_n(rst_n),.set(set),.h1(h1),.h2(h2),.m1(m1),.m2(m2),
.l_h1(l_h1),.l_h2(l_h2),.l_m1(l_m1),.l_m2(l_m2),.BCD_dsp(BCD_dsp),.bit_dsp(bit_dsp));
lab7_2_time_counter U1 (.clk_1(clk_1),.rst_n(rst_n),.set(set),.h1(h1),.h2(h2),.m1(m1),.m2(m2),.start_stop(start_stop),.reset(reset),
.l_h1(l_h1),.l_h2(l_h2),.l_m1(l_m1),.l_m2(l_m2),.start_enable(start_enable),.resume_enable(resume_enable),.endled(endled));
lab7_2_qclk U2 (.clk_1(clk_1),.clk_100(clk_100),.clk(clk),.rst_n(rst_n));
lab7_2_state U3 (.clk_100(clk_100),.rst_n(rst_n),.de_start_stop(de_start_stop),.de_pause_resume(de_pause_resume),
.start_enable(start_enable),.resume_enable(resume_enable),.reset(reset));
lab7_2_set_time U4 (.clk_1(clk_1),.rst_n(rst_n),.set(set),.s_hour(s_hour),.s_min(s_min),
.l_h1(l_h1),.l_h2(l_h2),.l_m1(l_m1),.l_m2(l_m2));
lab7_2_debounce U5 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(start_stop),.out_pulse(de_start_stop));
lab7_2_debounce U6 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(pause_resume),.out_pulse(de_pause_resume));

endmodule