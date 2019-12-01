`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2019 05:00:41 PM
// Design Name: 
// Module Name: mux7
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

//this might be problematic
module mux7
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32
)
/*** IN/OUT ***/
(
    // IN
    input [DATA_WL - 1 : 0]         e_RFRD2,
                                    m_alu_out,
                                    w_mux3_out,
    input [1 : 0]                   e_mux7sel,
    input                           rst,
    // OUT
    output reg [DATA_WL - 1 : 0]    e_dout
);

    always @(*)
    begin
        if (rst) e_dout = 0;
        else
        begin
            case (e_mux7sel)
                0: e_dout = e_RFRD2;
                1: e_dout = m_alu_out;
                2: e_dout = w_mux3_out;
                default e_dout = 1'bx;
            endcase
        end
    end
endmodule
