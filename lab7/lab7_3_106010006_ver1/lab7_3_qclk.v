
module lab7_3_qclk(
clk_1,
clk_100,
clk,
rst_n
);
output clk_1, clk_100; 
input clk; 
input rst_n;
reg [26:0] ant_tmp,ant;
reg clk_tmp1,s_ant,s_ant_tmp; 

reg [26:0] cnt_tmp,cnt;
reg clk_tmp3,s_cnt,s_cnt_tmp; 




always @*
if(ant == 49999999) ant_tmp = 0;
else ant_tmp = ant + 27'd1;

always @*
if(ant == 49999999) 
clk_tmp1 = 1;
else 
clk_tmp1 = 0;

always @*
s_ant_tmp = ~s_ant ;
assign clk_1 = s_ant;

always @(posedge clk_tmp1 or negedge rst_n)
if (~rst_n) 
s_ant <= 0;
else
s_ant <= s_ant_tmp;

always @(posedge clk or negedge rst_n)
if (~rst_n) ant <= 27'b0;
else ant <= ant_tmp;




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

always @(posedge clk_tmp3 or negedge rst_n)
if (~rst_n) s_cnt <= 0;
else s_cnt <= s_cnt_tmp;

always @(posedge clk or negedge rst_n)
if (~rst_n) cnt <= 27'b0;
else cnt <= cnt_tmp;


endmodule