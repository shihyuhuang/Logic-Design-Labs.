module mem_addr_gen(
   input [3:0]dsp0,
   input [3:0]dsp1,
   input [3:0]dsp2,
   input [3:0]dsp3,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output reg [16:0]pixel_addr
   );
    
    always@*
    if(h_cnt >= 0 && h_cnt <45 && v_cnt < 90 )
        pixel_addr= dsp3*45 + v_cnt*585 +h_cnt % 45;
    else if(h_cnt >= 45 && h_cnt <90 && v_cnt < 90 )
        pixel_addr= dsp2*45 + v_cnt*585+h_cnt % 45;
    else if(h_cnt >= 90 && h_cnt <135 && v_cnt < 90 )
        pixel_addr= dsp1*45 + v_cnt*585+h_cnt % 45;
    else if(h_cnt >= 135 && h_cnt <180 && v_cnt < 90 )
        pixel_addr= dsp0*45 + v_cnt*585+h_cnt % 45;
    else
        pixel_addr= 0;
    
endmodule
