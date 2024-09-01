module maindecoder(
    input clk,reset,
    input[3:0] op,
    output pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,
    output[1:0] alusrcb,pcsrc,aluop
);
    parameter FETCH=0;
    parameter DECODE=1;
    parameter MEMADR=2;
    parameter MEMRD=3;
    parameter MEMWB=4;
    parameter MEMWR=5;
    parameter EXECUTE=6;
    parameter ALUWB=7;
    parameter BRANCH=8;

    parameter LW=4'b1010;
    parameter SW=4'b1001;
    parameter ADD=4'b0000;
    parameter NAND=4'b0010;
    parameter BEQ=4'b1011;
    parameter JAL=4'b1101;

    reg[31:0] s,ns;
    reg[14:0] control;

    always @(posedge clk or posedge reset)begin
        if(reset)
            s<=FETCH;
        else
            s<=ns;
    end

    always @(*)begin
        case(s)
            FETCH:ns<=DECODE;
            DECODE:
                case(op)
                    LW:ns<=MEMADR;
                    SW:ns<=MEMADR;
                    ADD:ns<=EXECUTE;
                    NAND:ns<=EXECUTE;
                    BEQ:ns<=BRANCH;
                    JAL:ns<=EXECUTE;
                    default:ns<=FETCH;
                endcase
            MEMADR:
                case(op)
                    LW:ns<=MEMRD;
                    SW:ns<=MEMWR;
                    default:ns<=FETCH;
                endcase
            MEMRD:ns<=MEMWB;
            MEMWB:ns<=FETCH;
            MEMWR:ns<=FETCH;
            EXECUTE:ns<=ALUWB;
            BRANCH:ns<=FETCH;
            default:ns<=FETCH;
        endcase
    end
    assign {pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop}=control;
    always @(*)begin
        case(s)
            FETCH: control<=15'b1_0_1_0_0_0_0_0_0_01_00_00;
            DECODE: control<=15'b0_0_0_0_0_0_0_0_0_11_00_00;
            MEMADR: control<=15'b0_0_0_0_1_0_0_0_0_10_00_00;
            MEMRD: control<=15'b0_0_0_0_0_0_1_0_0_00_00_00;
            MEMWR: control<=15'b0_1_0_0_0_0_1_0_0_00_00_00;
            MEMWB: control<=15'b0_0_0_1_0_0_0_1_0_00_00_00;
            EXECUTE: control<=15'b0_0_0_0_1_0_0_0_0_00_00_10;
            ALUWB: control<=15'b0_0_0_1_0_0_0_0_1_00_00_00;
            BRANCH: control<=15'b0_0_0_0_1_0_0_0_0_00_01_01;
            default: control<=15'b0000xxxxxxxxxxx;
        endcase
    end
endmodule
