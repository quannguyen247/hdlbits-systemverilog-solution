module top_module(
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