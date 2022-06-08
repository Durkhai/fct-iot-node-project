/* ********************************************************************************* */
/*                      multiplier place holder                                      */
/*                                                                                   */
/*  Author:  Chuck Cox (chuck100@home.com)                                           */
/*                                                                                   */
/*                                                                                   */
/*                                                                                   */
/* ********************************************************************************* */
`default_nettype none

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2022 12:34:59 AM
// Design Name: 
// Module Name: mult
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


module multa(
    input clk,
    input enable,
    input [8:0] a,
    input [12:0] b,
    output [21:0] p
    );
    
    reg [31:0] p_s;
    
    reg SignFlag_0, SignFlag_1, SignFlag_2, SignFlag_3;

    reg [15:0] reg_a;
    reg [15:0] reg_b;
    
    reg [15:0] reg1_a;
    reg [15:0] reg1_b;
    
    reg [19:0] Sum0_Reg3;
    reg [19:0] Sum1_Reg3;
    reg [19:0] Sum2_Reg3;
    reg [19:0] Sum3_Reg3;

    reg [19:0] P0_Reg2;
    reg [19:0] P1_Reg2;
    reg [19:0] P2_Reg2;
    reg [19:0] P3_Reg2;
    reg [19:0] P4_Reg2;
    reg [19:0] P5_Reg2;
    reg [19:0] P6_Reg2;
    reg [19:0] P7_Reg2;
    reg [19:0] P8_Reg2;
    reg [19:0] P9_Reg2;
    reg [19:0] P10_Reg2;
    reg [19:0] P11_Reg2;
    reg [19:0] P12_Reg2;
    reg [19:0] P13_Reg2;
    reg [19:0] P14_Reg2;
    reg [19:0] P15_Reg2;
    
    
    always @(posedge clk & enable) begin

            reg_a <= {7'b0 , a};
            reg_b <= {3'b0 , b};
           
            if (reg_a[15] == 1'b1) 
                reg1_a <= (~reg_a) + 1;
            else 
                reg1_a <= reg_a;
                
            if (reg_b[15] == 1'b1) 
                reg1_b <= (~reg_b) + 1;
            else 
                reg1_b <= reg_b;
                          
            if ( ( (reg_a[15] == 1'b1) &  (reg_b[15] == 1'b1) ) | ( (reg_a[15] == 1'b0) & (reg_b[15] == 1'b0) ) )
                SignFlag_0 <= 1'b0;
            else 
                SignFlag_0 <= 1'b0;
  end    
  
    always @(posedge clk & enable) begin           
            P0_Reg2 <= reg1_a[3:0] * reg1_b[3:0]; // Multiplication Product of A0B0  
            P1_Reg2 <= reg1_a [3:0] * reg1_b[7:4]; // Multiplication Product of A0B1 
            P2_Reg2 <= reg1_a [3:0] * reg1_b[11:8]; // Multiplication Product of A0B2
            P3_Reg2 <= reg1_a [3:0] * reg1_b[15:12]; // Multiplication Product of A0B3
             
            P4_Reg2 <= reg1_a [7:4] * reg1_b[3:0]; // Multiplication Product of A1B0
            P5_Reg2 <= reg1_a [7:4] * reg1_b[7:4]; // Multiplication Product of A1B1
            P6_Reg2 <= reg1_a [7:4] * reg1_b[11:8]; // Multiplication Product of A1B2
            P7_Reg2 <= reg1_a [7:4] * reg1_b[15:12];// Multiplication Product of A1B3
            
            P8_Reg2 <= reg1_a [11 : 8] * reg1_b[3:0]; // Multiplication Product of A2B0
            P9_Reg2 <= reg1_a [11 : 8] * reg1_b[7:4]; // Multiplication Product of A2B1  
            P10_Reg2 <= reg1_a[11 : 8] * reg1_b[11:8]; // Multiplication Product of A2B2
            P11_Reg2 <= reg1_a[11 : 8] * reg1_b[15:12]; // Multiplication Product of A2B3
            
            P12_Reg2 <= reg1_a[15 : 12] * reg1_b[3:0];  // Multiplication Product of A3B0
            P13_Reg2 <= reg1_a[15 : 12] * reg1_b[7:4];  // Multiplication Product of A3B1
            P14_Reg2 <= reg1_a[15 : 12] * reg1_b[11:8];  // Multiplication Product of A3B2
            P15_Reg2 <= reg1_a[15 : 12] * reg1_b[15:12]; // Multiplication Product of A3B3
            
            SignFlag_1 <= SignFlag_0;
            
     end
     
       always @(posedge clk & enable) begin       
            
            Sum0_Reg3 <= {12'b0 , P0_Reg2} + {8'b0 , P1_Reg2 , 4'b0} + {4'b0 , P2_Reg2 , 8'b0} +{P3_Reg2 , 12'b0};
            
            Sum1_Reg3 <= {12'b0 , P4_Reg2}+{8'b0 , P5_Reg2 , 4'b0}+{4'b0 , P6_Reg2 , 8'b0}+{P7_Reg2 , 12'b0};

            Sum2_Reg3 <= {12'b0 , P8_Reg2}+{8'b0 , P9_Reg2 , 4'b0}+{4'b0 , P10_Reg2 , 8'b0}+{P11_Reg2 , 12'b0};
    
            Sum3_Reg3 <= {12'b0 , P12_Reg2}+{8'b0 , P13_Reg2 , 4'b0}+{4'b0 , P14_Reg2 , 8'b0}+{P15_Reg2 , 12'b0};

            SignFlag_2 <= SignFlag_1;    // here we propagate the number value sign 
            
    end 
    
      always @(posedge clk & enable) begin
            
            //final Sum
            
            if(SignFlag_2 == 1'b1)
                p_s <= ( ~( {8'b0 , ( {4'b0 , Sum0_Reg3} + {Sum1_Reg3 , 4'b0} )} + {( {4'b0,Sum2_Reg3} + {Sum3_Reg3,4'b0} ) , 8'b0} ) + 1);
            else
                p_s <= ( {8'b0,(   {4'b0,Sum0_Reg3} + {Sum1_Reg3,4'b0}   )} + { (   {4'b0,Sum2_Reg3} + {Sum3_Reg3,4'b0}   ) , 8'b0} );
    end
    
    assign p = p_s[21:0];
    
endmodule

`default_nettype wire
