`timescale 1ns/1ps

module I_MEM (
    input  wire        clk,
    input  wire        we,          // write enable
    input  wire [8:0]  addr,        // 512 depth
    input  wire [31:0] din,
    output reg  [31:0] dout
);

    reg [31:0] mem [0:511];

    // load instruction from file
    initial begin
        $readmemh("instruction.txt", mem);
    end

    // Synchronous memory 
    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;

        // synchronous read
        dout <= mem[addr];
    end

endmodule
