module top_module(
    input logic [3:0] in,
    output logic [1:0] pos
);

    always_comb begin
        case (1'b1)
            in[0]: pos = 2'd0;
            in[1]: pos = 2'd1;
            in[2]: pos = 2'd2;
            in[3]: pos = 2'd3;
            default: pos = 2'd0;
        endcase
    end

endmodule