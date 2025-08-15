module top_module(
    input logic a,
    input logic b,
    output logic cout,
    output logic sum
);

    assign cout = a & b;
    assign sum = a ^ b;
    // assign {cout, sum} = a + b;

endmodule