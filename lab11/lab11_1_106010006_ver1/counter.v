`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/09 23:24:25
// Design Name: 
// Module Name: counter
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


module counter(
    input rst,
    input clk,
    input add,// �p�Gadd�O1���ܨCclk�[�@��
    input rst_en,    
    input [3:0]rst_value,//�p�Grst���ܳ]���o�ӭ�
    input [3:0]start,//�p�G�i�쪺�ܳ]��start
    input [3:0]limit,//��h�֭n�i��
    output reg [3:0]digit,
    output reg carry
    );
    
    reg [3:0]digit_tmp;    
    always @*
        if(rst_en)begin
            digit_tmp <= rst_value;
            carry <= 0;
        end 
        else if(limit==digit && add==1)begin 
            digit_tmp <= start;
            carry <= 1;
        end
        else if(add==1) begin
            digit_tmp <= digit + 1;
            carry <= 0;
        end 
        else begin
            digit_tmp <= digit;
            carry <= 0;
        end

                       
        //flip-flop
        always @(posedge clk or posedge rst )
        if (rst) begin
              digit <= rst_value;
        end
        else digit <= digit_tmp;
        
endmodule
