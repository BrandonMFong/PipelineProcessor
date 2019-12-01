`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 04:43:44 PM
// Design Name: 
// Module Name: concat0
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


module concat0
//concat or0 and jump signal
/*** PARAMETERS ***/

/*** IN/OUT ***/
(
    // IN
    input           f_jump,
                    or0,
    // OUT
    output  [1 : 0] d_out
);

    assign d_out = {f_jump, or0};
    
endmodule
