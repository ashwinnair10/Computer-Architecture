module topmodule(
    input clk,reset
);
    wire[15:0] readdata,wd,addr,instruction;
    wire memwrite;
    multicycle mc(clk,reset,addr,wd,memwrite,readdata,instruction);
    instrmemory imem(addr,instruction);
    datamemory dmem(memwrite,addr,wd,readdata);
endmodule