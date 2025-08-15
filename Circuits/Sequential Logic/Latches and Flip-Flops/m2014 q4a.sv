module top_module(
    input logic d,
    input logic ena,
    output logic q
);

    always_latch
        if (ena)
            q <= d;

endmodule