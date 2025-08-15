module top_module(
    input logic clk,
    input logic areset,    // Freshly brainwashed Lemmings walk left =))
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic {LEFT, RIGHT} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            LEFT: next_state = bump_left ? RIGHT : LEFT;
            RIGHT: next_state = bump_right ? LEFT : RIGHT;
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

endmodule