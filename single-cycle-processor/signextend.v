module signextend(
    input[15:0] ip,
    output[31:0] op
);
    reg[15:0] ans;
    always @(*)begin
        if(ip[15]==1'b0)
            ans<=16'b0;
        else
            ans<=16'b1111111111111111;
        op<={ans,ip};
    end
endmodule