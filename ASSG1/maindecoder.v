module maindecoder(
    input clk,reset,
    input[3:0] op,
    output pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,
    output[1:0] alusrcb,pcsrc,aluop
);
    parameter FETCH=5'b00000;
    parameter DECODE=5'b00001;
    parameter MEMADR=5'b00010;
    parameter MEMRD=5'b00011;
    parameter MEMWB=5'b00100;
    parameter MEMWR=5'b00101;
    parameter EXECUTE=5'b00110;
    parameter ALUWB=5'b00111;
    parameter BRANCH=5'b01000;
    parameter ADDIEX=5'b01001;
    parameter ADDIWB=5'b01010;
    parameter JUMP=5'b01011;
    parameter JRW=5'b01100;

    parameter LW=4'b1010;
    parameter SW=4'b1001;
    parameter ADD=4'b0000;
    parameter NAND=4'b0010;
    parameter BEQ=4'b1011;
    parameter JAL=4'b1101;
    parameter ADDI=4'b1111;

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
                    JAL:ns<=JUMP;
                    ADDI:ns<=ADDIEX;
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
            ADDIEX:ns<=ADDIWB;
            ADDIWB:ns<=FETCH;
            BRANCH:ns<=FETCH;
            JUMP:ns<=JRW;
            JRW:ns<=FETCH;
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
            ADDIEX: control<=15'b0_0_0_0_1_0_0_0_0_10_00_00;
            ADDIWB: control<=15'b0_0_0_1_0_0_0_0_0_00_00_00;
            JUMP: control<=15'b0_0_0_0_0_0_0_0_0_01_10_00;
            JRW: control<=15'b1_0_0_1_0_0_0_0_0_00_00_00;
            default: control<=15'b0000xxxxxxxxxxx;
        endcase
    end
endmodule
