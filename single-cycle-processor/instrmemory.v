module instrmemory(
    input[31:0] addr,
    output reg[31:0] instr
);
    wire [31:0]instruction[31:0];
    assign instruction[0]='h20020014;
    assign instruction[1]='h2003001e;
    assign instruction[2]='h20050000;
    assign instruction[3]='h10a00001;
    assign instruction[4]='h00432820;
    assign instruction[5]='hac050014;
    assign instruction[6]='h00000000;
    assign instruction[7]='h00000000;
    assign instruction[8]='h00000000;
    assign instruction[9]='h00000000;
    assign instruction[10]='h00000000;
    assign instruction[11]='h00000000;
    assign instruction[12]='h00000000;
    assign instruction[13]='h00000000;
    assign instruction[14]='h00000000;
    assign instruction[15]='h00000000;
    assign instruction[16]='h00000000;
    assign instruction[17]='h00000000;
    assign instruction[18]='h00000000;
    assign instruction[19]='h00000000;
    assign instruction[20]='h00000000;
    assign instruction[21]='h00000000;
    assign instruction[22]='h00000000;
    assign instruction[23]='h00000000;
    assign instruction[24]='h00000000;
    assign instruction[25]='h00000000;
    assign instruction[26]='h00000000;
    assign instruction[27]='h00000000;
    assign instruction[28]='h00000000;
    assign instruction[29]='h00000000;
    assign instruction[30]='h00000000;
    assign instruction[31]='h00000000;

    always @(*)begin
        instr=instruction[addr[31:2]];
    end
endmodule