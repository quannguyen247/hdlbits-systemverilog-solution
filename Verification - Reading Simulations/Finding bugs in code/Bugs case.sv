module top_module(
    input logic [7:0] code,
    output logic [3:0] out,
    output logic valid
);

    always_comb begin
        valid = 1;
        out = 0;
        case (code)
            8'h45: out = 0;
            8'h16: out = 1;
            8'h1e: out = 2;
            8'h26: out = 3;
            8'h25: out = 4;
            8'h2e: out = 5;
            8'h36: out = 6;
            8'h3d: out = 7;
            8'h3e: out = 8;
            8'h46: out = 9;
            default: valid = 0;
        endcase
    end

endmodule