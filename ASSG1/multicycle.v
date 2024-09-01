module multicycle(
    input clk,reset,
    output[15:0] addr,writedata,
    output memwrite,
    input[15:0] readdata
);
    wire zero,carry,pcen,irwrite,regwrite,alusrca,iord,memtoreg,regdst;
    wire[1:0] alusrcb,pcsrc;
    wire[2:0] alucontrol;
    wire[3:0] op;
    controlunit c(clk,reset,op,zero,carry,pcen,memwrite,irwrite,regwrite,alusrca,iord,memtoreg,regdst,alusrcb,pcsrc,alucontrol);
    datapath dp(clk,reset,pcen,irwrite,regwrite,alusrca,iord,memtoreg,regdst,alusrcb,pcsrc,alucontrol,op,zero,carry,addr,writedata,readdata);
endmodule