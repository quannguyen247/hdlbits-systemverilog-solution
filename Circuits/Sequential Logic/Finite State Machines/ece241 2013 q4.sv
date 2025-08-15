module top_module(
    input logic clk,
    input logic reset,
    input logic [3:1] s,
    output logic fr3,
    output logic fr2,
    output logic fr1,
    output logic dfr
);

    // There are many ways to do this assignment
    typedef enum logic [1:0] {S_LOW, S_MIDLOW, S_MIDHIGH, S_HIGH} state_t;
    state_t prev_state, state, next_state; // prev_state stores the previous stable state

    always_comb begin
        next_state = state;
        case (state)
            S_LOW: begin
                if (s[1]) next_state = S_MIDLOW;
            end
            S_MIDLOW: begin
                if (s[2]) next_state = S_MIDHIGH;
                else if (!s[1]) next_state = S_LOW;
            end
            S_MIDHIGH: begin
                if (s[3]) next_state = S_HIGH;
                else if (!s[2]) next_state = S_MIDLOW;
            end
            S_HIGH: begin
                if (!s[3]) next_state = S_MIDHIGH;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= S_LOW;
        else begin
            if (state != next_state)
                prev_state <= state;
            state <= next_state;
        end
    end

    assign fr3 = (state == S_LOW);
    assign fr2 = (state == S_LOW) || (state == S_MIDLOW);
    assign fr1 = (state != S_HIGH);
    assign dfr = (state == S_LOW) || (prev_state > state);

endmodule