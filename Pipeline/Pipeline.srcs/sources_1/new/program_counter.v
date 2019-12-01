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


module program_counter
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
                                    PCEN_STALL,
    input [DATA_WL - 1 : 0]         f_PCIN,
    // OUT
    output [DATA_WL - 1 : 0]        f_PCOUT
);

    reg [DATA_WL - 1 : 0] PC_REG;
    
    initial
    begin
        PC_REG = 0;
    end
    
    always @ (posedge clk)
    begin
        if (rst) PC_REG         <= 0;
        else if (PCEN_STALL);   // do nothing
        else PC_REG             <= f_PCIN;
    end
    
    assign f_PCOUT = PC_REG;
    
endmodule
