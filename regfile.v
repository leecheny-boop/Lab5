`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:53 02/11/2026 
// Design Name: 
// Module Name:    regfile 
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
// regfile.v  -- ISE/XST friendly
// regfile.v  -- ISE/XST friendly, synchronous write and synchronous read
module regfile(
  input  wire            clk,
  input  wire            rst,      // synchronous reset
  // write port
  input  wire [3:0]     waddr,
  input  wire [63:0]    wdata,
  input  wire            wena,
  // read port 0
  input  wire [3:0]     r0addr,
  output reg  [63:0]    r0data,
  // read port 1
  input  wire [3:0]     r1addr,
  output reg  [63:0]    r1data
);

  // register array
  reg [63:0] regs [0:15];
  integer i;

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 16; i = i + 1) regs[i] <= {64{1'b0}};
      r0data <= {64{1'b0}};
      r1data <= {64{1'b0}};
    end else begin
      if (wena) begin
        regs[waddr] <= wdata;
      end
      // synchronous reads: outputs update at posedge
      r0data <= regs[r0addr];
      r1data <= regs[r1addr];
    end
  end

endmodule