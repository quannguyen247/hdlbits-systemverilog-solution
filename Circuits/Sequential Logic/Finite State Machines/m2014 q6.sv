module top_module(
    input logic clk,
    input logic reset,     // synchronous reset
    input logic w,
    output logic z
);

    typedef enum logic [2:0] {A, B, C, D, E, F} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    assign z = (state == E) || (state == F);

endmodule