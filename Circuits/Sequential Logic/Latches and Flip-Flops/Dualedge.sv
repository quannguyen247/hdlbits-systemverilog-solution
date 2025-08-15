module top_module(
    input logic clk,
    input logic d,
    output logic q
);

    logic q_pos, q_neg;

    always_ff @(posedge clk)
        q_pos <= d;

    always_ff @(negedge clk)
        q_neg <= d;

    assign q = clk ? q_pos : q_neg;

endmodule