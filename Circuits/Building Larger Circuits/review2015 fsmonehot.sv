module top_module(
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,    // 10-bit one-hot current state
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    typedef enum logic [3:0] {
        S, S1, S11, S110, B0, B1, B2, B3, Count, Wait
    } state_t;

    assign B3_next = state[B2];
    assign S_next = (~d & state[S]) | (~d & state[S1]) | (~d & state[S110]) | (ack & state[Wait]);
    assign S1_next = d & state[S];
    assign Count_next = state[B3] | (~done_counting & state[Count]);
    assign Wait_next = (done_counting & state[Count]) | (~ack & state[Wait]);
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];

endmodule