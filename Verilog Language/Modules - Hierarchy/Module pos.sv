module top_module(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out1,
    output logic out2
);

    mod_a m1( out1, out2, a, b, c, d );

endmodule