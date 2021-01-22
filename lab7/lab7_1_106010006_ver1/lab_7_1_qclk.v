
module lab7_1_qclk(
fout1,
fout2,
clk,
rst_n,
sqclk
);
output reg fout1;
output fout2; 
input clk; 
input rst_n;
input sqclk;
reg [26:0] ant_tmp,ant;
reg clk_tmp1,s_ant,s_ant_tmp; 
reg [26:0] bnt_tmp,bnt;
reg clk_tmp2,s_bnt,s_bnt_tmp; 
reg [26:0] cnt_tmp,cnt;
reg clk_tmp3,s_cnt,s_cnt_tmp; 
wire out1, out2;





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

assign out1 = s_ant;

always @(posedge clk_tmp1 or negedge rst_n)
if (~rst_n) 
s_ant <= 0;
else
s_ant <= s_ant_tmp;

always @(posedge clk or negedge rst_n)
if (~rst_n) ant <= 27'b0;
else ant <= ant_tmp;


always @*
if(bnt == 1000000) bnt_tmp = 0;
else bnt_tmp = bnt + 27'd1;

always @*
if(bnt == 1000000) 
clk_tmp2 = 1;
else
clk_tmp2 = 0;

always @*
s_bnt_tmp = ~s_bnt ;
assign out2 = s_bnt;

always @(posedge clk_tmp2 or negedge rst_n)
if (~rst_n) 
s_bnt <= 0;
else 
s_bnt <= s_bnt_tmp;

always @(posedge clk or negedge rst_n)
if (~rst_n) bnt <= 27'b0;
else bnt <= bnt_tmp;


always@*
if(sqclk ==0)
fout1 = out1;
else
fout1 = out2;


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

assign fout2 = s_cnt;

always @(posedge clk_tmp3 or negedge rst_n)
if (~rst_n) s_cnt <= 0;
else s_cnt <= s_cnt_tmp;

always @(posedge clk or negedge rst_n)
if (~rst_n) cnt <= 27'b0;
else cnt <= cnt_tmp;


endmodule