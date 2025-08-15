module top_module(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic sub,
    output logic [31:0] sum
);

    logic c1;
    logic [31:0] b_xor = b ^ {32{sub}};

    add16 r1(
        .a(a[15:0]),
        .b(b_xor[15:0]),
        .cin(sub),
        .sum(sum[15:0]),
        .cout(c1)
    );

    add16 r2(
        .a(a[31:16]),
        .b(b_xor[31:16]),
        .cin(c1),
        .sum(sum[31:16]),
        .cout()
    );

endmodule