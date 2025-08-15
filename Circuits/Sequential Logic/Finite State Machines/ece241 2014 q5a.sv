module top_module(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {WAIT, PRINT1, PRINT0} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WAIT;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            WAIT: next_state = x ? PRINT1 : WAIT;   // Wait for x=1
            PRINT1: next_state = x ? PRINT0 : PRINT1; // x=0 -> z=1
            PRINT0: next_state = x ? PRINT0 : PRINT1; // x=1 -> z=0
        endcase
    end

    assign z = (state == PRINT1);

endmodule