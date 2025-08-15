module top_module(
    input logic sel,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out
);

    assign out = sel ? a : b;

endmodule