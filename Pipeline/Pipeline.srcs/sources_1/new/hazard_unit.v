`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2019 01:54:16 PM
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit
/*** PARAMETERS ***/
#(parameter
    // WL
    ADDR_RF_WL  = 5
)
/*** IN/OUT ***/
(
    // IN
    input                       d_Branch,
                                e_RFWE,
                                m_RFWE,
                                w_RFWE,
                                e_mux3sel,
                                m_mux3sel,
    // data
    input [ADDR_RF_WL - 1 : 0]  d_Rt,
                                d_Rs,
                                e_Rt,
                                e_Rs,
                                e_Rt_Rd,
                                m_Rt_Rd,
                                w_Rt_Rd,                               
    // OUT
    output                      PCEN_STALL,
                                PIPE0EN_STALL,
                                clr_PIPE1,
                                d_mux4sel,
                                d_mux5sel,
    output [1 : 0]              e_mux6sel,
                                e_mux7sel
);
    localparam choose_m_alu_out = 1'b0, choose_d_RFRD1 = 1, choose_d_RFRD2 = 1;
    localparam choose_e_RFRD2 = 0, choose_e_RFRD1 = 0, choose_w_mux3_out = 2, choose_mem_alu_out = 1;
    localparam STALL = 1, DONT_STALL = 0;
    
    wire Branchstall;
    
    /** DATA HAZARDS **/
    // IF this an R type and you intend to use the data that is about to be written into Rs/Rt, use data in the mem stage
    // ELSE IF this an R type and you intend to use the data that is about to be written into Rs/Rt, use data in the write stage
    // ELSE just use that data you got from Rs/Rt
    assign e_mux6sel        =       ((e_Rs != 0) && m_RFWE && (e_Rs == m_Rt_Rd)) ? choose_mem_alu_out 
                                    : ((e_Rs != 0) && w_RFWE && (e_Rs == w_Rt_Rd)) ? choose_w_mux3_out
                                    : choose_e_RFRD1;
    assign e_mux7sel        =       ((e_Rt != 0) && m_RFWE && (e_Rt == m_Rt_Rd)) ? choose_mem_alu_out
                                    : ((e_Rt != 0) && w_RFWE && (e_Rt == w_Rt_Rd)) ? choose_w_mux3_out 
                                    : choose_e_RFRD2;   
    
    /** CONTROL HAZARDS **/
    // Stall if you are waiting for the values to be computed for your branch instruction to do the comparison
    assign Branchstall      =       (d_Rs == e_Rt_Rd || d_Rt == e_Rt_Rd) && d_Branch && e_RFWE || (d_Rs == m_Rt_Rd || d_Rt == m_Rt_Rd) && d_Branch && m_mux3sel;
    
    // Stall if you are waiting for the data to come into the registers you are intending to use
    assign PCEN_STALL       =       ((e_mux3sel && ((e_Rt == d_Rs) || (e_Rt == d_Rt))) || Branchstall) ? STALL
                                    : DONT_STALL;
    assign PIPE0EN_STALL    =       ((e_mux3sel && ((e_Rt == d_Rs) || (e_Rt == d_Rt))) || Branchstall) ? STALL
                                    : DONT_STALL;
     
    // If the data needed for the branch instruction is available in the mem stage, you can forward it to the comparator
    // Otherwise that's why there is a branch stall
    assign d_mux4sel        =       ((d_Rs != 0) && (d_Rs == m_Rt_Rd) && m_RFWE) ? choose_m_alu_out 
                                    : choose_d_RFRD1;
    assign d_mux5sel        =       ((d_Rt != 0) && (d_Rt == m_Rt_Rd) && m_RFWE) ? choose_m_alu_out 
                                    : choose_d_RFRD1;   
                                    
    // Flush when you are stalling the program counter
    assign clr_PIPE1        =       PCEN_STALL;
                            
endmodule
