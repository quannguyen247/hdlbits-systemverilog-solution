module top_module(
    input logic clk,
    input logic slowena,
    input logic reset,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset)
            q <= 4'd0;
        else if (slowena) begin
            if (q >= 4'd9)
                q <= 4'd0;
            else
                q <= q + 4'd1;
        end
    end

endmodule