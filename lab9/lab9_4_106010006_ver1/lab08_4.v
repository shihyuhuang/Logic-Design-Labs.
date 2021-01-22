`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/02 20:29:17
// Design Name: 
// Module Name: lab08_4
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

`define KEY_SFT {1'b0 , 8'h12}
`define KEY_CAP_LOCK {1'b0 , 8'h58}

module lab08_4(
    input rst,
    input f_cst,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output [15:0]test_LED 
    );
    //////////////input
    
    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid;
    KeyboardDecoder U0(.key_down(key_down),.last_change(last_change),
            .key_valid(key_valid),.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),
            .rst(rst),.clk(f_cst));
    //    
    
    reg caps_lock,caps;
    
    always@(posedge key_down[`KEY_CAP_LOCK] or posedge rst)
    if(rst)
        caps_lock <= 0;
    else
        caps_lock <= ~caps_lock;
       
    always@*
    if((caps_lock==1 && key_down[`KEY_SFT]==0) || (caps_lock==0 && key_down[`KEY_SFT]==1))
        caps = 1;
    else
        caps = 0;
    ///////output
    KeyASCIIDecoder D0 (.key(last_change), .Caps(caps), .ASCII(test_LED[7:0]));
    assign test_LED[15] = caps_lock;
    //assign test_LED[0] = 1; 
endmodule
