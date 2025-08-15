module top_module(
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

    typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} state_t;

    assign next_state[S0] = (state[S0] | state[S1] | state[S2] | state[S3] | state[S4] | state[S7] | state[S8] | state[S9]) & ~in;
    assign next_state[S1] = (state[S0] | state[S8] | state[S9]) & in;
    assign next_state[S2] = (state[S1] & in);
    assign next_state[S3] = (state[S2] & in);
    assign next_state[S4] = (state[S3] & in);
    assign next_state[S5] = (state[S4] & in);
    assign next_state[S6] = (state[S5] & in);
    assign next_state[S7] = (state[S6] | state[S7]) & in;
    assign next_state[S8] = (state[S5] & ~in);
    assign next_state[S9] = (state[S6] & ~in);

    assign out1 = state[S8] | state[S9];
    assign out2 = state[S7] | state[S9];

endmodule