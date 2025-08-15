module top_module(
    input logic [3:1] y,
    input logic w,
    output logic Y2
);

    typedef enum logic [3:1] {A, B, C, D, E, F} state_t;
    state_t y_next;

    always_comb begin
        // Cannot assign y_next = y because they are different types (enum vs packed array)
        case (y)
            A: y_next = w ? A : B;
            B: y_next = w ? D : C;
            C: y_next = w ? D : E;
            D: y_next = w ? A : F;
            E: y_next = w ? D : E;
            F: y_next = w ? D : C;
            default: y_next = A; // Use default instead
        endcase
    end

    assign Y2 = y_next[2];

endmodule