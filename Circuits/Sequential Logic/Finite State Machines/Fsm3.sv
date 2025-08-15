module top_module(
    input logic clk,
    input logic in,
    input logic areset,
    output logic out
);

    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    assign out = (state == D);

endmodule