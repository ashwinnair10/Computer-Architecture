module testbench();
    reg clk;
    reg reset;
    reg[15:0] cycle;
    topmodule tb(clk,reset);
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
        $display("cycle number:%d",cycle);
    end
    always @(negedge clk) begin
        if (cycle==60)begin
            $display("Code run success");
            $finish;
        end
    end
endmodule