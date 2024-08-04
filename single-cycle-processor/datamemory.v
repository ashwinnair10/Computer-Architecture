module datamemory(
    input memwrite,memread,
    input[31:0] address,wdata,
    output[31:0] op
);
    reg [31:0]data[63:0];
    //declare data here
    always @(*)begin
        if(memwrite==1'b1)
            data[address[31:2]]<=wdata;
        if(memread==1'b1)
            op<=data[address[31:2]];
    end
endmodule