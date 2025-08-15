module top_module(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_last = 8'b0; // Store previous state

    always_ff @(posedge clk) begin
        in_last <= in;                  // Update previous state
        pedge <= ~in_last & in;         // Detect rising edge for each bit
    end

endmodule