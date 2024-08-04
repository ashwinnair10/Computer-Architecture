module control(
    input[5:0] opcode,
    output regdst,branch,memtoread,memreg,memwrite,alusrc,regwrite,
    output[1:0] aluop
);
    reg[8:0] c;
    assign {regdst,alusrc,memreg,regwrite,memtoread,memwrite,branch,aluop}=c;
    always @(*)begin
        case(opcode)
            6'b000000:c<=9'b100100010;
            6'b100011:c<=9'b011110000;
            6'b101011:c<=9'bx1x001000;
            6'b000100:c<=9'bx0x000101;
        endcase
    end
endmodule