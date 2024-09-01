module mux2 #(parameter WIDTH=8)(
    input[WIDTH-1:0] a,b,
    input s,
    output[WIDTH-1:0] op
);
    assign op=s?b:a;
endmodule