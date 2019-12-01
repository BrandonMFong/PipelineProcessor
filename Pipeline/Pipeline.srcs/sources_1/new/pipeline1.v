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


module pipeline1
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    ADDR_RF_WL  = 5,
    ALU_WL      = 4
)
/*** IN/OUT ***/
(
    // IN
    input                           clk,
                                    rst,
                                    stall,
                                    clr_PIPE1,
    input                           d_RFWE,
                                    d_mux3sel,
                                    d_DMWE,
                                    d_mux1sel,
                                    d_mux2sel,
    input [ALU_WL - 1 : 0]          d_ALU_sel,
    input [ADDR_RF_WL - 1 : 0]      d_Rt,
                                    d_Rd,
                                    d_Rs,
                                    d_shamt,//is not an addr but just sharing the delcaration 
    input [DATA_WL - 1 : 0]         d_RFRD1,
                                    d_RFRD2,
                                    d_SIGNED_IMMED,
    // OUT
    output reg                      e_RFWE,
                                    e_mux3sel,
                                    e_DMWE,
                                    e_mux1sel,
                                    e_mux2sel,
    output reg [ALU_WL - 1 : 0]     e_ALU_sel,
    output reg [ADDR_RF_WL - 1 : 0] e_Rt,
                                    e_Rd,
                                    e_Rs,
                                    e_shamt,//is not an addr but just sharing the delcaration 
    output reg [DATA_WL - 1 : 0]    e_RFRD1,
                                    e_RFRD2,
                                    e_SIGNED_IMMED
);

    always @ (posedge clk)
    begin
        if(clr_PIPE1 || rst)
        begin
            e_RFWE          <= 0;
            e_mux3sel       <= 0;
            e_DMWE          <= 0;
            e_mux1sel       <= 0;
            e_mux2sel       <= 0;
            e_ALU_sel       <= 0;
            e_Rt            <= 0;
            e_Rd            <= 0;
            e_Rs            <= 0;
            e_shamt         <= 0;
            e_RFRD1         <= 0;
            e_RFRD2         <= 0;
            e_SIGNED_IMMED  <= 0;
        end
        else
        begin
            e_RFWE          <= d_RFWE;
            e_mux3sel       <= d_mux3sel;
            e_DMWE          <= d_DMWE;
            e_mux1sel       <= d_mux1sel;
            e_mux2sel       <= d_mux2sel;
            e_ALU_sel       <= d_ALU_sel;
            e_Rt            <= d_Rt;
            e_Rd            <= d_Rd;
            e_Rs            <= d_Rs;
            e_shamt         <= d_shamt;
            e_RFRD1         <= d_RFRD1;
            e_RFRD2         <= d_RFRD2;
            e_SIGNED_IMMED  <= d_SIGNED_IMMED;
        end
    end

endmodule
