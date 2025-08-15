module top_module(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    assign out = (c | ~d | ~b) & (~c | d | ~a) & (~c | ~d | a | b) & (c | ~a | ~b);

endmodule