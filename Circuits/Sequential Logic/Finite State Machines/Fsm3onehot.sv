module top_module(
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    typedef enum logic [1:0] {A, B, C, D} state_t;

    assign next_state[A] = (state[A] | state[C]) & ~in;
    assign next_state[B] = (state[A] | state[B] | state[D]) & in;
    assign next_state[C] = (state[B] | state[D]) & ~in;
    assign next_state[D] = state[C] & in;

    assign out = state[D];

endmodule