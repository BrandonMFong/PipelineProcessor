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


module mux0
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32
)
/*** IN/OUT ***/
(
    // IN
    input [DATA_WL - 1 : 0]         f_jaddr,
                                    f_PC,
                                    f_PCbranch,
    input [1 : 0]                   f_mux0sel,
    input                           rst,
    // OUT
    output reg [DATA_WL - 1 : 0]    f_dout
);

    always @(*)
    begin
        if(rst) f_dout = 0;
        else
        begin
            case (f_mux0sel)
                0:          f_dout = f_PC;
                1:          f_dout = f_PCbranch;
                2:   f_dout = f_jaddr;
                3:   f_dout = f_jaddr;
                default f_dout = 1'bx;
            endcase
        end
    end

endmodule
