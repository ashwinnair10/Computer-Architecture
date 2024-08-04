module alucontrol(
    input[1:0] aluop,
    input[5:0] funct,
    output reg[1:0] op
);
    //op=1 for add
    //op=0 for subtract
    always @(*)begin
        case(aluop)
            2'b00:op=2'b01;
            2'b01:begin
                case(funct)
                    6'b100000:op=2'b01;
                    6'b100010:op=2'b00;
                endcase
            end
            2'b10:op=2'b10;
        endcase
    end
endmodule