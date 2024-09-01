module mux3 #(parameter WIDTH=8)(
    input[WIDTH-1:0] a,b,c,
    input[1:0] s,
    output[WIDTH-1:0] op
);
    assign #1 op=s[1]?c:(s[0]?b:a);
endmodule