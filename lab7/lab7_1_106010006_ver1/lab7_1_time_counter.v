`define DISABLED 1'b0
`define ENABLED 1'b1


module lab7_1_time_counter(
qclk,
rst_n,
count_enable,
lap_enable,
lap_reset,
a,
b,
c,
d,
reset
);
input qclk;
input rst_n;
input lap_reset;
input count_enable, lap_enable;
output reg [3:0] a, b, c, d;
reg [3:0] m1, m2, s1, s2;
reg [3:0] l_m1, l_m2, l_s1, l_s2;
reg [3:0] m1_tmp, m2_tmp, s1_tmp, s2_tmp;
reg [3:0] l_m1_tmp, l_m2_tmp, l_s1_tmp, l_s2_tmp;
reg borrow1, borrow2, borrow3, borrow4;
output reg [2:0] reset;
reg [2:0] reset_tmp;


always @(posedge qclk or negedge rst_n) 
if (~rst_n) m1 <= 4'd0;
else m1 <= m1_tmp;

always @* 
if (reset == 3'd2) begin
m1_tmp = 4'd0;
borrow4 = `ENABLED;
end
else if ((m1 == 4'd5)&&(borrow3==1)) begin
m1_tmp = 4'd0;
borrow4 = `ENABLED; 
end
else if ((m1 !== 4'd5) && (borrow3==1)) begin
m1_tmp = m1 + 4'd1;
borrow4 = `DISABLED; 
end
else begin
m1_tmp = m1; 
borrow4 = `DISABLED;
end

always @(posedge qclk or negedge rst_n) 
if (~rst_n) m2 <= 4'd0;
else m2 <= m2_tmp;

always @*
if (reset == 3'd2) begin
m2_tmp = 4'd0;
borrow3 = `DISABLED; 
end
else if ((m2 == 4'd9) && (borrow2==1)) begin
m2_tmp = 4'd0;
borrow3 = `ENABLED; 
end
else if ((m2 !== 4'd9) && (borrow2==1)) begin
m2_tmp = m2 + 4'd1;
borrow3 = `DISABLED; 
end
else begin
m2_tmp = m2; 
borrow3 = `DISABLED;
end


always @(posedge qclk or negedge rst_n) 
if (~rst_n) s1 <= 4'd0;
else s1 <= s1_tmp;

always @*
if (reset == 3'd2) begin
s1_tmp = 4'd0;
borrow2 = `DISABLED; 
end
else if ((s1 == 4'd5) && (borrow1==1)) begin
s1_tmp = 4'd0;
borrow2 = `ENABLED; 
end
else if ((s1 !== 4'd5) && (borrow1==1)) begin
s1_tmp = s1 + 4'd1;
borrow2 = `DISABLED; 
end
else begin
s1_tmp = s1; 
borrow2 = `DISABLED;
end


always @(posedge qclk or negedge rst_n) 
if (~rst_n) s2 <= 4'd0;
else s2 <= s2_tmp;

always @*
if (reset == 3'd2) begin
s2_tmp = 4'd0;
borrow1 = `DISABLED;
end
else if ((s2 == 4'd9) && (count_enable==1)) begin
s2_tmp = 4'd0;
borrow1 = `ENABLED; 
end
else if ((s2 !== 4'd9) && (count_enable==1)) begin
s2_tmp = s2 + 4'd1;
borrow1 = `DISABLED; 
end
else begin
s2_tmp = s2; 
borrow1 = `DISABLED;
end


always @(posedge qclk or negedge rst_n)
if (~rst_n)begin
reset <= 3'd0;
end
else begin
reset <= reset_tmp;
end

always @*
if(lap_reset == 1)
reset_tmp = reset+1;
else
reset_tmp = 0;


 

   
always @(posedge qclk or negedge rst_n) 
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
l_m1_tmp = l_m1 ;
l_m2_tmp = l_m2;
l_s1_tmp = l_s1;
l_s2_tmp = l_s2;
end

always@*
if(lap_enable == 0)begin
a = m1;
b = m2;
c = s1;
d = s2;
end
else begin
a = l_m1;
b = l_m2;
c = l_s1;
d = l_s2;
end

endmodule