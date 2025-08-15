module top_module(
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    assign q = a ^ b ^ state;

    always_ff @(posedge clk)
        state <= state ? (a | b) : (a & b);

endmodule