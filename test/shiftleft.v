module shiftleft(
    input[31:0] ip,
    output[31:0] op
);
    always @(*)begin
        op=ip<<2;
    end
endmodule