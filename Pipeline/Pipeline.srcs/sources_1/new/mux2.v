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


module mux2
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32
)
/*** IN/OUT ***/
(
    // IN
    input [DATA_WL - 1 : 0]         e_RFRD2,
                                    e_SIGNED_IMMED,
    input                           e_mux2sel,
                                    rst,
    // OUT
    output reg [DATA_WL - 1 : 0]    e_dout
);

    always @(*)
    begin
        if (rst) e_dout = 0;
        else
        begin
            case (e_mux2sel)
                0: e_dout = e_RFRD2;
                1: e_dout = e_SIGNED_IMMED;
                default e_dout = 1'bx;
            endcase
        end
    end

endmodule
