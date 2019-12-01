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


module mux1
/*** PARAMETERS ***/
#(parameter
    // WL
    ADDR_RF_WL  = 5
)
/*** IN/OUT ***/
(
    // IN
    input [ADDR_RF_WL - 1 : 0]      e_RT,
                                    e_RD,
    input                           e_mux1sel,
                                    rst,
    // OUT
    output reg [ADDR_RF_WL - 1 : 0] e_dout
);

    always @(*)
    begin
        if (rst) e_dout = 0;
        else
        begin
            case (e_mux1sel)
                0: e_dout = e_RT;
                1: e_dout = e_RD;
                default e_dout = 1'bx;
            endcase
        end
    end

endmodule
