module top_module(
    input logic x,
    input logic y,
    output logic z
);

    assign z = ~x ^ y; // or ~(x ^ y) (XNOR)

endmodule