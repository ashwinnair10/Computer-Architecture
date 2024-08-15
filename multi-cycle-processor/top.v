module top(
    input clk, reset,
    output [31:0] writedata, addr,
    output memwrite
);
    wire [31:0] readdata;
    mips mips(clk, reset, addr, writedata, memwrite, readdata);
    mem mem(clk, memwrite, addr, writedata, readdata);
endmodule