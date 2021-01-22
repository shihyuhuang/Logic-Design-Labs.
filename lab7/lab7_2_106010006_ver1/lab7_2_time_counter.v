`define DISABLED 1'b0
`define ENABLED 1'b1


module lab7_2_time_counter(
clk_1,
rst_n,
set,
start_stop,
start_enable,
resume_enable,
l_h1,
l_h2,
l_m1,
l_m2,
h1,
h2, 
m1, 
m2,
endled,
reset
);
input clk_1;
input rst_n;
input set;
input start_stop;
input start_enable,resume_enable;
input [3:0] l_h1, l_h2, l_m1, l_m2;
output reg [3:0] h1, h2, m1, m2;
reg [3:0] h1_tmp, h2_tmp, m1_tmp, m2_tmp;
reg borrow1, borrow2, borrow3, borrow4;
output reg [14:0]endled;
output reg [2:0] reset;
reg [2:0] reset_tmp;




always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) h1 <= 4'd2;
else h1 <= h1_tmp;

always @* 
if ((reset == 3'd2)&&(l_h1==0)&&(l_h2==0)&&(l_m1==0)&&(l_m2==0)) begin
h1_tmp = 4'd2;
borrow4 = `DISABLED; 
end
else if (reset == 3'd2) begin
h1_tmp = l_h1;
borrow4 = `ENABLED; 
end
else if (h1 == 4'd0 && borrow3) begin
h1_tmp = 4'd0;
borrow4 = `ENABLED; 
end
else if (h1 !== 4'd0 && borrow3) begin
h1_tmp = h1 - 4'd1;
borrow4 = `DISABLED; 
end
else begin
h1_tmp = h1; 
borrow4 = `DISABLED;
end

always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) h2 <= 4'd3;
else h2 <= h2_tmp;

always @*
if ((reset == 3'd2)&&(l_h1==0)&&(l_h2==0)&&(l_m1==0)&&(l_m2==0)) begin
h2_tmp = 4'd3;
borrow3 = `DISABLED; 
end
else if (reset == 3'd2) begin
h2_tmp = l_h2;
borrow3 = `ENABLED; 
end 
else if (h2 == 4'd0 && borrow2) begin
h2_tmp = 4'd9;
borrow3 = `ENABLED; 
end
else if (h2 !== 4'd0 && borrow2) begin
h2_tmp = h2 - 4'd1;
borrow3 = `DISABLED; 
end
else begin
h2_tmp = h2; 
borrow3 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) m1 <= 4'd5;
else m1 <= m1_tmp;

always @*
if ((reset == 3'd2)&&(l_h1==0)&&(l_h2==0)&&(l_m1==0)&&(l_m2==0)) begin
m1_tmp = 4'd5;
borrow2 = `DISABLED; 
end
else if (reset == 3'd2) begin
m1_tmp = l_m1;
borrow2 = `ENABLED; 
end
else if (m1 == 4'd0 && borrow1) begin
m1_tmp = 4'd5;
borrow2 = `ENABLED; 
end
else if (m1 !== 4'd0 && borrow1) begin
m1_tmp = m1 - 4'd1;
borrow2 = `DISABLED; 
end
else begin
m1_tmp = m1; 
borrow2 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) m2 <= 4'd9;
else m2 <= m2_tmp;

always @*
if ((reset == 3'd2)&&(l_h1==0)&&(l_h2==0)&&(l_m1==0)&&(l_m2==0)) begin
m2_tmp = 4'd9;
borrow1 = `DISABLED; 
end
else if (reset == 3'd2) begin
m2_tmp = l_m2;
borrow1 = `ENABLED; 
end
else if((h1==0)&&(h2==0)&&(m1==0)&&(m2==0))begin
m2_tmp = 4'd0;
borrow1 = `DISABLED; 
end
else if (m2 == 4'd0 && start_enable && resume_enable) begin
m2_tmp = 4'd9;
borrow1 = `ENABLED; 
end
else if (m2 !== 4'd0 && start_enable && resume_enable) begin
m2_tmp = m2 - 4'd1;
borrow1 = `DISABLED; 
end
else begin
m2_tmp = m2; 
borrow1 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n)
if (~rst_n)begin
reset <= 3'd0;
end
else begin
reset <= reset_tmp;
end

always @*
if(start_stop == 1)
reset_tmp = reset+1;
else
reset_tmp = 0;



always@*
if((h1==0)&&(h2==0)&&(m1==0)&&(m2==0))
endled = 15'b111111111111111;
else
endled = 15'd0;

endmodule