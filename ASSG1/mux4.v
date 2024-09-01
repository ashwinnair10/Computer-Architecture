module mux4 #(parameter WIDTH=8)(
    input[WIDTH-1:0] a,b,c,d,
    input[1:0] s,
    output reg[WIDTH-1:0] op
);
    always @(*)begin
        case(s)
            2'b00:op<=a;
            2'b01:op<=b;
            2'b10:op<=c;
            2'b11:op<=d;
        endcase
    end
endmodule