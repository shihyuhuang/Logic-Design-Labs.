
module lab9_2_qclk(
clk_100,
clk,
rst
);
output clk_100; 
input clk; 
input rst;


reg [26:0] cnt_tmp,cnt;
reg clk_tmp3,s_cnt,s_cnt_tmp; 



always @*
if(cnt == 499) cnt_tmp = 0;
else cnt_tmp = cnt + 27'd1;

always @*
if(cnt == 499) 
clk_tmp3 = 1;
else 
clk_tmp3= 0;

always @*
s_cnt_tmp = ~s_cnt ;
assign clk_100 = s_cnt;

always @(posedge clk_tmp3 or posedge rst)
if (rst) s_cnt <= 0;
else s_cnt <= s_cnt_tmp;

always @(posedge clk or posedge rst)
if (rst) cnt <= 27'b0;
else cnt <= cnt_tmp;


endmodule