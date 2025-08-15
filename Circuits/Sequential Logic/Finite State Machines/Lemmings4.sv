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

    // There are many ways to do this assignment
    typedef enum logic [2:0] {LEFT, RIGHT, FALL_L, FALL_R, DIG_L, DIG_R, SPLAT} state_t;
    state_t state, next_state;
    int fall_count; // Use int to avoid overflow since falling can last a long time

    always_comb begin
        next_state = state;
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
            FALL_L: begin
                if (ground)
                    next_state = (fall_count >= 20) ? SPLAT : LEFT;
                else
                    next_state = FALL_L;
            end
            FALL_R: begin
                if (ground)
                    next_state = (fall_count >= 20) ? SPLAT : RIGHT;
                else
                    next_state = FALL_R;
            end
            DIG_L: next_state = ground ? DIG_L : FALL_L;
            DIG_R: next_state = ground ? DIG_R : FALL_R;
            SPLAT: next_state = SPLAT;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if ((state == FALL_L) || (state == FALL_R))
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L) || (state == FALL_R);
    assign digging = (state == DIG_L) || (state == DIG_R);

endmodule