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


module instruction_memory
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    ADDR_RF_WL  = 5,
    ADDR_MEM    = 32
)
/*** IN/OUT ***/
(
    // IN
    input                       rst,  
    input [ADDR_MEM - 1 : 0]    f_IMA,
    // OUT
    output [DATA_WL - 1 : 0]    f_IMRD
);

    reg [DATA_WL - 1 : 0] inst_mem [1 : 2**(ADDR_MEM-1)];
    
    initial $readmemb("inst_meme.mem", inst_mem);
    
    assign f_IMRD = (rst) ? 0 : inst_mem[f_IMA];
    
endmodule
