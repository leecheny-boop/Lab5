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
module regfile #(
  parameter W  = 64,   // data width
  parameter N  = 16,   // number of registers
  parameter AW = 4     // address width (log2(N)), set manually for safety
)(
  input  wire            clk,
  input  wire            rst,      // synchronous reset
  // write port
  input  wire [AW-1:0]   waddr,
  input  wire [W-1:0]    wdata,
  input  wire            wena,
  // read port 0
  input  wire [AW-1:0]   r0addr,
  output reg  [W-1:0]    r0data,
  // read port 1
  input  wire [AW-1:0]   r1addr,
  output reg  [W-1:0]    r1data
);

  // register array
  reg [W-1:0] regs [0:N-1];
  integer i;

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < N; i = i + 1) regs[i] <= {W{1'b0}};
      r0data <= {W{1'b0}};
      r1data <= {W{1'b0}};
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
