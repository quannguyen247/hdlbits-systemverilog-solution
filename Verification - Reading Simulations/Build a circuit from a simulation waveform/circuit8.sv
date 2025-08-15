module top_module(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    always_latch
        if (clock)
            p <= a;

    always_ff @(negedge clock)
        q <= p;

endmodule