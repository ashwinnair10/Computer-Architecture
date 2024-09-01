module aludecoder(
    input[3:0] op,
    input[1:0] aluop,
    output reg[2:0] alucontrol
);
    always @(*)begin
        case(aluop)
            2'b00:alucontrol<=3'b010;
            2'b10:
                case(op)
                    4'b0000:alucontrol<=3'b010;
                    4'b0010:alucontrol<=3'b110;
                    default:alucontrol<=3'bxxx;
                endcase
            default:alucontrol<=3'bxxx;
        endcase
    end
endmodule