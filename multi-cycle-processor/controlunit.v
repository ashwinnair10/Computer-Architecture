module controlunit(
    input clk,reset,
    input[5:0] op,funct,
    input zero,
    output pcen,memwrite,irwrite,regwrite,
    output alusrca,iord,memtoreg,regdst,
    output[1:0] alusrcb,pcsrc,
    output[2:0] alucontrol
);
    wire[1:0] aluop;
    wire branch,pcwrite;
    maindecoder md(clk,reset,op,pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop);
    aludecoder ad(funct,aluop,alucontrol);

    assign pcen=pcwrite|(branch&zero);
endmodule