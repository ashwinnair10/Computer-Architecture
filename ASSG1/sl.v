module sl(
    input[15:0] a,
    output[15:0] b
);
    assign b={a[14:0],1'b0};
endmodule