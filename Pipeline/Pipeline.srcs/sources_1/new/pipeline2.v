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


module pipeline2
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
                                    //stall,
    input                           e_RFWE,
                                    e_mux3sel,
                                    e_DMWE,
    input [DATA_WL - 1 : 0]         e_ALU_out,
                                    e_RFRD2,
    input [4 : 0]                   e_Rt_Rd,
    // OUT
    output reg                      m_RFWE,
                                    m_mux3sel,
                                    m_DMWE,
    output reg [DATA_WL - 1 : 0]    m_ALU_out,
                                    m_RFRD2,
    output reg [4 : 0]              m_Rt_Rd
);

    always @ (posedge clk)
    begin
        if (rst) 
        begin
            m_RFWE      <= 0;
            m_mux3sel   <= 0;
            m_DMWE      <= 0;
            m_ALU_out   <= 0;
            m_RFRD2     <= 0;
            m_Rt_Rd     <= 0;
        end
        else
        begin
            m_RFWE      <= e_RFWE;
            m_mux3sel   <= e_mux3sel;
            m_DMWE      <= e_DMWE;
            m_ALU_out   <= e_ALU_out;
            m_RFRD2     <= e_RFRD2;
            m_Rt_Rd     <= e_Rt_Rd;
        end
    end
endmodule
