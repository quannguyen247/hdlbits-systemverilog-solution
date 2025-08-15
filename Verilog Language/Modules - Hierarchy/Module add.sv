module top_module(
    input logic [31:0] a,
    input logic [31:0] b,
    output logic [31:0] sum
);

    logic c1;

    add16 r1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum[15:0]),
        .cout(c1)
    );

    add16 r2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(c1),
        .sum(sum[31:16]),
        .cout()
    );

endmodule