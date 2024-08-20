module datapath(
    input clk,reset,pcen,irwrite,regwrite,alusrca,iord,memtoreg,regdst,
    input[1:0] alusrcb,pcsrc,
    input[2:0] alucontrol,
    output[5:0] op,funct,
    output zero,
    output[31:0] addr,writedata,
    input[31:0] readdata
);
    wire[4:0] writereg;
    wire[31:0] pcnext,pc,instr,data,srca,srcb,a,aluresult,aluout,signimm,signimmsh,wd3,rd1,rd2;
    assign op=instr[31:26];
    assign funct=instr[5:0];

    ffenabled #(32) pcreg(clk,reset,pcen,pcnext,pc);
    mux2 #(32) addrmux(pc,aluout,iord,addr);
    ffenabled #(32) instrreg(clk,reset,irwrite,readdata,instr);
    ff #(32) datareg(clk,reset,readdata,data);

    mux2 #(5) regdstmux(instr[20:16],instr[15:11],regdst,writereg);
    mux2 #(32) wdmux(aluout,data,memtoreg,wd3);
    register rf(clk,regwrite,instr[25:21],instr[20:16],writereg,wd3,rd1,rd2);
    signext se(instr[15:0],signimm);
    sl immsh(signimm,signimmsh);
    ff #(32) areg(clk,reset,rd1,a);
    ff #(32) breg(clk,reset,rd2,writedata);
    mux2 #(32) srcamux(pc,a,alusrca,srca);
    mux4 #(32) srcbmux(writedata,32'b100,signimm,signimmsh,alusrcb,srcb);
    alu alu(srca,srcb,alucontrol,aluresult,zero);
    ff #(32) alureg(clk,reset,aluresult,aluout);
    mux3 #(32) pcmux(aluresult,aluout,{pc[31:28],instr[25:0],2'b00},pcsrc,pcnext);
    
endmodule