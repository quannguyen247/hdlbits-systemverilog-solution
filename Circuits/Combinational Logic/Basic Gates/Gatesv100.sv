module top_module( 
    input logic [99:0] in,
    output logic [98:0] out_both,
    output logic [99:1] out_any,
    output logic [99:0] out_different
);

    // Both in[i] and in[i+1] are 1
    assign out_both = in[99:1] & in[98:0];

    // Either in[i] or in[i-1] is 1
    assign out_any = in[99:1] | in[98:0];

    // Difference between in[i] and in[i+1], wrap around to the beginning
    assign out_different = in ^ {in[0], in[99:1]};

endmodule