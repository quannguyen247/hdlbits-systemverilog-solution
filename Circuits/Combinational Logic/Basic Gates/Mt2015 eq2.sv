module top_module(
    input logic [1:0] A,
    input logic [1:0] B,
    output logic z
);

    assign z = (A == B);

endmodule