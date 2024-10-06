module datamemory(
    input we,
    input[15:0] a,wd,
    output reg[15:0] op
);
    reg[15:0] data[63:0];
    integer i;
    initial begin
        for(i=0;i<64;i=i+1)begin
            data[i]=16'b0;
        end
    end
    assign op=data[a[15:1]];
    always @(*)begin
        if(we)
            data[a[15:1]]<=wd;
    end
endmodule
    