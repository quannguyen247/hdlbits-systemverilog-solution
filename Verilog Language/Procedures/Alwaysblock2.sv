module top_module(
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    assign out_assign = a ^ b;

    always_comb
        out_always_comb = a ^ b;

    always_ff @(posedge clk)
        out_always_ff = a ^ b;

endmodule