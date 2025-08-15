module top_module(
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    assign Y1 = y[0] && w;
    assign Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w;

endmodule