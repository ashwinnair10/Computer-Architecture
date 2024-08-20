module tb();
    reg clk;
    reg reset;
    wire [31:0] writedata, dataadr;
    wire memwrite;
    reg [31:0] cycle;
    top dut(clk, reset, writedata, dataadr, memwrite);
    initial begin
        reset <= 1; # 12; reset <= 0;
        cycle <= 1;
    end
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
    end
    always begin
        clk <= 1; # 5; clk <= 0; # 5;
        cycle <= cycle + 1;
    end
    always@(negedge clk)begin
        if (memwrite) begin
            if (dataadr === 84 & writedata == 7) begin
                $display("Success");
                $stop;
            end
            else if (dataadr !== 80) begin
                $display("Critical Failure");
                $stop;
            end
        end
    end
endmodule