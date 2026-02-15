`timescale 1ns / 1ps

module tb;

reg clk;
reg rst;

integer i;

// DUT
pipeline_datapath uut (
    .clk(clk),
    .rst(rst)
);


// Clock
always #5 clk = ~clk;

// Initialize
initial begin
    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    #200;
    $display("Simulation finished.");
    $stop;
end

// Print Register File Every Cycle
always @(posedge clk) begin
    if (!rst) begin

        $display("\n=====================================================");
        $display("Time = %0t", $time);

        // PC & Instruction
        $display("PC = %d", uut.PC);
        $display("IF_ID_Instr = %h", uut.IF_ID_Instr);

        // ID stage
        $display("ID: R1_Data=%d | R2_Data=%d",
                 uut.R1_Data,
                 uut.R2_Data);

        // MEM stage
        $display("MEM: Addr=%d | Mem_Dout=%d | WMemEn=%b",
                 uut.dmem_addr,
                 uut.Mem_Dout,
                 uut.ID_MEM_WMemEn);

        // WB stage
        $display("WB: en=%b | addr=%d | data=%d",
                 uut.MEM_WB_WRegEn,
                 uut.MEM_WB_WRegAddr,
                 uut.MEM_WB_Data);

        // Register file
        $display("----- Register File -----");
        for (i = 0; i < 8; i = i + 1)
            $display("R[%0d] = %d", i, uut.reg_file.regs[i]);

        // Data memory snapshot
        $display("----- Data Memory -----");
        $display("Mem[0] = %d", uut.DMEM.mem[0]);
        $display("Mem[4] = %d", uut.DMEM.mem[4]);

        $display("=====================================================");
    end
end

endmodule

