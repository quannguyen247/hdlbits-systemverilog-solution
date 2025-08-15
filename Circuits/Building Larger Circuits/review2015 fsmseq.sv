module top_module(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {BIT1, BIT2, BIT3, BIT4, FOUND} state_t;
    state_t state, next_state;

    always_comb begin
        next_state = state;
        unique case (state) // unique case for state machine
            BIT1: next_state = data ? BIT2 : BIT1;
            BIT2: next_state = data ? BIT3 : BIT1;
            BIT3: next_state = !data ? BIT4 : BIT3;
            BIT4: next_state = data ? FOUND : BIT1;
            FOUND: next_state = FOUND;
        endcase
    end

    always @(posedge clk) begin 
        if (reset) 
            state <= BIT1;
        else 
            state <= next_state;    
    end

    assign start_shifting = (state == FOUND);

endmodule