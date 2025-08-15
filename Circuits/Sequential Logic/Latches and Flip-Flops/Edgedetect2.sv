module top_module(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] in_last = 8'b0; // Store previous state

    always_ff @(posedge clk) begin
        in_last <= in;              // Update previous state
        anyedge <= in_last ^ in;    // Detect any edge (rising or falling) using XOR
    end

endmodule