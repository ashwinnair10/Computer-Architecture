module register(
    input clk,we,
    input[2:0] ra1,ra2,wa,
    input[15:0] wd,
    output[15:0] rd1,rd2,
    input ret,
    input[15:0] pc
);
    reg[15:0] rf[7:0];
    initial begin
        rf[0]=16'h0000;
        rf[1]=16'h0000;
        rf[2]=16'h0000;
        rf[3]=16'h0000;
        rf[4]=16'h0000;
        rf[5]=16'h0000;
        rf[6]=16'h0000;
        rf[7]=16'h0000;
    end
    always @(posedge clk)begin
        if(we)
            rf[wa]<=wd;
        if(ret)
            rf[ra1]<=wd;
        rf[0]<=pc;
    end
    assign rd1=(ra1!=0)?rf[ra1]:0;
    assign rd2=(ra2!=0)?rf[ra2]:0;
endmodule