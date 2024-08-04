module main(
    input clk,reset
);
    reg[31:0] pci=32'b0;
    wire[31:0] instr;
    
    //initializing pc and instruction
    instrmemory obj1(pci,instr);
    
    wire regdst,branch,memtoread,memtoreg,memwrite,alusrc,regwrite;
    wire[1:0] aluop,aluctrl;
    
    //determining control signals and alu controls
    control obj2(instr[31:26],regdst,branch,memtoread,memtoreg,memwrite,alusrc,regwrite,aluop);
    alucontrol call(aluop,instr[5:0],aluctrl);

    wire[31:0] r1,r2;
    wire[31:0] wd;

    //register handling
    regfile obj3(instr[25:21],instr[20:16],instr[15:11],r1,r2,wd,regdst,regwrite);
    
    wire[31:0] offset;
    
    //sign extension
    signextend obj4(instr[15:0],offset);

    wire[31:0] aluoutput;
    wire zero;

    //alu logic
    alu obj5(r1,r2,offset,aluctrl,alusrc,aluoutput,zero);

    wire[31:0] dataout;

    //data handling
    datamemory obj6(memwrite,memtoread,aluoutput,r2,dataout);

    if(memtoreg==1'b1)
        assign wd=dataout;
    else
        assign wd=aluoutput;
    
    wire[31:0] sl;
    shiftleft shl(offset,sl);
    
    //pc handling
    always @(posedge clk)begin
        pci=pci+1;
        if(branch&zero)
            pci=pci+sl;
    end
endmodule




    
