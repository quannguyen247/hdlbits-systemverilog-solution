module top_module (
    input logic [2:0] SW,      // R
    input logic [1:0] KEY,     // L and clk
    output logic [2:0] LEDR    // Q
);

    dff_mux d0( .clk(KEY[0]), .L(KEY[1]), .r_in(SW[0]), .q_in(LEDR[2]), .Q(LEDR[0]) );
    dff_mux d1( .clk(KEY[0]), .L(KEY[1]), .r_in(SW[1]), .q_in(LEDR[0]), .Q(LEDR[1]) );
    dff_mux d2( .clk(KEY[0]), .L(KEY[1]), .r_in(SW[2]), .q_in(LEDR[1] ^ LEDR[2]), .Q(LEDR[2]) );

endmodule

module dff_mux (
    input logic clk,
    input logic L,      // Selection pin
    input logic r_in,   // Mux = 1
    input logic q_in,   // Mux = 0
    output logic Q
);

    always_ff @(posedge clk) begin
        Q <= (L & r_in) | (~L & q_in);
    end

endmodule