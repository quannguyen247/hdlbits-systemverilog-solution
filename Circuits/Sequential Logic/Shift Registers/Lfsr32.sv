module top_module(
    input logic clk,
    input logic reset,    // Active-high synchronous reset to 32'h1
    output logic [31:0] q
);

    logic [31:0] q_next;

    always_comb begin
        q_next = q >> 1;           // Shift all bits right by 1
        q_next[31] = q[0];         // Feedback for LFSR
        q_next[21] = q[22] ^ q[0];
        q_next[1] = q[2] ^ q[0];
        q_next[0] = q[1] ^ q[0];
    end

    always_ff @(posedge clk) begin
        if (reset)
            q <= 32'h1;
        else
            q <= q_next; // or q <= {q[0], q[31:23], q[22] ^ q[0], q[21:3], q[2] ^ q[0], q[1] ^ q[0]}; 
    end

endmodule