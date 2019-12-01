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


module register_file
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
    input                           clk,
                                    rst,
                                    d_RFWE,
    input [ADDR_RF_WL - 1 : 0]      d_RFRA1,
                                    d_RFRA2,
                                    d_RFWA,
    input [DATA_WL - 1 : 0]         d_RFWD,
    // OUT
    output [DATA_WL - 1 : 0]        d_RFRD1,
                                    d_RFRD2
);

    reg [DATA_WL - 1 : 0] MEM [0 : 2**ADDR_RF_WL - 1];
    reg [ADDR_RF_WL - 1 : 0] ADDR1, ADDR2;
    reg [DATA_WL - 1 : 0] REG1, REG2;
    integer i;
    
    /* Default vals for register file */
    initial 
    begin
        ADDR1 = 0;
        ADDR2 = 0;
        MEM[0] = 0;
        MEM[1] = 0;
        MEM[2] = 0;
        MEM[3] = 0;
        MEM[4] = 0;
        MEM[5] = 0;
        MEM[6] = 0;
        MEM[7] = 0;
        MEM[8] = 0;
        MEM[9] = 0;
        MEM[10] = 0;
        MEM[11] = 0;
        MEM[12] = 0;
        MEM[13] = 0;
        MEM[14] = 0;
        MEM[15] = 0;
        MEM[16] = 0;
        MEM[17] = 0;
        MEM[18] = 0;
        MEM[19] = 0;
        MEM[20] = 0;
        MEM[21] = 0;
        MEM[22] = 0;
        MEM[23] = 0;
        MEM[24] = 0;
        MEM[25] = 0;
        MEM[26] = 0;
        MEM[27] = 0;
        MEM[28] = 0;
        MEM[29] = 0;
        MEM[30] = 0;
        MEM[31] = 0;
    end
    
    always @ (posedge clk)
    begin
        /*** WRITE FIRST ***/
        if (!rst)
        begin
            if(d_RFWE) MEM[d_RFWA] <= d_RFWD;
        end
    end
    
    /*** DELAYED READ ***/
    // commenting out because sw for part b is not getting the data on time
    //assign d_RFRD1 = (rst) ? 0 : MEM[ADDR1];
    //assign d_RFRD2 = (rst) ? 0 : MEM[ADDR2];
    
    // this is for part b, TODO figure out the delay
    assign d_RFRD1 = (rst) ? 0 : (d_RFRA1 == d_RFWA) ? d_RFWD : MEM[d_RFRA1];
    assign d_RFRD2 = (rst) ? 0 : (d_RFRA2 == d_RFWA) ? d_RFWD : MEM[d_RFRA2];
endmodule
