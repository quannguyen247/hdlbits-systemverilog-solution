module top_module(
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    always_ff @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= (q ^ (q << 1)) | (~(q >> 1) & (q << 1)); // q_new[i] = (q[i] ^ q[i-1]) | (~q[i+1] & q[i-1])
    end

endmodule