`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:10 02/11/2026 
// Design Name: 
// Module Name:    alu_new 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu_new(
    input clk,
    input [63:0] A,
    input [63:0] B,
    input [2:0] aluctrl,
    output reg [63:0] Z,
    output reg overflow
    );
	 
	 reg [64:0] temp_result;
	 
	 always @(posedge clk) begin
	 
		overflow <=0;
		
		case (aluctrl)
			3'b000: begin //ADD
				temp_result = A+B;
				Z <= temp_result[63:0];
				overflow <= temp_result[64];
			end
			
			3'b001: begin //SUB
				Z <= A - B;
			end
			
			3'b010: begin //AND
				Z <= A & B;
			end
			
			3'b011: begin //OR
				Z <= A | B;
			end
			
			3'b100: begin //XNOR
				Z <= ~(A ^ B);
			end
			
			3'b101: begin //LOGICAL SHIFT
				Z <= A << B[5:0];
			end
			
			3'b110: begin //Compare
				if (A == B)
					Z <= 64'd1;
				else
					Z <= 64'd0;
			end
			
			default: Z <= 64'd0;
		endcase
	end

endmodule
