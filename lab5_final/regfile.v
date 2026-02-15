module regfile(
  input  wire            clk,
  input  wire            rst,
  input  wire [2:0]      waddr,
  input  wire [63:0]     wdata,
  input  wire            wena,

  input  wire [2:0]      r0addr,
  output wire [63:0]     r0data,
  input  wire [2:0]      r1addr,
  output wire [63:0]     r1data
);

  reg [63:0] regs [0:15];
  integer i;

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 16; i = i + 1)
        regs[i] <= 64'b0;
    end else begin
      if (wena && waddr != 0)   // lock R0
        regs[waddr] <= wdata;
    end
  end

  assign r0data = (r0addr == 0) ? 64'b0 : regs[r0addr];
  assign r1data = (r1addr == 0) ? 64'b0 : regs[r1addr];

endmodule
