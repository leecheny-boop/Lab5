`timescale 1ns/1ps

module I_MEM (
    input  wire        clk,
    input  wire        we,          // write enable
    input  wire [8:0]  addr,        // 512 depth
    input  wire [31:0] din,
    output reg  [31:0] dout
);

    // 512 x 32 memory
    reg [31:0] mem [0:511];

    // ==========================================
    // Optional: preload instruction from file
    // ==========================================
    initial begin
        $readmemh("instruction.txt", mem);
    end

    // ==========================================
    // Synchronous memory behavior
    // ==========================================
    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;

        // synchronous read
        dout <= mem[addr];
    end

endmodule
