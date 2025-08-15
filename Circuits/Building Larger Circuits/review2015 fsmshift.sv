module top_module(
    input logic clk,
    input logic reset,      // Synchronous reset
    output logic shift_ena
);

    logic [2:0] count;
    always_ff @(posedge clk) begin
        if (reset)
            count <= 3'd0;
        else if (count < 3'd4)
            count <= count + 1'd1;
    end

    assign shift_ena = (count < 3'd4);

endmodule