module top_module(
    input logic x,
    input logic y,
    output logic z
);

    logic z1, z2, z3, z4;

    A IA1 ( .x(x), .y(y), .z(z1) );
    B IB1 ( .x(x), .y(y), .z(z2) );
    A IA2 ( .x(x), .y(y), .z(z3) );
    B IB2 ( .x(x), .y(y), .z(z4) );

    assign z = (z1 | z2) ^ (z3 & z4);

endmodule

module A(
    input logic x,
    input logic y,
    output logic z
);

    assign z = (x ^ y) & x;

endmodule

module B(
    input logic x,
    input logic y,
    output logic z
);

    assign z = ~x ^ y;

endmodule