module top_module(
    input logic x3,
    input logic x2,
    input logic x1,
    output logic f
);

    assign f = (~x3 & x2 & ~x1) |
                (~x3 & x2 & x1) |
                (x3 & ~x2 & x1) |
                (x3 & x2 & x1);
    // assign f = (~x3 & x2) | (x3 & x1);
    // assign f = x3 ? x1 : x2;

endmodule