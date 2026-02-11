# Lab5
E533 Lab 5: Pipelined Datapath Design (NetFPGA)
This project implements the hardware skeleton of an ARM-compatible processor datapath on the NetFPGA platform. The goal is to build the computational core that handles arithmetic operations and memory interaction.

🚀 Key Features
64-bit Synchronous ALU:

Designed a custom ALU supporting Add, Subtract, AND, OR, XNOR, Compare, and Logical Shift.

Includes overflow detection and synchronous output registers.
+1

Memory & Register File:


Register File: 64-bit wide with 2 read ports and 1 write-back port.


On-Chip Memory: Integrated BRAM for Instruction Memory (32-bit) and Data Memory (64-bit).
+1

Pipeline Datapath Skeleton:

Connected the ALU, Registers, and Memory into a pipeline structure.

Capable of executing basic custom instructions (Load/Store/Move) to verify data movement.

NetFPGA Integration:

Integrated the datapath into the user_datapath module of the reference router.

Implemented a software/hardware register interface to program memory and verify execution results.

🛠️ Tools Used
Hardware: NetFPGA

Language: Verilog HDL

Simulation: ModelSim / ISE
