module top_module(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
        endcase
    end

    assign z = (state == A) & x | (state == B) & ~x;

endmodule