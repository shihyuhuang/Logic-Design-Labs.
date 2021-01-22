module lab7_3(
clk,
rst_n,
set,
start_stop,
s_hour_pause_resume,
s_min_lap_reset,
count_up_down,
BCD_dsp,
bit_dsp,
endled
);
input clk;
input rst_n;
input set, start_stop, s_hour_pause_resume, s_min_lap_reset, count_up_down;
output [7:0] BCD_dsp;
output [3:0] bit_dsp;
output [14:0] endled;
wire [3:0] h1, h2, m1_d, m2_d;
wire [3:0] f_h1, f_h2, f_m1, f_m2;
wire [3:0] m1_up, m2_up, s1_up, s2_up;
wire start_enable, resume_enable, lap_enable, count_enable;
wire clk_1, clk_100;
wire de_s_min_lap_reset, de_start_stop, de_s_hour_pause_resume;
wire [2:0] reset_up;
wire [2:0] reset_down;

lab7_3_SSD U0 (.clk(clk),.rst_n(rst_n),.set(set),.count_up_down(count_up_down),.h1(h1),.h2(h2),.m1_d(m1_d),.m2_d(m2_d),
.f_h1(f_h1),.f_h2(f_h2),.f_m1(f_m1),.f_m2(f_m2),.m1_up(m1_up),.m2_up(m2_up),.s1_up(s1_up),.s2_up(s2_up),
.BCD_dsp(BCD_dsp),.bit_dsp(bit_dsp));
lab7_3_time_counter_down U1 (.clk_1(clk_1),.rst_n(rst_n),.set(set),.h1(h1),.h2(h2),.m1_d(m1_d),.m2_d(m2_d),
.f_h1(f_h1),.f_h2(f_h2),.f_m1(f_m1),.f_m2(f_m2),.start_enable(start_enable),.resume_enable(resume_enable),
.count_up_down(count_up_down),.start_stop(start_stop),.endled(endled),.reset_down(reset_down));
lab7_3_time_counter_up U2 (.clk_1(clk_1),.rst_n(rst_n),.count_enable(count_enable),.lap_enable(lap_enable),.s_min_lap_reset(s_min_lap_reset),
.m1_up(m1_up),.m2_up(m2_up),.s1_up(s1_up),.s2_up(s2_up),.count_up_down(count_up_down),.reset_up(reset_up));
lab7_3_qclk U3 (.clk_1(clk_1),.clk_100(clk_100),.clk(clk),.rst_n(rst_n));
lab7_3_state_down U4 (.clk_100(clk_100),.rst_n(rst_n),.de_start_stop(de_start_stop),.de_s_hour_pause_resume(de_s_hour_pause_resume),
.start_enable(start_enable),.resume_enable(resume_enable),.count_up_down(count_up_down),.reset_down(reset_down));
lab7_3_state_up U5 (.clk_100(clk_100),.rst_n(rst_n),.de_start_stop(de_start_stop),.de_s_min_lap_reset(de_s_min_lap_reset),
.count_enable(count_enable),.lap_enable(lap_enable),.count_up_down(count_up_down),.reset_up(reset_up));
lab7_3_set_time U6 (.clk_1(clk_1),.rst_n(rst_n),.set(set),.s_hour_pause_resume(s_hour_pause_resume),.s_min_lap_reset(s_min_lap_reset),
.count_up_down(count_up_down),.f_h1(f_h1),.f_h2(f_h2),.f_m1(f_m1),.f_m2(f_m2));
lab7_3_debounce U7 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(s_hour_pause_resume),.out_pulse(de_s_hour_pause_resume));
lab7_3_debounce U8 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(s_min_lap_reset),.out_pulse(de_s_min_lap_reset));
lab7_3_debounce U9 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(start_stop),.out_pulse(de_start_stop));

endmodule