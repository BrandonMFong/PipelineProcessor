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


module data_memory
/*** PARAMETERS ***/
#(parameter
    // WL
    DATA_WL     = 32,
    ADDR_MEM    = 32
)
/*** IN/OUT ***/
(
    // IN
    input                       clk,
                                rst,
                                m_DMWE,
    input [DATA_WL - 1 : 0]     m_DMA,
                                m_DMWD,
    // OUT
    output [DATA_WL - 1 : 0]    m_DMRD
);

    reg [DATA_WL - 1 : 0] data_mem [0 : 2**(ADDR_MEM-1)];
    integer i = 0;
    
    initial // Do I need this?
    begin   // check if this is where you should store these values.
            // You experienced this in the multicycle
        data_mem[0] = 17;
        data_mem[1] = 31;
        data_mem[2] = -5;
        data_mem[3] = -2;
        data_mem[4] = 250;
        for (i = 5; i < (2**(ADDR_MEM-1)); i = i + 1) data_mem[i] = 0;
    end
    
    always @(posedge clk) if(m_DMWE)data_mem[m_DMA] = m_DMWD;
    
    assign m_DMRD = (rst) ? 0 : data_mem[m_DMA];
    
endmodule
