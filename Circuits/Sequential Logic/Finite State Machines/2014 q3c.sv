module top_module(
    input logic clk, // this clock input is for fun to sync with testbench
    input logic [2:0] y,
    input logic x,
    output logic Y0,
    output logic z
);

    assign Y0 = (~y[2] & y[0] & ~x) | (~y[2] & ~y[0] & x) | (y[2] & ~y[1] & ~y[0] & ~x);
    assign z = (y == 3'b011) || (y == 3'b100);

endmodule