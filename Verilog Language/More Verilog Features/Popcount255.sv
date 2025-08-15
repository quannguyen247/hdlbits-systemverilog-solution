module top_module(
    input logic [254:0] in,
    output logic [7:0] out
);

    always_comb begin
        out = 0;
        for (int i = 0; i < $bits(in); i++)
            out += in[i];
    end

endmodule