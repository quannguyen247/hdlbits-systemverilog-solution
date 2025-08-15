module top_module(
    input logic [6:1] y,
    input logic w,
    output logic Y2,
    output logic Y4
);

    assign Y2 = y[1] && ~w;
    assign Y4 = (y[2] | y[3] | y[5] | y[6]) & w;

endmodule