module topmodule(
    input clk,reset,
    output[15:0] writedata,addr,
    output memwrite
);
    wire[15:0] readdata;
    multicycle mc(clk,reset,addr,writedata,memwrite,readdata);
    memory mem(clk,memwrite,addr,writedata,readdata);
endmodule