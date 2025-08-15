module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    // State encoding SystemVerilog-style :)
    typedef enum logic [1:0] {SNT, WNT, WT, ST} state_t; 
    state_t next_state;

    always_comb begin
        case (state)
            SNT: next_state = train_taken ? WNT : SNT;
            WNT: next_state = train_taken ? WT  : SNT;
            WT : next_state = train_taken ? ST  : WNT;
            ST : next_state = train_taken ? ST  : WT;
            default: next_state = SNT;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WNT;
        else if (train_valid)
            state <= next_state;
    end

endmodule