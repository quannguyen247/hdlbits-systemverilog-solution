module top_module(
    input logic clk,
    input logic areset,    // Asynchronous reset to state B
    input logic in,
    output logic out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // Next state logic
    always_comb begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule