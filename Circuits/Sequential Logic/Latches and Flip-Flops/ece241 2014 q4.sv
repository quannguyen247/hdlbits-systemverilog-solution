module top_module(
    input logic clk,
    input logic x,
    output logic z
);

    logic [2:0] q; // q[2] = DFF2 (top), q[1] = DFF1 (middle), q[0] = DFF0 (bottom)

    always_ff @(posedge clk) begin
        q[2] <= x ^ q[2];
        q[1] <= x & ~q[1];
        q[0] <= x | ~q[0];
    end

    assign z = ~|q;

endmodule