module top_module( 
    input logic [99:0] a, b,
    input logic cin,
    output logic [99:0] cout,
    output logic [99:0] sum
);

    logic [100:0] carry;
    assign carry[0] = cin; 

    genvar i;
    generate
        for (i = 0; i < 100; i++) begin : gen_fa
            full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[100:1];

endmodule

module full_adder(
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);

    assign {cout, sum} = a + b + cin;

endmodule