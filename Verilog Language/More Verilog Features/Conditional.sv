module top_module(
    input logic [7:0] a, b, c, d,
    output logic [7:0] min
);

    logic [7:0] min1, min2;

    assign min1 = (a < b) ? a : b; 
    assign min2 = (c < d) ? c : d;
    assign min = (min1 < min2) ? min1 : min2;

endmodule