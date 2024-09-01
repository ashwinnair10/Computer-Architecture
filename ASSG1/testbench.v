module testbench();
    reg clk;
    reg reset;
    wire[15:0] writedata,dataadr;
    wire memwrite;
    reg[15:0] cycle;
    topmodule tb(clk,reset,writedata,dataadr,memwrite);
    initial begin
        reset<=1; #12 reset<=0;
        cycle<=1;
    end
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0,tb);
    end
    always begin
        clk<=1; #5; clk<=0; #5;
        cycle<=cycle+1;
        $display("cycle %d",cycle);
    end
    always @(negedge clk) begin
        if (cycle==60)begin
            $display("Code ran successfully");
            $finish;
        end
    end
endmodule