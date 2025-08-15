module top_module(
    input logic [3:0] x,
    input logic [3:0] y, 
    output logic [4:0] sum
);

    assign sum = x + y;

endmodule