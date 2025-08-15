module top_module(
    input logic clk,
    input logic areset,    // Freshly brainwashed Lemmings walk left.
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    typedef enum logic [2:0] {LEFT, RIGHT, FALL_L, FALL_R, DIG_L, DIG_R} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_L: next_state = ground ? LEFT : FALL_L;
            FALL_R: next_state = ground ? RIGHT : FALL_R;
            DIG_L: next_state = ground ? DIG_L : FALL_L;
            DIG_R: next_state = ground ? DIG_R : FALL_R;
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
    assign digging = (state == DIG_L) || (state == DIG_R);

endmodule