module top_module(
    input logic clk,
    input logic reset,    // Synchronous reset to state B
    input logic in,
    output logic out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    assign out = (state == B);

endmodule