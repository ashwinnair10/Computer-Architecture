module controlunit(
    input clk,reset,
    input[3:0] op,
    input zero,carry,
    output pcen,memwrite,irwrite,regwrite,alusrca,iord,memtoreg,regdst,
    output[1:0] alusrcb,pcsrc,
    output[2:0] alucontrol
);
    wire[1:0] aluop;
    wire branch,pcwrite;
    maindecoder md(clk,reset,op,pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop);
    aludecoder ad(op,aluop,alucontrol);
    assign pcen=pcwrite|(branch&zero);
endmodule