module top_module(
    input logic clk,
    input logic areset,    // Freshly brainwashed Lemmings walk left.
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    output logic walk_left,
    output logic walk_right,
    output logic aaah
);

    typedef enum logic [1:0] {LEFT, RIGHT, FALL_L, FALL_R} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            LEFT: next_state = (!ground) ? FALL_L : (bump_left ? RIGHT : LEFT);
            RIGHT: next_state = (!ground) ? FALL_R : (bump_right ? LEFT : RIGHT);
            FALL_L: next_state = ground ? LEFT : FALL_L;
            FALL_R: next_state = ground ? RIGHT : FALL_R;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L) || (state == FALL_R);

endmodule