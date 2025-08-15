module top_module(
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

    assign cout = (a & b) | (b & cin) | (a & cin);
    assign sum = a ^ b ^ cin;
    // assign {cout, sum} = a + b + cin;

endmodule