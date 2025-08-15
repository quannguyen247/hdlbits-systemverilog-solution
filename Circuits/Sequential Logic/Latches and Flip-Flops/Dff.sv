module top_module(
    input logic clk,    // Clocks are used in sequential circuits
    input logic d,
    output logic q
);

    // Clocked always blocks should use non-blocking assignments
    always_ff @(posedge clk) begin
        q <= d;
    end

endmodule