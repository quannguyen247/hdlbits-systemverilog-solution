module top_module(
    input logic clk,
    input logic w, R, E, L,
    output logic Q
);

    always_ff @(posedge clk) begin
        Q <= (~L & ((~E & Q) | (E & w))) | (L & R);
    end

endmodule