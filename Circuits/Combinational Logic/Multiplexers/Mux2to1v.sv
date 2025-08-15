module top_module(
    input logic [99:0] a,
    input logic [99:0] b,
    input logic sel,
    output logic [99:0] out
);

    assign out = ({100{sel}} & b) | ({100{~sel}} & a); // or out = sel ? b : a

endmodule