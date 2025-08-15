module top_module(
    input logic clk,
    input logic resetn,    // active-low synchronous reset
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [3:0] {
        S_IDLE,         // 0: Initial state, hold until resetn released
        S_PULSE_F,      // 1: Pulse f=1 for one cycle
        S_WAIT_X1,      // 2: Wait for x="1"
        S_WAIT_X10,     // 3: Saw "1", wait for "0"
        S_WAIT_X101,    // 4: Saw "1,0", wait for final "1"
        S_CHECK_Y1,     // 5: Sequence complete, check y (first chance)
        S_CHECK_Y2,     // 6: Still checking y (second chance)
        S_LOCK_G_ON,    // 7: Success, lock g=1 forever
        S_LOCK_G_OFF    // 8: Fail, lock g=0 forever
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (~resetn)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            S_IDLE: next_state = S_PULSE_F;
            S_PULSE_F: next_state = S_WAIT_X1;
            S_WAIT_X1: next_state = x ? S_WAIT_X10 : S_WAIT_X1;
            S_WAIT_X10: next_state = !x ? S_WAIT_X101 : S_WAIT_X10;
            S_WAIT_X101: next_state = x ? S_CHECK_Y1 : S_WAIT_X1;
            S_CHECK_Y1: next_state = y ? S_LOCK_G_ON : S_CHECK_Y2;
            S_CHECK_Y2: next_state = y ? S_LOCK_G_ON : S_LOCK_G_OFF;
            S_LOCK_G_ON: next_state = S_LOCK_G_ON;
            S_LOCK_G_OFF: next_state = S_LOCK_G_OFF;
        endcase
    end

    assign f = (state == S_PULSE_F);
    assign g = (state == S_CHECK_Y1) || (state == S_CHECK_Y2) || (state == S_LOCK_G_ON);

endmodule