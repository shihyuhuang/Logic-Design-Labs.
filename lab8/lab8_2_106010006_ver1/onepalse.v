`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/30 13:56:59
// Design Name: 
// Module Name: onepalse
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module onepalse(
rst, clk, push_debounced, push_onepulse
);
input clk, rst;
input push_debounced;
output push_onepulse;
// internal registers
reg push_onepulse;
reg push_onepulse_next;
reg push_debounced_delay;
always @* begin
push_onepulse_next = push_debounced
& ~push_debounced_delay;
end
always @(posedge clk or posedge rst)
begin
if (rst) begin
push_onepulse <= 1'b0;
push_debounced_delay <= 1'b0;
end else begin
push_onepulse <= push_onepulse_next;
push_debounced_delay <=push_debounced;
end
end
endmodule
