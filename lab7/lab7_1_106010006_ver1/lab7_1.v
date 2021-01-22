module lab7_1(
clk,
rst_n,
sqclk,
start_stop,
lap_reset,
BCD_dsp,
bit_dsp
);
input clk;
input rst_n;
input sqclk;
input start_stop;
input lap_reset;
output [7:0] BCD_dsp;
output [3:0] bit_dsp;
wire [3:0] a, b, c, d;
wire count_enable, lap_enable, lap_reset;
wire qclk, clk_100;
wire de_lap_reset, de_start_stop;
wire [2:0] reset;
 
lab7_1_SSD U0 (.clk(clk),.rst_n(rst_n),.a(a),.b(b),.c(c),.d(d),.BCD_dsp(BCD_dsp),.bit_dsp(bit_dsp));
lab7_1_time_counter U1 (.qclk(qclk),.rst_n(rst_n),.a(a),.b(b),.c(c),.d(d),
.count_enable(count_enable),.lap_enable(lap_enable),.lap_reset(lap_reset),.reset(reset));
lab7_1_qclk U2 (.fout1(qclk),.fout2(clk_100),.clk(clk),.rst_n(rst_n),.sqclk(sqclk));
lab7_1_state U3 (.de_lap_reset(de_lap_reset),.de_start_stop(de_start_stop),.clk_100(clk_100),.rst_n(rst_n),
.count_enable(count_enable),.lap_enable(lap_enable),.reset(reset));
lab7_1_debounce U4 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(start_stop),.out_pulse(de_start_stop));
lab7_1_debounce U5 (.clk_100(clk_100),.rst_n(rst_n),.pb_in(lap_reset),.out_pulse(de_lap_reset));

endmodule