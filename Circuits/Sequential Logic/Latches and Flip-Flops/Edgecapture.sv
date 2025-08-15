module top_module(
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

    logic [31:0] in_last; // Store previous state

    always_ff @(posedge clk) begin
        in_last <= in;
        if (reset)
            out <= 32'b0;
        else
            out <= out | (in_last & ~in); // Capture falling edge, hold until reset
    end

endmodule