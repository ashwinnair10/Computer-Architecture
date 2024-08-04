module regfile(
    input[4:0] r1,r2,wreg,
    output reg[31:0] reg1,reg2,
    input[31:0] wd,
    input regdst,regwrite
);
    reg [31:0] ram[63:0];
    always @(*)begin
        if(regwrite==1)begin
            if(regdst==1)
                ram[wreg]=wd;
            else
                ram[r2]=wd;
        end
        else begin
            reg1=ram[r1];
            reg2=ram[r2];
        end
    end
endmodule
            
