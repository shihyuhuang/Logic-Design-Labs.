`define DISABLED 1'b0
`define ENABLED 1'b1


module lab7_3_time_counter_up(
clk_1,
rst_n,
count_enable,
lap_enable,
s_min_lap_reset,
count_up_down,
m1_up, 
m2_up, 
s1_up, 
s2_up,
reset_up
);
input clk_1;
input rst_n;
input s_min_lap_reset;
input count_up_down;
input count_enable, lap_enable;
output reg [3:0] m1_up, m2_up, s1_up, s2_up;
reg [3:0] m1, m2, s1, s2;
reg [3:0] l_m1, l_m2, l_s1, l_s2;
reg [3:0] m1_tmp, m2_tmp, s1_tmp, s2_tmp;
reg [3:0] l_m1_tmp, l_m2_tmp, l_s1_tmp, l_s2_tmp;
reg borrow1, borrow2, borrow3, borrow4;
output reg [2:0] reset_up;
reg [2:0] reset_tmp;

always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) m1 <= 4'd0;
else m1 <= m1_tmp;

always @* 
if (reset_up == 3'd2)begin
m1_tmp = 4'd0;
borrow4 = `ENABLED; 
end
else if (count_up_down ==1)begin
m1_tmp = 4'd0;
borrow4 = `ENABLED; 
end
else if (m1 == 4'd5 && borrow3) begin
m1_tmp = 4'd0;
borrow4 = `ENABLED; 
end
else if (m1 !== 4'd5 && borrow3) begin
m1_tmp = m1 + 4'd1;
borrow4 = `DISABLED; 
end
else begin
m1_tmp = m1; 
borrow4 = `DISABLED;
end

always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) m2 <= 4'd0;
else m2 <= m2_tmp;

always @*
if (reset_up == 3'd2)begin
m2_tmp = 4'd0;
borrow3 = `DISABLED;
end
else if (count_up_down ==1)begin
m2_tmp = 4'd0;
borrow3 = `DISABLED; 
end
else if (m2 == 4'd9 && borrow2) begin
m2_tmp = 4'd0;
borrow3 = `ENABLED; 
end
else if (m2 !== 4'd9 && borrow2) begin
m2_tmp = m2 + 4'd1;
borrow3 = `DISABLED; 
end
else begin
m2_tmp = m2; 
borrow3 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) s1 <= 4'd0;
else s1 <= s1_tmp;

always @*
if (reset_up == 3'd2) begin
s1_tmp = 4'd0;
borrow2 = `DISABLED;
end
else if (count_up_down ==1)begin
s1_tmp = 4'd0;
borrow2 = `DISABLED; 
end
else if (s1 == 4'd5 && borrow1) begin
s1_tmp = 4'd0;
borrow2 = `ENABLED; 
end
else if (s1 !== 4'd5 && borrow1) begin
s1_tmp = s1 + 4'd1;
borrow2 = `DISABLED; 
end
else begin
s1_tmp = s1; 
borrow2 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) s2 <= 4'd0;
else s2 <= s2_tmp;

always @*
if (reset_up == 3'd2)begin
s2_tmp = 4'd0;
borrow1 = `DISABLED;
end
else if (count_up_down ==1)begin
s2_tmp = 4'd0;
borrow1 = `DISABLED; 
end
else if (s2 == 4'd9 && count_enable) begin
s2_tmp = 4'd0;
borrow1 = `ENABLED; 
end
else if (s2 !== 4'd9 && count_enable) begin
s2_tmp = s2 + 4'd1;
borrow1 = `DISABLED; 
end
else begin
s2_tmp = s2; 
borrow1 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n)
if (~rst_n)begin
reset_up <= 3'd0;
end
else begin
reset_up <= reset_tmp;
end

always @*
if(s_min_lap_reset == 1)
reset_tmp = reset_up + 3'd1;
else
reset_tmp = 0;


 

   
always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) begin
l_m1 <= 4'd0;
l_m2 <= 4'd0;
l_s1 <= 4'd0;
l_s2 <= 4'd0;
end
else begin
l_m1 <= l_m1_tmp;
l_m2 <= l_m2_tmp;
l_s1 <= l_s1_tmp;
l_s2 <= l_s2_tmp;
end

always @* 
if (lap_enable == 0) begin
l_m1_tmp = m1;
l_m2_tmp = m2;
l_s1_tmp = s1;
l_s2_tmp = s2;
end
else  begin
l_m1_tmp = l_m1;
l_m2_tmp = l_m2;
l_s1_tmp = l_s1;
l_s2_tmp = l_s2;
end

always@*
if(lap_enable == 0)begin
m1_up = m1;
m2_up = m2;
s1_up = s1;
s2_up = s2;
end
else begin
m1_up = l_m1;
m2_up = l_m2;
s1_up = l_s1;
s2_up = l_s2;
end

endmodule