module top_module(
    input logic [99:0] in,
    output logic [99:0] out
);

    // $bits() is a system function that returns the width of a signal in SystemVerilog
    always_comb begin
        for (int i = 0; i < $bits(out); i++)
            out[i] = in[$bits(out) - i - 1];
    end

endmodule