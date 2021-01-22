`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/20 18:25:37
// Design Name: 
// Module Name: decimal_adder
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


module decimal_adder(
    output [3:0]S,
    output reg co,
    input [3:0]A,
    input [3:0]B,
    input ci
    );
    
reg [4:0] mS_;
wire [4:0] mS;
assign mS = {1'b0,A} + {1'b0,B} + {4'b0,ci};
always @(A or B or ci)
begin 

    if(mS>9)
    begin
        co=1;
        mS_=mS-10;
    end
    else
    begin
        co=0;
        mS_=mS;
    end  
end  
assign S={mS_[3:0]};
endmodule
