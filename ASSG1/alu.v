module alu(
    input[15:0] a,b,
    input[2:0] alucontrol,
    output reg[15:0] op,
    output zero,carry
);
    reg c;
    always @(*)begin
        case(alucontrol)
            3'b010:{c,op}<=a+b;
            3'b110:op<=~(a&b);
            default:op<=16'bxxxxxxxxxxxxxxxx;
        endcase
    end
    assign zero=(a==b);
    assign carry=(c==1'b1);
endmodule