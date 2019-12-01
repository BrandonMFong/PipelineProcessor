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


module pipeline0
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    ADDR_RF_WL  = 5,
    ADDR_MEM    = 32,
    IMMED_WL    = 16,
    JUMP_WL     = 26
)
/*** IN/OUT ***/
(
    // IN
    input                           clk,
                                    rst,
                                    clr,
                                    PIPE0EN_STALL,
    input [DATA_WL - 1 : 0]         f_instruction,
                                    f_PC,
    // OUT
    output reg [ADDR_RF_WL - 1 : 0] d_Rs,
                                    d_Rt,
                                    d_Rd,
                                    d_shamt,
    output reg [5 : 0]              d_OPCODE,
                                    d_FUNCT,
    output reg [IMMED_WL - 1 : 0]   d_IMMED,
    output reg [JUMP_WL - 1 : 0]    d_JUMP,
    output reg [DATA_WL - 1 : 0]    d_PC
);

    always @(posedge clk)
    begin
        if(clr || rst)
        begin
            d_PC        <= 0;
            d_OPCODE    <= 0;
            d_Rs        <= 0;
            d_Rt        <= 0;
            d_Rd        <= 0;
            d_shamt     <= 0;
            d_FUNCT     <= 0;
            d_IMMED     <= 0;
            d_JUMP      <= 0;
        end
        else
        begin
            if (!PIPE0EN_STALL)
            begin
                d_PC        <= f_PC;
                d_OPCODE    <= f_instruction[31 : 26];
                d_Rs        <= f_instruction[25 : 21];
                d_Rt        <= f_instruction[20 : 16];
                d_Rd        <= f_instruction[15 : 11];
                d_shamt     <= f_instruction[10 : 6];
                d_FUNCT     <= f_instruction[5 : 0];
                d_IMMED     <= f_instruction[15 : 0];
                d_JUMP      <= f_instruction[25 : 0];
            end
        end
    end
endmodule
