module topmodule(
    input clk, reset,
    output [31:0] writedata, addr,
    output memwrite
);
    wire [31:0] readdata;
    multicycle mc(clk, reset, addr, writedata, memwrite, readdata);
    memory mem(clk, memwrite, addr, writedata, readdata);
endmodule