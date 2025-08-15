module top_module(
    input logic do_sub,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out,
    output logic result_is_zero
);

    always_comb begin
        case (do_sub)
            1'b0: out = a + b;
            1'b1: out = a - b;
        endcase
        result_is_zero = !out;
    end

endmodule