module regfile(
    input[4:0] r1,r2,wreg,
    output[31:0] reg1,reg2,
    input[31:0] wd,
    input regdst,regwrite
);
    integer i;
    reg [31:0] ram[63:0];
    for(i=0;i<64;i=i+1)begin
        ram[i]=32'b0;
    end
    always @(*)begin
        if(regwrite==1)begin
            if(regdst==1)
                ram[wreg]<=wd;
            else
                ram[r2]<=wd;
        end
        else begin
            reg1<=ram[r1];
            reg2<=ram[r2];
        end
    end
endmodule
            
