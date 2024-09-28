module memory(
    input clk,we,
    input[15:0] a,wd,
    output[15:0] rd
);
    reg[15:0] RAM[127:0];
    initial begin

        RAM[0]  <= 16'hF010; // ADDI R1, R0, 10
        RAM[1]  <= 16'hF020; // ADDI R2, R0, 20
        RAM[2]  <= 16'hF030; // ADDI R3, R0, 30
        RAM[3]  <= 16'hF040; // ADDI R4, R0, 40
        RAM[4]  <= 16'hF050; // ADDI R5, R0, 50
        RAM[5]  <= 16'h0A2A; // ADD R2, R1, R3
        RAM[6]  <= 16'h0A4D; // ADC R2, R1, R4
        RAM[7]  <= 16'h2B7C; // NDU R3, R5, R6
        RAM[8]  <= 16'h24D4; // NDZ R4, R2, R5
        RAM[9]  <= 16'hA2A0; // LW R1, R2, 16
        RAM[11] <= 16'h92A0; // SW R2, R1, 8
        RAM[12] <= 16'h9C34; // SW R3, R6, 12
        RAM[13] <= 16'hB2A4; // BEQ R1, R2, 4
        RAM[14] <= 16'hB6F8; // BEQ R3, R4, -8
        RAM[15] <= 16'hF020; // ADDI R2, R0, 20
        RAM[16] <= 16'h92A0; // SW R2, R1, 8

        RAM[66] <= 16'h0DEF;
    end
    assign rd=RAM[a[15:1]];
    always @(posedge clk)begin
        if(we)
            RAM[a[15:1]]<=wd;
    end
endmodule