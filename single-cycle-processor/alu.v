module alu(
    input[31:0] a,b,r,
    input[1:0] alucontrol,
    input alusrc,
    output reg[31:0] c,
    output reg zero
);
    always @(*)begin
        if(alusrc==0)begin
            case(alucontrol)
                2'b00:c=a-b;
                2'b01:c=a+b;
                2'b10:begin
                    c=32'bx;
                    if(a==b)
                        zero=1'b1;
                    else
                        zero=1'b0;
                end
            endcase
        end
        else begin
            case(alucontrol)
                2'b00:c=a-r;
                2'b01:c=a+r;
                2'b10:begin
                    c=32'bx;
                    if(a==r)
                        zero=1'b1;
                    else
                        zero=1'b0;
                end
            endcase
        end
    end
endmodule