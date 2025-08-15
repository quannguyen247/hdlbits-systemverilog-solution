module top_module(
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (shift_ena)
            q <= {q[2:0], data};
        if (count_ena)
            q <= q - 1'd1;
    end

endmodule