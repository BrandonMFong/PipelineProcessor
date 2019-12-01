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


module pipeline3
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32
)
/*** IN/OUT ***/
(
    // IN
    input                           clk,
                                    rst,
                                    stall,
    input                           m_RFWE,
                                    m_mux3sel,
    input [DATA_WL - 1 : 0]         m_ALU_out,
                                    m_DMRD,
    input [4 : 0]                   m_Rt_Rd,
    // OUT
    output reg                      w_RFWE,
                                    w_mux3sel,
    output reg [DATA_WL - 1 : 0]    w_ALU_out,
                                    w_DMRD,
    output reg [4 : 0]              w_Rt_Rd
);

    always @(posedge clk)
    begin
        if (rst)
        begin
            w_RFWE      <= 0;
            w_mux3sel   <= 0;
            w_ALU_out   <= 0;
            w_DMRD      <= 0;
            w_Rt_Rd     <= 0;
        end
        else
        begin
            w_RFWE      <= m_RFWE;
            w_mux3sel   <= m_mux3sel;
            w_ALU_out   <= m_ALU_out;
            w_DMRD      <= m_DMRD;
            w_Rt_Rd     <= m_Rt_Rd;
        end
    end
endmodule
