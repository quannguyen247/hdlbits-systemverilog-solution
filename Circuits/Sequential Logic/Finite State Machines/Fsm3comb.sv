module top_module(
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    typedef enum logic [1:0] {A, B, C, D} state_t;

    always_comb begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
        endcase
    end

    assign out = (state == D);

endmodule