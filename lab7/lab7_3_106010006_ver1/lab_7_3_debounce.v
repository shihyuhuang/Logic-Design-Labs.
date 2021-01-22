
module lab7_3_debounce(
clk_100,
rst_n, 
pb_in, 
out_pulse 
);

input clk_100; 
input rst_n; 
input pb_in; 
output out_pulse; 
reg pb_debounced; 
reg [3:0] debounce_window; 
reg pb_debounced_next; 
reg out_pulse; 
reg in_trig_delay;
wire out_pulse_next;


always @(posedge clk_100 or negedge rst_n)
if (~rst_n)
debounce_window <= 4'd0;
else
debounce_window <= {debounce_window[2:0], pb_in};

always @*
if (debounce_window == 4'b1111)
pb_debounced_next = 1'b1;
else
pb_debounced_next = 1'b0;
always @(posedge clk_100 or negedge rst_n)
if (~rst_n)
pb_debounced <= 1'b0;
else
pb_debounced <= pb_debounced_next;

always @(posedge clk_100 or negedge rst_n)
if (~rst_n)
in_trig_delay <= 1'b0;
else
in_trig_delay <= pb_debounced;

assign out_pulse_next = pb_debounced &
(~in_trig_delay);
always @(posedge clk_100 or negedge rst_n)
if (~rst_n)
out_pulse <=1'b0;
else
out_pulse <= out_pulse_next;


endmodule

