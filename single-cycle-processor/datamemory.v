module datamemory(
    input memwrite,memread,
    input[31:0] address,wdata,
    output reg[31:0] op
);
    reg [31:0]data[31:0];
    initial begin
        data[0]='hxxxxxxxxxxxxxxxx;
        data[1]='hxxxxxxxxxxxxxxxx;
        data[2]='hxxxxxxxxxxxxxxxx;
        data[3]='hxxxxxxxxxxxxxxxx;
        data[4]='hxxxxxxxxxxxxxxxx;
        data[5]='hxxxxxxxxxxxxxxxx;
        data[6]='hxxxxxxxxxxxxxxxx;
        data[7]='hxxxxxxxxxxxxxxxx;
        data[8]='hxxxxxxxxxxxxxxxx;
        data[9]='hxxxxxxxxxxxxxxxx;
        data[10]='hxxxxxxxxxxxxxxxx;
        data[11]='hxxxxxxxxxxxxxxxx;
        data[12]='hxxxxxxxxxxxxxxxx;
        data[13]='hxxxxxxxxxxxxxxxx;
        data[14]='hxxxxxxxxxxxxxxxx;
        data[15]='hxxxxxxxxxxxxxxxx;
        data[16]='hxxxxxxxxxxxxxxxx;
        data[17]='hxxxxxxxxxxxxxxxx;
        data[18]='hxxxxxxxxxxxxxxxx;
        data[19]='hxxxxxxxxxxxxxxxx;
        data[20]='hxxxxxxxxxxxxxxxx;
        data[21]='hxxxxxxxxxxxxxxxx;
        data[22]='hxxxxxxxxxxxxxxxx;
        data[23]='hxxxxxxxxxxxxxxxx;
        data[24]='hxxxxxxxxxxxxxxxx;
        data[25]='hxxxxxxxxxxxxxxxx;
        data[26]='hxxxxxxxxxxxxxxxx;
        data[27]='hxxxxxxxxxxxxxxxx;
        data[28]='hxxxxxxxxxxxxxxxx;
        data[29]='hxxxxxxxxxxxxxxxx;
        data[30]='hxxxxxxxxxxxxxxxx;
        data[31]='hxxxxxxxxxxxxxxxx;
    end
    always @(*)begin
        if(memwrite==1'b1)
            data[address[31:2]]=wdata;
        if(memread==1'b1)
            op=data[address[31:2]];
    end
endmodule