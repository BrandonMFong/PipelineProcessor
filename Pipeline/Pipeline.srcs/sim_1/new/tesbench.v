`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 09:05:54
// Design Name: 
// Module Name: testbench
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


module testbench0;

reg clk, rst;

top_module
        mod0
            /* IN/OUT */
            (
                // IN
                .clk(clk),
                .RESET_ALL(rst)
            );

    initial clk <= 0;
    always #5 clk <= ~clk;
    initial
    begin
        rst = 1;
        #20
        rst = 0;
        #5000;
        $finish;
    end
endmodule