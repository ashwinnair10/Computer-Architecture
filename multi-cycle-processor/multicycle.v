module multicycle(
    input clk,reset,
    output[31:0] addr,writedata,
    output memwrite,
    input[31:0] readdata
);
    wire zero,pcen,irwrite,regwrite,alusrca,iord,memtoreg,regdst;
    wire[1:0] alusrcb,pcsrc;
    wire[2:0] alucontrol;
    wire[5:0] op,funct;
    controlunit c(clk,reset,op,funct,zero,pcen,memwrite,irwrite,regwrite,alusrca,iord,memtoreg,regdst,alusrcb,pcsrc,alucontrol);
    datapath dp(clk,reset,pcen,irwrite,regwrite,alusrca,iord,memtoreg,regdst,alusrcb,pcsrc,alucontrol,op,funct,zero,addr,writedata,readdata);
endmodule