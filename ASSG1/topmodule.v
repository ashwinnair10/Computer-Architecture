module topmodule(
    input clk,reset
);
    wire[15:0] readdata,wd,addr;
    wire memwrite;
    multicycle mc(clk,reset,addr,wd,memwrite,readdata);
    memory mem(clk,memwrite,addr,wd,readdata);
endmodule