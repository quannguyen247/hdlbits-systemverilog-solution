module top_module(
    input logic clk,
    input logic aresetn,    // Asynchronous active-low reset
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {S_1, S_10, S_101} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S_1;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            S_1: next_state = x ? S_10 : S_1;       // Looking for 1
            S_10: next_state = !x ? S_101 : S_10;   // Saw 1, looking for 0
            S_101: next_state = x ? S_10 : S_1;     // Saw 1,0, looking for 1 again
            default: next_state = S_1;
        endcase
    end

    always_comb begin
        case (state)
            S_1: z = 0;
            S_10: z = 0;
            S_101: z = x;
            default: z = 1'bx;
        endcase
    end

endmodule