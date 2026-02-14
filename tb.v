`timescale 1ns / 1ps

module tb_pipeline();

    // ==========================================
    // 1. 宣告測試用的訊號
    // ==========================================
    reg clk;
    reg rst;

    // ==========================================
    // 2. 實例化你的管線 CPU (Unit Under Test)
    // ==========================================
    pipeline_datapath uut (
        .clk(clk),
        .rst(rst)
    );

    // ==========================================
    // 3. 產生時鐘訊號 (10ns 週期，相當於 100MHz)
    // ==========================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 每 5ns 翻轉一次
    end

    // ==========================================
    // 4. 控制測試流程 (Stimulus)
    // ==========================================
    initial begin
        // 一開始先啟動 Reset，讓 CPU 內部狀態歸零
        rst = 1;
        #20; 
        
        // 經過 20ns 後放開 Reset，CPU 會開始從 I-MEM 抓取 .coe 的指令執行！
        rst = 0; 

        // 讓系統跑 150ns (大約 15 個 Clock Cycle，足夠跑完你的 5 個指令了)
        #150;
        
        // 結束模擬
        $display("=== 模擬結束 ===");
        $finish;
    end

    // ==========================================
    // 5. 監聽器 (Monitor) - Debug 神器！
    // ==========================================
    // 這段會在每個 Clock 上升沿，把 CPU 的重要內部狀態印在 Console 視窗裡
    always @(posedge clk) begin
        if (!rst) begin
            $display("Time=%0t | PC=%d | Inst=%h | Reg2=%d | Reg3=%d | MemWrite=%b", 
                      $time, uut.PC, uut.Instruction, uut.reg_file.regs[2], uut.reg_file.regs[3], uut.ID_MEM_WMemEn);
        end
    end

endmodule