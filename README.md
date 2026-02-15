# E533 Lab 5: Pipelined Datapath Design for ARM-Compatible Processor

This repository contains the Verilog implementation of a 5-stage pipelined processor datapath designed for the NetFPGA platform. The project is part of the USC E533 course (Network Processor Design).

## 📖 Project Overview

The goal of this laboratory is to design, simulate, and integrate a custom ARM-compatible processor core into the NetFPGA Router reference design. The system features a 5-stage pipeline architecture and a software/hardware register interface that allows the host to program the Instruction Memory (I-Mem) and inspect the Data Memory (D-Mem).

### Key Features
* **5-Stage Pipeline Architecture**:
    * **IF (Instruction Fetch)**: PC update and instruction retrieval.
    * **ID (Instruction Decode)**: Control signal generation and Register File access.
    * **EX (Execute)**: ALU operations (Add, Sub, Logic, Shift).
    * **MEM (Memory Access)**: Data memory read/write operations.
    * **WB (Write Back)**: Writing results back to the Register File.
* **Memory Architecture**: Integrated Block RAM (BRAM) for separate Instruction and Data memories.
* **SW/HW Interface**: Custom register interface to program the processor via the NetFPGA `reg_write` / `reg_read` tools.

## 📂 File Structure

```text         
E533-Lab5-Processor/
├── src/
│   ├── pipeline_datapath.v       # Top-level module connecting all pipeline stages
│   ├── regfile.v      # 64-bit Register File (2 Read Ports, 1 Write Port)
│   ├── I_MEM.v        # Instruction Memory wrapper (BRAM)
│   ├── D_MEM.v        # Data Memory wrapper (BRAM)
│   ├── alu.new.v      # Arithmetic Logic Unit (Part 1)
├── sim/
│   ├── tb.v           # Testbench: Verifies instruction flow and data hazards
├── docs/
│   ├── projects report          # Screen captures of the synthesized schematics
│   ├── inst.coe          # Instructions thta fectched by IF
│   ├── data.coe          # Original Data that stored in D_MEM
└── README.md
