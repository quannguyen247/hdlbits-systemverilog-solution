module top_module(
    input logic [15:0] a, b,
    input logic cin,
    output logic cout,
    output logic [15:0] sum
);

    logic [4:0] carry;       
    assign carry[0] = cin;    

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin: gen_bfa
            bcd_fadd bfa(
                .a(a[i*4 +: 4]),        // 4-bit digit from a
                .b(b[i*4 +: 4]),        // 4-bit digit from b
                .cin(carry[i]),
                .sum(sum[i*4 +: 4]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[4]; 

endmodule