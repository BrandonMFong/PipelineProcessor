`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 08:46:22 AM
// Design Name: 
// Module Name: Jump
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


module Jump
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    JUMP_WL     = 26
    
)
/*** IN/OUT ***/
(
    // IN
    input [DATA_WL - 1 : 0]         d_PC,
    input [JUMP_WL - 1 : 0]         d_jump,
    input                           rst,
    // OUT
    output [DATA_WL - 1 : 0]        jaddr
);

    // Concat the top of PC on top of Jump address
    assign jaddr = (rst) ? 0 : {d_PC[31:26], d_jump};
endmodule