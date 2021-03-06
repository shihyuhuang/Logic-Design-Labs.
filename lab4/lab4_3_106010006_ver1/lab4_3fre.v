module lab4_3fre(
fout, // divided clock output
clk, // global clock input
rst_n // active low reset
);
output fout; // divided output
input clk; // global clock input
input rst_n; // active low reset
reg [26:0] cnt_tmp,cnt;
reg clk_tmp,s_cnt,s_cnt_tmp; // input to dff (in always block)
always @(cnt)
if(cnt == 49999999) cnt_tmp <= 0;
else cnt_tmp <= cnt + 27'd1;
//clk_temp 0.5s
always @(cnt)
if(cnt == 49999999) clk_tmp <= 1;
else clk_tmp <= 0;
always @(s_cnt)
s_cnt_tmp <= ~s_cnt ;
assign fout = s_cnt;
//Flip flop with 0.5s freq
always @(posedge clk_tmp or negedge rst_n)
if (~rst_n) s_cnt <= 0;
else s_cnt <= s_cnt_tmp;
// Flip flops
always @(posedge clk or negedge rst_n)
if (~rst_n) cnt <= 27'b0;
else cnt <= cnt_tmp;
endmodule
