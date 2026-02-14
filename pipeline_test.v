`timescale 1ns / 1ps

module pipeline_test;

    reg clk;
    reg rst;

    pipeline_datapath uut (
        .clk(clk), 
        .rst(rst)
    );

    always #5 clk = ~clk;

    integer i;
    
    initial begin
        // --- ????? ---
        clk = 0;
        rst = 1;

        uut.my_dmem.memory_array[0] = 64'd12345; 

        uut.my_regfile.registers[0] = 64'd0; 
        uut.my_regfile.registers[1] = 64'd1; // ? R1 ? 1 (???? 1)

        uut.my_imem.memory_array[0] = {1'b0, 1'b1, 3'd0, 3'd0, 3'd2, 21'd0};

        uut.my_imem.memory_array[1] = 32'd0;

        uut.my_imem.memory_array[2] = 32'd0;

        uut.my_imem.memory_array[3] = {1'b1, 1'b0, 3'd1, 3'd2, 3'd0, 21'd0};

        for (i = 4; i < 20; i = i + 1) begin
            uut.my_imem.memory_array[i] = 32'd0;
        end

        $display("Starting Simulation...");
        #20 rst = 0; // ?? Reset

        #150;
        
        $display("Simulation Finished.");
        $stop;
    end

    // =========================================================
    // 4. ???? (Monitor)
    // =========================================================
    initial begin
        $monitor("Time=%3dns | PC=%2d | Instr=%h | IF_ID_Instr=%h | WriteReg=%b | WriteAddr=%d | WB_Data=%d", 
                 $time, uut.PC, uut.Instruction, uut.IF_ID_Instr, uut.MEM_WB_WRegEn, uut.MEM_WB_WRegAddr, uut.MEM_WB_Data);
    end

endmodule
