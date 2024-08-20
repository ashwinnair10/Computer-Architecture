module alu(
    input[31:0] a,b,
    input[2:0]aluc,
    output reg[31:0] op,
    output zero
);
    always @(*)begin
        case(aluc)
            3'b000:op<=a&b;
            3'b001:op<=a|b;
            3'b010:op<=a+b;
            3'b110:op<=a-b;
            3'b111:op<=a<b?1:0;
            default:op<=0;
        endcase
    end
    assign zero=(op==32'b0);
endmodule