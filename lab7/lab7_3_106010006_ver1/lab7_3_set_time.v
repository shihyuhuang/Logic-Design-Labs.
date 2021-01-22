`define DISABLED 1'b0
`define ENABLED 1'b1


module lab7_3_set_time(
clk_1,
rst_n,
set,
s_min_lap_reset,
s_hour_pause_resume,
count_up_down,
f_h1,
f_h2,
f_m1,
f_m2
);
input clk_1;
input rst_n;
input set;
input s_min_lap_reset, s_hour_pause_resume;
input count_up_down;
reg borrow1, borrow2, borrow3, borrow4;
reg [3:0] s_h1, s_h2, s_m1, s_m2;
reg [3:0] s_h1_tmp, s_h2_tmp, s_m1_tmp, s_m2_tmp;
output reg [3:0] f_h1, f_h2, f_m1, f_m2;
reg [3:0] f_h1_tmp, f_h2_tmp, f_m1_tmp, f_m2_tmp;



always @(posedge clk_1) 
if (~set) s_h1 <= 4'd0;
else s_h1 <= s_h1_tmp;

always @*
if (count_up_down == 0) begin
s_h1_tmp = 0;
borrow4 = `DISABLED;
end
else if (s_h1 == 4'd2 && borrow3) begin
s_h1_tmp = 4'd0;
borrow4 = `ENABLED; 
end
else if (s_h1 !== 4'd2 && borrow3) begin
s_h1_tmp = s_h1 + 4'd1;
borrow4 = `DISABLED; 
end
else begin
s_h1_tmp = s_h1; 
borrow4 = `DISABLED;
end



always @(posedge clk_1) 
if (~set) s_h2 <= 4'd0;
else s_h2 <= s_h2_tmp;

always @*
if (count_up_down == 0) begin
s_h2_tmp = 0;
borrow3 = `DISABLED;
end
else if((s_h1==2)&&(s_h2==3)&&(set == 1))begin
s_h2_tmp = 4'd0;
borrow3 = `ENABLED; 
end
else if (s_h2 == 4'd9 && s_hour_pause_resume) begin
s_h2_tmp = 4'd0;
borrow3 = `ENABLED; 
end
else if (s_h2 !== 4'd9 && s_hour_pause_resume) begin
s_h2_tmp = s_h2 + 4'd1;
borrow3 = `DISABLED; 
end
else begin
s_h2_tmp = s_h2; 
borrow3 = `DISABLED;
end


always @(posedge clk_1) 
if (~set) s_m1 <= 4'd0;
else s_m1 <= s_m1_tmp;


always @*
if (count_up_down == 0) begin
s_m1_tmp = 0;
borrow2 = `DISABLED;
end
else if (s_m1 == 4'd5 && borrow1) begin
s_m1_tmp = 4'd0;
borrow2 = `ENABLED; 
end
else if (s_m1 !== 4'd5 && borrow1) begin
s_m1_tmp = s_m1 + 4'd1;
borrow2 = `DISABLED; 
end
else begin
s_m1_tmp = s_m1; 
borrow2 = `DISABLED;
end


always @(posedge clk_1) 
if (~set) s_m2 <= 4'd0;
else s_m2 <= s_m2_tmp;

always @*
if (count_up_down == 0) begin
s_m2_tmp = 0;
borrow1 = `DISABLED;
end
else if (s_m2 == 4'd9 && s_min_lap_reset) begin
s_m2_tmp = 4'd0;
borrow1 = `ENABLED; 
end
else if (s_m2 !== 4'd9 && s_min_lap_reset) begin
s_m2_tmp = s_m2 + 4'd1;
borrow1 = `DISABLED; 
end
else begin
s_m2_tmp = s_m2; 
borrow1 = `DISABLED;
end


always @(posedge clk_1 or negedge rst_n) 
if (~rst_n) begin
f_h1 <= 4'd0;
f_h2 <= 4'd0;
f_m1 <= 4'd0;
f_m2 <= 4'd0;
end
else begin
f_h1 <= f_h1_tmp;
f_h2 <= f_h2_tmp;
f_m1 <= f_m1_tmp;
f_m2 <= f_m2_tmp;
end

always @* 
if (set==1) begin
f_h1_tmp = s_h1;
f_h2_tmp = s_h2;
f_m1_tmp = s_m1;
f_m2_tmp = s_m2;
end
else  begin
f_h1_tmp = f_h1;
f_h2_tmp = f_h2;
f_m1_tmp = f_m1;
f_m2_tmp = f_m2;
end




endmodule