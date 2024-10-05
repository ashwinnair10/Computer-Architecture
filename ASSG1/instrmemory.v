module instrmemory(
    input[15:0] addr,
    output reg[15:0] instruction
);
    reg[15:0] instr[31:0];
    initial begin
        instr[0]  <= 16'hF010; // ADDI R1, R0, 10
        instr[1]  <= 16'hF020; // ADDI R2, R0, 20
        instr[2]  <= 16'hF030; // ADDI R3, R0, 30
        instr[3]  <= 16'hF040; // ADDI R4, R0, 40
        instr[4]  <= 16'hF050; // ADDI R5, R0, 50
        instr[5]  <= 16'h0A2A; // ADD R2, R1, R3
        instr[6]  <= 16'h0A4D; // ADC R2, R1, R4
        instr[7]  <= 16'h2B7C; // NDU R3, R5, R6
        instr[8]  <= 16'h24D4; // NDZ R4, R2, R5
        instr[9]  <= 16'hA2A0; // LW R1, R2, 16
        instr[11] <= 16'h92A0; // SW R2, R1, 8
        instr[12] <= 16'h9C34; // SW R3, R6, 12
        instr[13] <= 16'hB2A4; // BEQ R1, R2, 4
        instr[14] <= 16'hB6F8; // BEQ R3, R4, -8
        instr[15] <= 16'hF020; // ADDI R2, R0, 20
        instr[16] <= 16'h92A0; // SW R2, R1, 8
    end
    always @(*)begin
        instruction=instr[addr[15:1]];
    end
endmodule