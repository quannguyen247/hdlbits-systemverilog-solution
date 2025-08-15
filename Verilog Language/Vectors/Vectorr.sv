module top_module( 
    input logic [7:0] in,
    output logic [7:0] out
);

    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
    // A for loop or generate-for loop can be used to reverse the bits automatically,
    // but at this point, you still do not know how to use those methods yet, so skip:)

endmodule