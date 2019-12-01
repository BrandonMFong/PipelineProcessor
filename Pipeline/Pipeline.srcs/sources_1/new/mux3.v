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


module mux3
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32
)
/*** IN/OUT ***/
(
    // IN
    input [DATA_WL - 1 : 0]         w_ALU_OUT,
                                    w_DMRD,
    input                           w_mux3sel,
                                    rst,
    // OUT
    output reg [DATA_WL - 1 : 0]    w_dout
);

    always @(*)
    begin
        if (rst) w_dout = 0;
        else
        begin
            case (w_mux3sel)
                0: w_dout = w_ALU_OUT;
                1: w_dout = w_DMRD;
                default w_dout = 1'bx;
            endcase
        end
    end

endmodule
