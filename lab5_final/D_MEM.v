`timescale 1ns/1ps

module D_MEM (
    input  wire        clka,          // write clock
    input  wire [63:0] dina,          // write data
    input  wire [7:0]  addra,         // write address
    input  wire        wea,           // write enable

    input  wire        clkb,          // read clock
    input  wire [7:0]  addrb,         // read address
    output reg  [63:0] doutb          // read data
);

    (* ram_style = "block" *)
    reg [63:0] mem [0:255];


    // load from file
    initial begin
        $readmemh("data.txt", mem);
    end


    // Port A : Write
    always @(posedge clka) begin
        if (wea)
            mem[addra] <= dina;
    end

    // Port B : Read
    always @(posedge clkb) begin
        doutb <= mem[addrb];
    end

endmodule
