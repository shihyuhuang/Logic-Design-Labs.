module  lab10_2_note_gun(
clk, // clock from crystal
rst, // active low reset
note_div, // div for note generation 
audio_left, // left sound audio 
audio_right // right sound audio
);
// I/O declaration
input clk; // clock from crystal
input rst; // active low reset
input [21:0] note_div; // div for note generation 
output [15:0] audio_left; // left sound audio 
output [15:0] audio_right; // right sound audio
// Declare internal signals
reg [21:0] clk_cnt_next, clk_cnt; 
reg b_clk, b_clk_next;
 
// Note frequency generation
always @(posedge clk or negedge rst)
if (rst) begin
clk_cnt <= 22'd0;
b_clk <= 1'b0; 
end
else begin
clk_cnt <= clk_cnt_next;
b_clk <= b_clk_next; 
end

always @*
if (clk_cnt == note_div) begin
clk_cnt_next = 22'd0;
b_clk_next = ~b_clk; 
end
else begin
clk_cnt_next = clk_cnt + 1'b1;
b_clk_next = b_clk; 
end

// Assign the amplitude of the note
assign audio_left = (b_clk == 1'b0) ? 16'hB000 : 16'h5FFF; 
assign audio_right = (b_clk == 1'b0) ? 16'hB000 : 16'h5FFF;

endmodule