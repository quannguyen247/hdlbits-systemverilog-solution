module top_module(
    input logic clk,
    input logic a,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (a)
            q <= 4'd4;
        else if (q >= 4'd6)
            q <= 4'd0;
        else
            q <= q + 4'd1;
    end

endmodule