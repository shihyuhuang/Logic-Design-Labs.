
module lab10_1_frequency_divider(
input rst,
input clk,
input [30:0]x,
output clk_out
);
reg [30:0]cnt;
    
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
    
assign clk_out = cnt[x-1];

endmodule
