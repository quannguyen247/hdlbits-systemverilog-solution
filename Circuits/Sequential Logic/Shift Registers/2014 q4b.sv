module top_module(
    input logic [3:0] SW,
    input logic [3:0] KEY,
    output logic [3:0] LEDR
);

    // You can use generate block to instantiate multiple MUXDFF modules too :D
    MUXDFF d0( .R(SW[0]), .clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[1]), .Q(LEDR[0]) );
    MUXDFF d1( .R(SW[1]), .clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[2]), .Q(LEDR[1]) );
    MUXDFF d2( .R(SW[2]), .clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[3]), .Q(LEDR[2]) );
    MUXDFF d3( .R(SW[3]), .clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(KEY[3]), .Q(LEDR[3]) );

endmodule

module MUXDFF(
    input logic clk,
    input logic w, R, E, L,
    output logic Q
);

    always_ff @(posedge clk) begin
        Q <= (~L & ((~E & Q) | (E & w))) | (L & R);
    end

endmodule