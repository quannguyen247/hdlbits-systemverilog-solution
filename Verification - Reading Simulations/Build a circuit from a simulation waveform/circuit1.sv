module top_module(
    input logic a,
    input logic b,
    output logic q
);

    assign q = a & b;

endmodule