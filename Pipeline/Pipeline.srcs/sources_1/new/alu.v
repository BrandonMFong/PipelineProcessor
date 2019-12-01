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


module alu
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    ADDR_RF_WL  = 5,
    ADDR_MEM    = 32,
    IMMED_WL    = 16,
    JUMP_WL     = 26,
    ALU_WL      = 4,
    
    // LOCAL PARAM
    e_shamt_WL    = 5,

    // ALU
    ALU_IDLE                = 3'b000,
    ALU_LW_SW_ADD_ADDI_PC   = 3'b001,
    ALU_SUB_BRANCH          = 3'b010,
    ALU_SLLV                = 3'b011,
    ALU_SRAV                = 3'b100,
    ALU_SRLV                = 3'b101,
    ALU_MULT                = 3'b110,
    ALU_SLL                 = 3'b111,
    ALU_SRA                 = 4'b1000,
    ALU_SRL                 = 4'b1001
)
/*** IN/OUT ***/
(
    // IN
    input   [DATA_WL - 1 : 0]       e_IN1,
                                    e_IN2,
    input [e_shamt_WL - 1 : 0]      e_shamt,
    input [ALU_WL - 1 : 0]          ALUsel,
    input                           rst,
    // OUT
    output reg [DATA_WL - 1 : 0]    e_ALU_out
);

    always @(*)
    begin
       if(rst)e_ALU_out = 0;
       else
       begin
           case(ALUsel)
               ALU_IDLE:                e_ALU_out = 0; // Do nothing, out nothing
               ALU_LW_SW_ADD_ADDI_PC:   e_ALU_out = e_IN1 + e_IN2;
               ALU_SUB_BRANCH:          e_ALU_out = e_IN1 - e_IN2;
               ALU_SLLV:                e_ALU_out = e_IN2 << e_IN1;
               ALU_SRAV:                e_ALU_out = e_IN2 >>> e_IN1;
               ALU_SRLV:                e_ALU_out = e_IN2 >> e_IN1;
               ALU_SLL:                 e_ALU_out = e_IN2 << e_shamt;
               ALU_SRA:                 e_ALU_out = e_IN2 >>> e_shamt;
               ALU_SRL:                 e_ALU_out = e_IN2 >> e_shamt;
               default                  e_ALU_out = 1'bx;
            endcase
        end
    end
endmodule
