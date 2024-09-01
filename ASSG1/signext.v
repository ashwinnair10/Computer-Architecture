module signext(
    input[5:0] a,
    output[15:0] b
);
    assign b={{10{a[5]}},a};
endmodule