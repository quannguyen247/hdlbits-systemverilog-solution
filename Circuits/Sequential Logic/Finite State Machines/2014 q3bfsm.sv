module top_module(
    input logic clk,
    input logic reset,   // Synchronous reset
    input logic x,
    output logic z
);

    typedef enum logic [2:0] {A, B, C, D, E} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    assign z = (state == D) || (state == E);

endmodule