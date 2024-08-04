module instrmemory(
    input[31:0] addr,
    output reg[31:0] instr
);
    reg [31:0]instruction[63:0];
    //declare instructions here
    always @(*)begin
        instr=instruction[addr[31:2]];
    end
endmodule