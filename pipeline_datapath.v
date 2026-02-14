`timescale 1ns / 1ps

module pipeline_datapath (
    input clk,
    input rst
);

    // =========================================================
    // 1. ???? (Wires & Registers)
    // =========================================================
    
    // --- PC ?? ---
    reg  [8:0]  PC;              // Program Counter
    wire [31:0] Instruction;     // ? I_MEM ?????
    
    // --- Pipeline Register 1 (IF -> ID) ---
    reg  [31:0] IF_ID_Instr;
    
    // --- ???? (???????) ---
    //[cite_start]// ?? Lab ?? [cite: 121-123]: WMemEn(1), WRegEn(1), Reg1(3), Reg2(3), WReg1(3)
    // ??????????? (???????????):
    wire        WMemEn   = IF_ID_Instr[31];
    wire        WRegEn   = IF_ID_Instr[30];
    wire [2:0]  Reg1Addr = IF_ID_Instr[29:27];
    wire [2:0]  Reg2Addr = IF_ID_Instr[26:24];
    wire [2:0]  WRegAddr = IF_ID_Instr[23:21];

    // --- RegFile ???? ---
    wire [63:0] R1_Data;
    wire [63:0] R2_Data;

    // --- Pipeline Register 2 (ID -> MEM) ---
    reg  [63:0] ID_MEM_R1;      // ???????
    reg  [63:0] ID_MEM_R2;      // ??????
    reg         ID_MEM_WMemEn;
    reg         ID_MEM_WRegEn;
    reg  [2:0]  ID_MEM_WRegAddr;

    // --- D_MEM ?? ---
    wire [63:0] Mem_Dout;
    wire [7:0] dmem_addr;
    assign dmem_addr = ID_MEM_R1[7:0];

    // --- Pipeline Register 3 (MEM -> WB) ---
    reg  [63:0] MEM_WB_Data;    // ??????????
    reg         MEM_WB_WRegEn;
    reg  [2:0]  MEM_WB_WRegAddr;

    // =========================================================
    // 2. ????? (Instantiation) - ?????
    // =========================================================

    // --- A. I_MEM (?????) ---
    // ???? I_MEM ???? "instruction_memory"
    I_MEM IMEM (
        .clka(clk),
	.dina(32'b0),
        .addra(PC),          // PC ????
	.wea(1'b0),
        .douta(Instruction)  // ????
    );

    // --- B. RegFile (?????) ---
    // ???? RegFile ???? "register_file"
    regfile reg_file (
        .clk(clk),
	.rst(rst),
        // ??? (Decode Stage)
        .r0addr(Reg1Addr),   
        .r1addr(Reg2Addr),
        .r0data(R1_Data),
        .r1data(R2_Data),
        // ??? (Write Back Stage) - ?? Pipeline ????
        .wena(MEM_WB_WRegEn),
        .waddr(MEM_WB_WRegAddr),
        .wdata(MEM_WB_Data)
    );

    // --- C. D_MEM (?????) ---
    // ???? D_MEM ???? "data_memory"
    D_MEM DMEM (
    	.clka (clk),                    
    	.dina (ID_MEM_R2),              
    	.addra(dmem_addr),             
    	.wea  (ID_MEM_WMemEn),          
   	.clkb (clk),                    
    	.addrb(dmem_addr),              
    	.doutb(Mem_Dout)                
    );

    // =========================================================
    // 3. ???? (Behavior & Pipeline Registers)
    // =========================================================

    // --- Stage 1: Fetch (PC ??) ---
    always @(posedge clk) begin
        if (rst) 
            PC <= 0;
        else 
            PC <= PC + 1; // ??? PC+1????? Jump/Branch
    end

    // --- Pipeline 1: IF -> ID ---
    always @(posedge clk) begin
        if (rst) 
            IF_ID_Instr <= 0;
        else 
            IF_ID_Instr <= Instruction;
    end

    // --- Pipeline 2: ID -> MEM ---
    always @(posedge clk) begin
        if (rst) begin
            ID_MEM_R1       <= 0;
            ID_MEM_R2       <= 0;
            ID_MEM_WMemEn   <= 0;
            ID_MEM_WRegEn   <= 0;
            ID_MEM_WRegAddr <= 0;
        end else begin
            ID_MEM_R1       <= R1_Data;     // ?? Reg1 ??
            ID_MEM_R2       <= R2_Data;     // ?? Reg2 ??
            ID_MEM_WMemEn   <= WMemEn;      // ??????
            ID_MEM_WRegEn   <= WRegEn;
            ID_MEM_WRegAddr <= WRegAddr;
        end
    end

    // --- Pipeline 3: MEM -> WB ---
    always @(posedge clk) begin
        if (rst) begin
            MEM_WB_Data     <= 0;
            MEM_WB_WRegEn   <= 0;
            MEM_WB_WRegAddr <= 0;
        end else begin
            MEM_WB_Data     <= Mem_Dout;      // ??????????
            MEM_WB_WRegEn   <= ID_MEM_WRegEn; // ????????
            MEM_WB_WRegAddr <= ID_MEM_WRegAddr;
        end
    end

endmodule
