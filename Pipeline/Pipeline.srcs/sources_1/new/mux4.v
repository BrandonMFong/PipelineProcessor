`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 03:47:34 PM
// Design Name: 
// Module Name: mux4
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


module mux4
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32
)
/*** IN/OUT ***/
(
    // IN
    input [DATA_WL - 1 : 0]         d_RFRD1,
                                    m_alu_out,
    input                           d_mux4sel,
                                    rst,
    // OUT
    output reg [DATA_WL - 1 : 0]    d_dout
);

    always @(*)
    begin
        if (rst) d_dout = 0;
        else
        begin
            case (d_mux4sel)
                0: d_dout = m_alu_out;
                1: d_dout = d_RFRD1;
                default d_dout = 1'bx;
            endcase
        end
    end

endmodule
