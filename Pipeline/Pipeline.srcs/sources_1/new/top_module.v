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

module top_module
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
    input clk, RESET_ALL
    // OUT

);

    /* WIRES */
    wire [DATA_WL - 1 : 0]      programcounter_instmem_adder0,
                                adder0_pipe0_mux0,
                                pipe0_jump_adder1,
                                signextension_pipe1_adder1,
                                mux6_alu,
                                mux2_alu,
                                alu_pipe2,
                                mux4_comparator0,
                                mux5_comparator0,
                                pipe2_datamem_m_DMWD,
                                datamem_pipe3,
                                instmem_pipe0,
                                jump_mux0_f_jaddr,
                                adder1_mux0_branch,
                                mux0_programcounter,
                                mux7_mux2_pipe2_e_RFRD2_or_FWD_DATA,
                                pipe1_mux2_e_SIGNED_IMMED,
                                pipe3_mux3_w_ALU_OUT,
                                pipe3_mux3_w_DMRD,
                                mux3_regfile_mux6_mux7,
                                regfile_pipe1_mux4,
                                pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out,
                                regfile_pipe1_mux5,
                                mux5_comparator,
                                pipe1_mux6,
                                pipe1_mux7,
                                signextension_pipe1_mux0;
                                
    wire [ADDR_RF_WL - 1 : 0]   pipe0_pipe1_d_Rd,
                                pipe0_pipe1_d_shamt;
    //wire [ADDR_MEM - 1 : 0]     pipe2_datamem_mux4_mux5_pipe3;
    wire [IMMED_WL - 1 : 0]     pipe0_sign_extension;
    wire [JUMP_WL - 1 : 0]      pipe0_jump;
    wire [ALU_WL - 1 : 0]       pipe1_alu_alusel,
                                controlunit_pipe1_d_ALU_sel;
    wire [OP_WL - 1 : 0]        pipe0_controlunit_d_OPCODE;
    wire [FUNCT_WL - 1 : 0]     pipe0_controlunit_d_FUNCT;
    wire [4 : 0]                pipe1_alu_shamt,
                                pipe0_regfile_pipe1_hazardunit_d_Rt,
                                pipe0_regfile_pipe1_hazardunit_d_Rs,
                                pipe1_mux1_hazardunit_e_Rt,
                                pipe1_hazardunit_e_Rs,
                                mux1_pipe2_hazardunit_e_Rt_Rd,
                                pipe2_pipe3_hazardunit_m_Rt_Rd,
                                pipe3_regfile_hazardunit_w_Rt_Rd,
                                pipe1_mux1_e_Rd,
                                mux1_pipe2_e_Rt_Rd;
    
    wire [1 : 0]                concat0_mux0_f_mux0sel,
                                hazardunit_mux6,
                                hazardunit_mux7;
                                
    wire                        comparator0_and0,
                                controlunit_and0_hazardunit,
                                and0_or0,
                                controlunit_pipe1_d_mux1sel,
                                controlunit_or0_concat0,
                                controlunit_pipe1_d_mux2sel,
                                controlunit_pipe1_d_RFWE,
                                controlunit_pipe1_d_mux3sel,
                                controlunit_pipe1_d_DMWE,
                                pipe2_datamem_m_DMWE,
                                pipe1_pipe2_hazardunit_e_RFWE,
                                pipe2_pipe3_hazardunit_m_RFWE,
                                pipe3_regfile_hazardunit_m_RFWE,
                                hazardunit_programcounter_PCEN_STALL,
                                hazardunit_pipe0_PIPE0EN_STALL,
                                hazardunit_pipe1_clr_PIPE1,
                                hazardunit_mux4_d_mux4sel,
                                hazardunit_mux5_d_mux5sel,
                                pipe1_mux1_e_mux1sel,
                                pipe1_mux2_e_mux2sel,
                                or0_pipe0_concat0,
                                hazardunit_pipe1,
                                pipe1_pipe2_e_RFWE_e_RFWE,
                                pipe1_pipe2_e_DMWE,
                                pipe2_pipe3_e_mux3sel,
                                pipe2_pipe3_hazardunit_m_mux3sel,
                                pipe3_mux3_e_mux3sel,
                                pipe1_pipe2_hazardunit_e_mux3sel;
                               
    
    /** MODULES **/
    adder0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod0
            /* IN & OUT */
            (
                // IN
                .f_din(programcounter_instmem_adder0),
                // OUT
                .f_dout(adder0_pipe0_mux0)
             );
             
//    adder1
//            /* PARAMETERS */
//            #(
//                .DATA_WL(DATA_WL)
//            )
//        mod1
//            /* IN & OUT */
//            (
//                // IN
//                .d_PC(pipe0_jump_adder1),
//                .d_SIGNED_IMMED(signextension_pipe1_adder1),
//                // OUT
//                .f_pc_branch(adder1_mux0_branch)
//             );
             
    alu
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .ADDR_RF_WL(ADDR_RF_WL),
                .ADDR_MEM(ADDR_MEM),
                .IMMED_WL(IMMED_WL),
                .JUMP_WL(JUMP_WL),
                .ALU_WL(ALU_WL),
                .ALU_IDLE(ALU_IDLE),
                .ALU_LW_SW_ADD_ADDI_PC(ALU_LW_SW_ADD_ADDI_PC),
                .ALU_SUB_BRANCH(ALU_SUB_BRANCH),
                .ALU_SLLV(ALU_SLLV),
                .ALU_SRAV(ALU_SRAV),
                .ALU_SRLV(ALU_SRLV),
                .ALU_MULT(ALU_MULT),
                .ALU_SLL(ALU_SLL),
                .ALU_SRA(ALU_SRA),
                .ALU_SRL(ALU_SRL)
            )
        mod2
            /* IN & OUT */
            (
                // IN
                .e_IN1(mux6_alu),
                .e_IN2(mux2_alu),
                .e_shamt(pipe1_alu_shamt),
                .ALUsel(pipe1_alu_alusel),
                .rst(RESET_ALL),
                // OUT
                .e_ALU_out(alu_pipe2)
             );
        
    and0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod3
            /* IN & OUT */
            (
                // IN
                .d_rfd1_rfd2_equal(comparator0_and0),
                .d_branch(controlunit_and0_hazardunit),
                // OUT
                .dout(and0_or0)
             );
             
    comparator0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod4
            /* IN & OUT */
            (
                // IN
                .d_in1(mux4_comparator0),
                .d_in2(mux5_comparator0),
                // OUT
                .d_dout(comparator0_and0)
             ); 
                      
    control_unit
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .ADDR_RF_WL(ADDR_RF_WL),
                .ADDR_MEM(ADDR_MEM),
                .IMMED_WL(IMMED_WL),
                .JUMP_WL(JUMP_WL),
                .ALU_WL(ALU_WL),
                .OP_WL(OP_WL),
                .FUNCT_WL(FUNCT_WL),
                .LW(LW),
                .SW(SW),
                .ADDI(ADDI),
                .JUMP(JUMP),
                .R(R),
                .BEQ(BEQ),
                .BNE(BNE),
                .ADD(ADD),
                .SUB(SUB),
                .SLL(SLL),
                .SRA(SRA),
                .SRL(SRL),
                .SLLV(SLLV),
                .SRAV(SRAV),
                .SRLV(SRLV),
                .DIV(DIV),
                .ALU_IDLE(ALU_IDLE),
                .ALU_LW_SW_ADD_ADDI_PC(ALU_LW_SW_ADD_ADDI_PC),
                .ALU_SUB_BRANCH(ALU_SUB_BRANCH),
                .ALU_SLLV(ALU_SLLV),
                .ALU_SRAV(ALU_SRAV),
                .ALU_SRLV(ALU_SRLV),
                .ALU_MULT(ALU_MULT),
                .ALU_SLL(ALU_SLL),
                .ALU_SRA(ALU_SRA),
                .ALU_SRL(ALU_SRL)
            )
        mod5
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .d_OPCODE(pipe0_controlunit_d_OPCODE),
                .d_FUNCT(pipe0_controlunit_d_FUNCT),
                // OUT
                .d_mux1sel(controlunit_pipe1_d_mux1sel),
                .d_mux2sel(controlunit_pipe1_d_mux2sel),
                .d_RFWE(controlunit_pipe1_d_RFWE),
                .d_mux3sel(controlunit_pipe1_d_mux3sel),
                .d_DMWE(controlunit_pipe1_d_DMWE),
                .d_Branch(controlunit_and0_hazardunit),
                .d_Jump(controlunit_or0_concat0),
                .d_ALU_sel(controlunit_pipe1_d_ALU_sel)
             ); 
             
    data_memory
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .ADDR_MEM(ADDR_MEM)
            )
        mod6
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .m_DMWE(pipe2_datamem_m_DMWE),
                .m_DMA(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .m_DMWD(pipe2_datamem_m_DMWD),
                // OUT
                .m_DMRD(datamem_pipe3)
             );   
               
    hazard_unit
            /* PARAMETERS */
            #(
                //.ADDR_RF_WL()
            )
        mod7
            /* IN & OUT */
            (
                // IN
                .d_Branch(controlunit_and0_hazardunit),
                .e_RFWE(pipe1_pipe2_hazardunit_e_RFWE),
                .m_RFWE(pipe2_pipe3_hazardunit_m_RFWE),
                .w_RFWE(pipe3_regfile_hazardunit_m_RFWE),
                .e_mux3sel(pipe1_pipe2_hazardunit_e_mux3sel),
                .m_mux3sel(pipe2_pipe3_hazardunit_m_mux3sel),
                .d_Rt(pipe0_regfile_pipe1_hazardunit_d_Rt),
                .d_Rs(pipe0_regfile_pipe1_hazardunit_d_Rs),
                .e_Rt(pipe1_mux1_hazardunit_e_Rt),
                .e_Rs(pipe1_hazardunit_e_Rs),
                .e_Rt_Rd(mux1_pipe2_hazardunit_e_Rt_Rd),
                .m_Rt_Rd(pipe2_pipe3_hazardunit_m_Rt_Rd),
                .w_Rt_Rd(pipe3_regfile_hazardunit_w_Rt_Rd),
                // OUT
                .PCEN_STALL(hazardunit_programcounter_PCEN_STALL),
                .PIPE0EN_STALL(hazardunit_pipe0_PIPE0EN_STALL),
                .clr_PIPE1(hazardunit_pipe1_clr_PIPE1),
                .d_mux4sel(hazardunit_mux4_d_mux4sel),
                .d_mux5sel(hazardunit_mux5_d_mux5sel),
                .e_mux6sel(hazardunit_mux6),
                .e_mux7sel(hazardunit_mux7)
             );
                        
    instruction_memory
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                //.ADDR_RF_WL()
                .ADDR_MEM(ADDR_MEM)
            )
        mod8
            /* IN & OUT */
            (
                // IN
                .f_IMA(programcounter_instmem_adder0),
                .rst(RESET_ALL),
                // OUT
                .f_IMRD(instmem_pipe0)
             );
                           
    mux0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod9
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .f_jaddr(jump_mux0_f_jaddr),
                .f_PC(adder0_pipe0_mux0),
                .f_PCbranch(signextension_pipe1_mux0),
                .f_mux0sel(concat0_mux0_f_mux0sel),
                // OUT
                .f_dout(mux0_programcounter)
             );
                           
    mux1
            /* PARAMETERS */
            #(
                //.ADDR_RF_WL()
            )
        mod10
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .e_RT(pipe1_mux1_hazardunit_e_Rt),
                .e_RD(pipe1_mux1_e_Rd),
                .e_mux1sel(pipe1_mux1_e_mux1sel),
                // OUT
                .e_dout(mux1_pipe2_hazardunit_e_Rt_Rd)
             );
                              
    mux2
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod11
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .e_RFRD2(mux7_mux2_pipe2_e_RFRD2_or_FWD_DATA),
                .e_SIGNED_IMMED(pipe1_mux2_e_SIGNED_IMMED),
                .e_mux2sel(pipe1_mux2_e_mux2sel),
                // OUT
                .e_dout(mux2_alu)
             );
                                   
    mux3
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod12
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .w_ALU_OUT(pipe3_mux3_w_ALU_OUT),
                .w_DMRD(pipe3_mux3_w_DMRD),
                .w_mux3sel(pipe3_mux3_e_mux3sel),
                // OUT
                .w_dout(mux3_regfile_mux6_mux7)
             );
                                      
    mux4
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod13
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .d_RFRD1(regfile_pipe1_mux4),
                .m_alu_out(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .d_mux4sel(hazardunit_mux4_d_mux4sel),
                // OUT
                .d_dout(mux4_comparator0)
             );
                                    
    mux5
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod14
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .d_RFRD2(regfile_pipe1_mux5),
                .m_alu_out(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .d_mux5sel(hazardunit_mux5_d_mux5sel),
                // OUT
                .d_dout(mux5_comparator0)
             );
                                   
    mux6
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod15
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .e_RFRD1(pipe1_mux6),
                .m_alu_out(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .w_mux3_out(mux3_regfile_mux6_mux7),
                .e_mux6sel(hazardunit_mux6),
                // OUT
                .e_dout(mux6_alu)
             );
                                    
    or0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod16
            /* IN & OUT */
            (
                // IN
                .d_jump(controlunit_or0_concat0),
                .d_branch(and0_or0),
                // OUT
                .f_mux0sel(or0_pipe0_concat0)
             );
                                       
    pipeline0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .ADDR_RF_WL(ADDR_RF_WL),
                .ADDR_MEM(ADDR_MEM),
                .IMMED_WL(IMMED_WL),
                .JUMP_WL(JUMP_WL)
            )
        mod17
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .clr(or0_pipe0_concat0),
                .PIPE0EN_STALL(hazardunit_pipe0_PIPE0EN_STALL),
                .f_instruction(instmem_pipe0),
                .f_PC(adder0_pipe0_mux0),
                // OUT
                .d_Rs(pipe0_regfile_pipe1_hazardunit_d_Rs),
                .d_Rt(pipe0_regfile_pipe1_hazardunit_d_Rt),
                .d_Rd(pipe0_pipe1_d_Rd),
                .d_shamt(pipe0_pipe1_d_shamt),
                .d_OPCODE(pipe0_controlunit_d_OPCODE),
                .d_FUNCT(pipe0_controlunit_d_FUNCT),
                .d_IMMED(pipe0_sign_extension),
                .d_JUMP(pipe0_jump),
                .d_PC(pipe0_jump_adder1) // take out adder1 from wire name
             );
                                              
    pipeline1
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .ADDR_RF_WL(ADDR_RF_WL),
                .ALU_WL(ALU_WL)
            )
        mod18
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .clr_PIPE1(hazardunit_pipe1_clr_PIPE1),
                .d_RFWE(controlunit_pipe1_d_RFWE),
                .d_mux3sel(controlunit_pipe1_d_mux3sel),
                .d_DMWE(controlunit_pipe1_d_DMWE),
                .d_mux1sel(controlunit_pipe1_d_mux1sel),
                .d_mux2sel(controlunit_pipe1_d_mux2sel),
                .d_ALU_sel(controlunit_pipe1_d_ALU_sel),
                .d_Rt(pipe0_regfile_pipe1_hazardunit_d_Rt),
                .d_Rd(pipe0_pipe1_d_Rd),
                .d_Rs(pipe0_regfile_pipe1_hazardunit_d_Rs),
                .d_shamt(pipe0_pipe1_d_shamt),
                .d_RFRD1(regfile_pipe1_mux4),
                .d_RFRD2(regfile_pipe1_mux5),
                .d_SIGNED_IMMED(signextension_pipe1_mux0),
                // OUT
                .e_RFWE(pipe1_pipe2_hazardunit_e_RFWE),
                .e_mux3sel(pipe1_pipe2_hazardunit_e_mux3sel),
                .e_DMWE(pipe1_pipe2_e_DMWE),
                .e_mux1sel(pipe1_mux1_e_mux1sel),
                .e_mux2sel(pipe1_mux2_e_mux2sel),
                .e_ALU_sel(pipe1_alu_alusel),
                .e_Rt(pipe1_mux1_hazardunit_e_Rt),
                .e_Rd(pipe1_mux1_e_Rd),
                .e_Rs(pipe1_hazardunit_e_Rs),
                .e_shamt(pipe1_alu_shamt),
                .e_RFRD1(pipe1_mux6),
                .e_RFRD2(pipe1_mux7),
                .e_SIGNED_IMMED(pipe1_mux2_e_SIGNED_IMMED)
             );
                                                        
    concat0
            /* PARAMETERS */
//            #(
//                .DATA_WL(DATA_WL),
//                .ADDR_RF_WL(ADDR_RF_WL),
//                .ALU_WL(ALU_WL)
//            )
        mod19
            /* IN & OUT */
            (
                // IN
                .f_jump(controlunit_or0_concat0),
                .or0(or0_pipe0_concat0),
                // OUT
                .d_out(concat0_mux0_f_mux0sel)
             );
                                                          
    mux7
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod20
            /* IN & OUT */
            (
                // IN
                .rst(RESET_ALL),
                .e_RFRD2(pipe1_mux7),
                .m_alu_out(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .w_mux3_out(mux3_regfile_mux6_mux7),
                .e_mux7sel(hazardunit_mux7),
                // OUT
                .e_dout(mux7_mux2_pipe2_e_RFRD2_or_FWD_DATA)
             );
                                                             
    pipeline2
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod21
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                //.stall(),
                .e_RFWE(pipe1_pipe2_hazardunit_e_RFWE),
                .e_mux3sel(pipe1_pipe2_hazardunit_e_mux3sel),
                .e_DMWE(pipe1_pipe2_e_DMWE),
                .e_ALU_out(alu_pipe2),
                .e_RFRD2(mux7_mux2_pipe2_e_RFRD2_or_FWD_DATA),
                .e_Rt_Rd(mux1_pipe2_hazardunit_e_Rt_Rd),
                // OUT
                .m_RFWE(pipe2_pipe3_hazardunit_m_RFWE),
                .m_mux3sel(pipe2_pipe3_hazardunit_m_mux3sel),
                .m_DMWE(pipe2_datamem_m_DMWE),
                .m_ALU_out(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .m_RFRD2(pipe2_datamem_m_DMWD),
                .m_Rt_Rd(pipe2_pipe3_hazardunit_m_Rt_Rd)
             );
                                                              
    pipeline3
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod22
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .m_RFWE(pipe2_pipe3_hazardunit_m_RFWE),
                .m_mux3sel(pipe2_pipe3_hazardunit_m_mux3sel),
                .m_ALU_out(pipe2_datamem_pipe3_mux4_mux5_mux6_mux7_m_alu_out),
                .m_DMRD(datamem_pipe3),
                .m_Rt_Rd(pipe2_pipe3_hazardunit_m_Rt_Rd),
                // OUT
                .w_RFWE(pipe3_regfile_hazardunit_m_RFWE),
                .w_mux3sel(pipe3_mux3_e_mux3sel),
                .w_ALU_out(pipe3_mux3_w_ALU_OUT),
                .w_DMRD(pipe3_mux3_w_DMRD),
                .w_Rt_Rd(pipe3_regfile_hazardunit_w_Rt_Rd)
             );
                                                                    
    program_counter
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod23
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .PCEN_STALL(hazardunit_programcounter_PCEN_STALL),
                .f_PCIN(mux0_programcounter),
                // OUT
                .f_PCOUT(programcounter_instmem_adder0)
             );
                                                                      
    register_file
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod24
            /* IN & OUT */
            (
                // IN
                .clk(clk),
                .rst(RESET_ALL),
                .d_RFWE(pipe3_regfile_hazardunit_m_RFWE),
                .d_RFRA1(pipe0_regfile_pipe1_hazardunit_d_Rs),
                .d_RFRA2(pipe0_regfile_pipe1_hazardunit_d_Rt),
                .d_RFWA(pipe3_regfile_hazardunit_w_Rt_Rd),
                .d_RFWD(mux3_regfile_mux6_mux7),
                // OUT
                .d_RFRD1(regfile_pipe1_mux4),
                .d_RFRD2(regfile_pipe1_mux5)
             );
                                                                            
    sign_extension
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .IMMED_WL(IMMED_WL)
            )
        mod25
            /* IN & OUT */
            (
                // IN
                .d_IMMED(pipe0_sign_extension),
                // OUT
                .d_SIGNED_IMMED(signextension_pipe1_mux0)
             );
                                                                            
    Jump
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .JUMP_WL(JUMP_WL)
            )
        mod26
            /* IN & OUT */
            (
                // IN
                .d_PC(pipe0_jump_adder1),
                .d_jump(pipe0_jump),
                .rst(RESET_ALL),
                // OUT
                .jaddr(jump_mux0_f_jaddr)
             );
             
    
endmodule
