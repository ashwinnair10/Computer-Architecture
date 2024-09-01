module datapath(
    input clk,reset,pcen,irwrite,regwrite,alusrca,iord,memtoreg,regdst,
    input[1:0] alusrcb,pcsrc,
    input[2:0] alucontrol,
    output[3:0] op,
    output zero,carry,
    output[15:0] addr,writedata,
    input[15:0] readdata
);
    wire[2:0] writereg;
    wire[2:0] returnreg;
    wire[15:0] pcnext,pc,instr,data,srca,srcb,a,aluresult,aluout,signimm,signimmsh,wd,rd1,rd2;
    assign op=instr[15:12];

    ffenabled #(16) pcreg(clk,reset,pcen,pcnext,pc);
    mux2 #(16) addrmux(pc,aluout,iord,addr);
    ffenabled #(16) instrreg(clk,reset,irwrite,readdata,instr);
    ff #(16) datareg(clk,reset,readdata,data);

    mux2 #(3) regdstmux(instr[8:6],instr[5:3],regdst,writereg);
    mux2 #(16) wdmux(aluout,data,memtoreg,wd);

    wire regen=regwrite&(~(carry^instr[1])|~(zero^instr[0]));

    register rf(clk,regen,instr[11:9],instr[8:6],writereg,wd,rd1,rd2);

    signext se(instr[5:0],signimm);

    sl immsh(signimm,signimmsh);

    ff #(16) areg(clk,reset,rd1,a);
    ff #(16) breg(clk,reset,rd2,writedata);

    mux2 #(16) srcamux(pc,a,alusrca,srca);
    mux4 #(16) srcbmux(writedata,16'b10,signimm,signimmsh,alusrcb,srcb);

    alu alu(srca,srcb,alucontrol,aluresult,zero,carry);

    ff #(16) alureg(clk,reset,aluresult,aluout);

    mux3 #(16) pcmux(aluresult,aluout,16'bx,pcsrc,pcnext);

    
    assign returnreg=(op==4'b1101)?instr[11:9]:3'bxxx;
    register rv(clk,1'b1,3'bxxx,3'bxxx,returnreg,pc+2'b10,rd1,rd2);
    
endmodule