`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/29 22:05:55
// Design Name: 
// Module Name: decimal_muti
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


module decimal_muti(
    input [3:0]a,
    input [3:0]b,
    output reg [3:0]f0,
    output reg [3:0]f1
    );
    wire [7:0]f;
    assign f = a*b;
    
    always@*
    if(f>=80)begin
        f1 = 8;
        f0 = f-80;
    end
    else if(f>=70)begin
        f1 = 7;
        f0 = f-70;
    end
    else if(f>=60)begin
        f1 = 6;
        f0 = f-60;   
    end
    else if(f>=50)begin
        f1 = 5;
        f0 = f-50;    
    end
    else if(f>=40)begin
        f1 = 4;
        f0 = f-40;   
    end
    else if(f>=30)begin
        f1 = 3;
        f0 = f-30;    
    end
    else if(f>=20)begin
        f1 = 2;
        f0 = f-20;
    end
    else if(f>=10)begin
        f1 = 1;
        f0 = f-10;    
    end
    else begin
        f1 = 0;
        f0 = f;
    end        
endmodule
