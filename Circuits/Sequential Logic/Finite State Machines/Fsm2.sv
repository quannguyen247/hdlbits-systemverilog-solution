module top_module(
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t state, next_state;

    always_comb begin
        case (state)
            ON:   next_state = k ? OFF : ON;
            OFF:  next_state = j ? ON : OFF;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    assign out = (state == ON);

endmodule