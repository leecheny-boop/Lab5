# Lab5
E533 Lab 5: Pipelined Datapath Design on NetFPGA
This repository contains the Verilog implementation of a Pipelined Datapath for an ARM-compatible processor, designed to run on the NetFPGA platform. This project is part of the E533 Laboratory #5 assignment.

The design progresses from a basic arithmetic unit to a fully integrated datapath within the NetFPGA reference router infrastructure, enabling hardware-accelerated packet processing and custom instruction execution.

📋 Project Overview
The project is divided into four main stages of development:

1. 64-bit Synchronous ALU

Design: Extended a synchronous adder into a full 64-bit Arithmetic Logic Unit (ALU).
+1


Capabilities: Supports addition, subtraction, bitwise AND/OR/XNOR, comparison, and logical shifts.

Features:

Synchronous output registered on the clock edge.

Overflow detection.

Custom control table for operation selection.

2. Register File & Memory Subsystem
Register File: Implemented a 64-bit Register File with:


2 Read Ports (async read).
+1


1 Write-back Port (sync write).
+1

Minimum of 4 registers (depth).

Memory:


Instruction Memory (I-Mem): 32-bit wide, single-port Block RAM (BRAM).


Data Memory (D-Mem): 64-bit wide, dual-port Block RAM (BRAM).

3. Pipeline Skeleton
Integration of the Register File, I-Mem, and D-Mem into a pipelined datapath framework.

Designed to test memory interfaces and data movement without a complex controller.

Instruction Format: Custom bit-vector instructions for testing:

WMemEn (Write Memory Enable)

WRegEn (Write Register Enable)

Reg1 / Reg2 (Source Registers)


WReg1 (Destination Register).
+1

4. NetFPGA Integration
Integrated the custom datapath into the user_datapath module of the NetFPGA reference router.


SW/HW Interface: Implemented a register-based interface to program the I-Mem and D-Mem from software.


Verification: Validated using the idsreg script to inject commands and verify packet processing/dropping logic (Mini-IDS functionality).
+1

🛠️ Hardware Architecture
(建議在此處放入你的 Block Diagram 截圖，例如 Figure 3: Skeleton Pipelined Datapath)

The datapath isolates the processor from the router design while maintaining connectivity through input/output pins in user_datapath.v.

📂 File Structure
Plaintext
.
├── src/
│   ├── alu.v              # 64-bit Synchronous ALU
│   ├── reg_file.v         # Dual-port read, single-port write Register File
│   ├── datapath.v         # Pipeline skeleton connecting Mem and RegFile
│   ├── user_datapath.v    # Top-level integration wrapper for NetFPGA
│   └── ...
├── sim/
│   ├── testbench_alu.v    # Simulation for ALU verification
│   ├── testbench_pipe.v   # Pipeline execution tests
│   └── ...
├── scripts/
│   └── idsreg.pl          # Perl script for register interface testing [cite: 14]
└── bitfiles/
    └── ...
🚀 How to Run
Simulation
Open the project in your Verilog simulator (ModelSim/Vivado/ISE).

Load the testbench files located in sim/.

Verify the waveform outputs for ALU operations and Pipeline memory transfers.
+1

NetFPGA Deployment

Synthesis: Compile the source code to generate the bitfile.


Download: Use nf_download to load the bitfile onto the FPGA node.

Setup: Run cpci_reprogram.pl and configure the interfaces.

Testing:

Use the idsreg script to write patterns to the hardware registers.

Run iperf to generate traffic and verify packet filtering/processing.

📝 Testing Results
ALU: Successfully verified all arithmetic and logical operations via simulation.


Pipeline: Verified data loading from D-Mem to Registers and store-back operations.


Mini-IDS: Confirmed "bad" packets are dropped in UDP/TCP modes using the integrated hardware logic.

👥 Authors
[I-Hsuan Lin]

[Michelle Lu]

Acknowledgments
Course material and specifications provided by Prof. Young Cho, USC.
