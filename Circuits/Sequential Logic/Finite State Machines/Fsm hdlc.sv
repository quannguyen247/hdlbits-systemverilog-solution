module top_module(
    input logic clk,
    input logic reset,    // Synchronous reset
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {NONE, ONE, TWO, THREE, FOUR, FIVE, SIX, DISCARD, FLAG, ERROR} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            NONE: next_state = in ? ONE : NONE;
            ONE: next_state = in ? TWO : NONE;
            TWO: next_state = in ? THREE : NONE;
            THREE: next_state = in ? FOUR : NONE;
            FOUR: next_state = in ? FIVE : NONE;
            FIVE: next_state = in ? SIX : DISCARD;
            SIX: next_state = in ? ERROR : FLAG;
            DISCARD: next_state = in ? ONE : NONE;
            FLAG: next_state = in ? ONE : NONE;
            ERROR: next_state = in ? ERROR : NONE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= NONE;
        else
            state <= next_state;
    end

    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);

endmodule