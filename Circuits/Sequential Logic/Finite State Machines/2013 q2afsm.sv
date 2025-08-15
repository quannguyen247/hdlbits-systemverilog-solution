module top_module(
    input logic clk,
    input logic resetn,    // active-low synchronous reset
    input logic [3:1] r,   // request
    output logic [3:1] g   // grant
);

    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t state, next_state;

    always_comb begin
        next_state = A;
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
            end
            B: next_state = r[1] ? B : A;
            C: next_state = r[2] ? C : A;
            D: next_state = r[3] ? D : A;
        endcase
    end

    always_ff @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    assign g = {(state == D), (state == C), (state == B)};

endmodule