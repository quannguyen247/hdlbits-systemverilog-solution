module top_module(
    input logic clk,
    input logic resetn,   // synchronous reset
    input logic in,
    output logic out
);

    logic [3:0] sr;

    always_ff @(posedge clk) begin
        if (!resetn)
            sr <= 4'b0;
        else
            sr <= {in, sr[3:1]};
    end

    assign out = sr[0];

endmodule