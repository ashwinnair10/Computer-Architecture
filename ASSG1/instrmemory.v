module instrmemory(
    input[15:0] addr,
    output reg[15:0] instruction
);
    reg[15:0] instr[31:0];
    initial begin
        instr[0]  <= 16'hF24A; // ADDI R1, R1, 10
        instr[1]  <= 16'hF494; // ADDI R2, R2, 20
        instr[2]  <= 16'hF6DE; // ADDI R3, R3, 30
        instr[3]  <= 16'hF928; // ADDI R4, R4, 40
        instr[4]  <= 16'hFB72; // ADDI R5, R5, 50
        instr[5]  <= 16'h02D0; // ADD R2, R1, R3
        instr[6]  <= 16'h0312; // ADC R2, R1, R4
        instr[7]  <= 16'h2B98; // NDU R3, R5, R6
        instr[8]  <= 16'h2561; // NDZ R4, R2, R5
        instr[9]  <= 16'hA450; // LW R1, R2, 16
        instr[10] <= 16'h9288; // SW R2, R1, 8
        instr[11] <= 16'h9CCC; // SW R3, R6, 12
        instr[12] <= 16'hB284; // BEQ R1, R2, 4
        instr[13] <= 16'hB738; // BEQ R3, R4, -8
        instr[14] <= 16'h04D0; // ADD R2, R2, R3
        instr[15] <= 16'hD010; // JAL R1, 16
        instr[16] <= 16'hFB72; // ADDI R5, R5, 50
        instr[17] <= 16'h9288; // SW R2, R1, 8
        instr[18] <= 16'hF6DE; // ADDI R3, R3, 30
    end
    always @(*)begin
        instruction=instr[addr[15:1]];
    end
endmodule