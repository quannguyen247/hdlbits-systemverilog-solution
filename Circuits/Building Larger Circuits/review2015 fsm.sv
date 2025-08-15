module top_module(
    input logic clk,
    input logic reset,      // Synchronous reset
    input logic data,
    output logic shift_ena,
    output logic counting,
    input logic done_counting,
    output logic done,
    input logic ack
);

    typedef enum logic [3:0] {
        S_IDLE, S1, S11, S110, B0, B1, B2, B3, S_COUNT, S_WAIT
    } state_t;

    state_t state, next_state;

    always_comb begin
        next_state = state;
        case (state)
            S_IDLE: next_state = data ? S1 : S_IDLE;
            S1: next_state = data ? S11 : S_IDLE;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? B0 : S_IDLE;
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = S_COUNT;
            S_COUNT: next_state = done_counting ? S_WAIT : S_COUNT;
            S_WAIT: next_state = ack ? S_IDLE : S_WAIT;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);
    assign done = (state == S_WAIT);
    assign counting = (state == S_COUNT);

endmodule