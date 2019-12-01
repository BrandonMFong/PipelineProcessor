`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 05:14:56 PM
// Design Name: 
// Module Name: sign_extension
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


module sign_extension
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    IMMED_WL    = 16
)
/*** IN/OUT ***/
(
    // IN
    input signed [IMMED_WL - 1 : 0]        d_IMMED,
    // OUT
    output signed [DATA_WL - 1 : 0]        d_SIGNED_IMMED
);
    
    // arithmetic shifting a concatenation doesn't work
    // couldn't find a way to identify the operation as signed data
    // so hard coding the sign extension 
    assign d_SIGNED_IMMED = (d_IMMED[IMMED_WL - 1]) ? {16'b1111111111111111, d_IMMED}: {16'b0000000000000000, d_IMMED};
endmodule
