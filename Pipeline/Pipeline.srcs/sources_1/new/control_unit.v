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


module control_unit
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    ADDR_RF_WL  = 5,
    ADDR_MEM    = 32,
    IMMED_WL    = 16,
    JUMP_WL     = 26,
    ALU_WL      = 4,

    // Local param WL
    OP_WL       = 6,
    FUNCT_WL    = 6,

    // OPCODE
    LW          = 6'b100011,
    SW          = 6'b101011,
    ADDI        = 6'b001000,
    JUMP        = 6'b000010,
    R           = 6'b000000,
    BEQ         = 6'b000100,
    BNE         = 6'b000101,

    // FUNCT
    ADD         = 6'b100000,
    SUB         = 6'b100010,
    SLL         = 6'b000000,
    SRA         = 6'b000011,
    SRL         = 6'b000010,
    SLLV        = 6'b000100,
    SRAV        = 6'b000111,
    SRLV        = 6'b000110,
    /* TODO implement the bottom two functions if you have time */
    DIV         = 6'B011010,

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
    input                       clk,
                                rst,
    input [OP_WL - 1 : 0]       d_OPCODE,
    input [FUNCT_WL - 1 : 0]    d_FUNCT,
    // OUT
    output reg                  d_mux1sel,
                                d_mux2sel,
                                d_RFWE,
                                d_mux3sel,
                                d_DMWE,
                                d_Branch,
                                d_Jump,
    output reg [ALU_WL - 1 : 0] d_ALU_sel    
);
    localparam  mux1_e_Rt = 0, mux1_e_Rd = 1, mux2_e_RFRD2 = 0, 
                mux2_e_SIGNED_IMMED = 1, mux3_w_DMRD = 1, mux3_w_ALU_OUT = 0,
                WRITE = 1, DONT_WRITE = 0, BRANCH = 1, 
                DONT_BRANCH = 0, DONT_CARE = 1'bx, JUMP_YES = 1, 
                JUMP_NO = 0, ZERO = 0;

    always @(d_OPCODE || d_FUNCT)
    begin
        if(!rst)
        begin
            case(d_OPCODE)
            LW:
            begin
                d_mux1sel   = mux1_e_Rt; // LW or SW don't use Rd
                d_mux2sel   = mux2_e_SIGNED_IMMED;
                d_mux3sel   = mux3_w_DMRD;
                d_RFWE      = WRITE;
                d_DMWE      = DONT_WRITE;
                d_Branch    = DONT_BRANCH;
                d_Jump      = JUMP_NO;
                d_ALU_sel   = ALU_LW_SW_ADD_ADDI_PC;
            end
            SW:
            begin
                d_mux1sel   = mux1_e_Rt;
                d_mux2sel   = mux2_e_SIGNED_IMMED;
                d_mux3sel   = ZERO;
                d_RFWE      = DONT_WRITE;
                d_DMWE      = WRITE;
                d_Branch    = DONT_BRANCH;
                d_Jump      = JUMP_NO;
                d_ALU_sel   = ALU_LW_SW_ADD_ADDI_PC;
            end
            ADDI:
            begin
                d_mux1sel   = mux1_e_Rt;
                d_mux2sel   = mux2_e_SIGNED_IMMED;
                d_mux3sel   = mux3_w_ALU_OUT;
                d_RFWE      = WRITE;
                d_DMWE      = DONT_WRITE;
                d_Branch    = DONT_BRANCH;
                d_Jump      = JUMP_NO;
                d_ALU_sel   = ALU_LW_SW_ADD_ADDI_PC;
            end
            JUMP:
            begin
                d_mux1sel   = DONT_CARE;
                d_mux2sel   = DONT_CARE;
                d_mux3sel   = DONT_CARE;
                d_RFWE      = DONT_CARE;
                d_DMWE      = DONT_CARE;
                d_Branch    = BRANCH;
                d_Jump      = JUMP_YES;
                d_ALU_sel   = DONT_CARE;
            end
            BEQ:
            begin
                d_mux1sel   = DONT_CARE;
                d_mux2sel   = DONT_CARE;
                d_mux3sel   = DONT_CARE;
                d_RFWE      = DONT_CARE;
                d_DMWE      = DONT_CARE;
                d_Branch    = BRANCH;
                d_Jump      = JUMP_NO;
                d_ALU_sel   = DONT_CARE;
            end
            R:
            begin
                d_mux1sel   = mux1_e_Rd;
                d_mux2sel   = mux2_e_RFRD2;
                d_mux3sel   = mux3_w_ALU_OUT;
                d_RFWE      = WRITE;
                d_DMWE      = DONT_CARE;
                d_Branch    = DONT_BRANCH;
                d_Jump      = JUMP_NO;
                case(d_FUNCT)
                    ADD:        d_ALU_sel = ALU_LW_SW_ADD_ADDI_PC;
                    SUB:        d_ALU_sel = ALU_SUB_BRANCH;
                    SLL:        d_ALU_sel = ALU_SLL;
                    SRA:        d_ALU_sel = ALU_SRA;
                    SRL:        d_ALU_sel = ALU_SRL;
                    SLLV:       d_ALU_sel = ALU_SLLV;
                    SRAV:       d_ALU_sel = ALU_SRAV;
                    SRLV:       d_ALU_sel = ALU_SRLV;
                    default     d_ALU_sel = DONT_CARE;
                endcase
            end
            default
            begin
                d_mux1sel   = DONT_CARE;
                d_mux2sel   = DONT_CARE;
                d_mux3sel   = DONT_CARE;
                d_RFWE      = DONT_CARE;
                d_DMWE      = DONT_CARE;
                d_Branch    = DONT_CARE;
                d_ALU_sel   = DONT_CARE;
                d_Jump      = DONT_CARE;
            end
            endcase
        end
        else
        begin
            d_mux1sel   = 0;
            d_mux2sel   = 0;
            d_mux3sel   = 0;
            d_RFWE      = 0;
            d_DMWE      = 0;
            d_Branch    = 0;
            d_ALU_sel   = 0;
            d_Jump      = 0;
        end
    end
endmodule
