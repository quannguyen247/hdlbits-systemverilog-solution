module top_module(
    input logic clk,
    input logic reset,    // Active-high synchronous reset to 5'h1
    output logic [4:0] q
);

    always_ff @(posedge clk) begin
        if (reset)
            q <= 5'h1;
        else
            q <= {q[0], q[4], q[3] ^ q[0], q[2:1]};
    end

endmodule