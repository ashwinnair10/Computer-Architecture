module control(
    input[5:0] opcode,
    output regdst,branch,memtoread,memtoreg,memwrite,alusrc,regwrite,
    output[1:0] aluop,
);
    reg[8:0] c={regdst,alusrc,memtoreg,regwrite,memtoread,memwrite,branch,aluop};
    always @(*)begin
        case(opcode)
            6'b000000:c<=8'b100100010;
            6'b100011:c<=8'b011110000;
            6'b101011:c<=8'bx1x001000;
            6'b000100:c<=8'bx0x000101;
        endcase
    end
endmodule