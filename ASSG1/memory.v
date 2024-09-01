module memory(
    input clk,we,
    input[15:0] a,wd,
    output[15:0] rd
);
    reg[15:0] RAM[63:0];
    initial begin
        RAM[0]<=16'h0A3C; // ADD R2, R1, R3
        RAM[1]<=16'h0A4D; // ADC R2, R1, R4
        RAM[2]<=16'h2B7C; // NDU R3, R5, R6
        RAM[3]<=16'h24D4; // NDZ R4, R2, R5
        RAM[4]<=16'hA2A0; // LW R1, R2, 16
        RAM[5]<=16'hA5C0; // LW R5, R4, 32
        RAM[6]<=16'h92A0; // SW R2, R1, 8
        RAM[7]<=16'h9C34; // SW R3, R6, 12
        RAM[8]<=16'hB2A4; // BEQ R1, R2, 4
        RAM[9]<=16'hB6F8; // BEQ R3, R4, -8
        RAM[10]<=16'h0D7C; // ADD R7, R6, R5
        RAM[11]<=16'h03F8; // ADC R6, R3, R7
        RAM[12]<=16'h20FC; // NDU R7, R0, R1
        RAM[13]<=16'h2E6C; // NDZ R5, R7, R3
    end
    assign rd=RAM[a[15:1]];
    always @(posedge clk)begin
        if(we)
            RAM[a[15:1]]<=wd;
    end
endmodule