module datamemory(
    input we,
    input[15:0] a,wd,
    output reg[15:0] op
);
    reg[15:0] data[15:0];
    initial begin
        data[0]<=16'b0;
        data[1]<=16'b0;
        data[2]<=16'b0;
        data[3]<=16'b0;
        data[4]<=16'b0;
        data[5]<=16'b0;
        data[6]<=16'b0;
        data[7]<=16'b0;
        data[8]<=16'b0;
        data[9]<=16'b0;
        data[10]<=16'b0;
        data[11]<=16'b0;
        data[12]<=16'b0;
        data[13]<=16'b0;
        data[14]<=16'b0;
        data[15]<=16'b0;
    end
    assign op=data[a[15:1]];
    always @(*)begin
        if(we)
            data[a[15:1]]<=wd;
    end
endmodule
    