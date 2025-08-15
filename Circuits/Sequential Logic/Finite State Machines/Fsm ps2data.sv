module top_module(
    input logic clk,
    input logic [7:0] in,
    input logic reset,    // Synchronous reset
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_t;
    state_t state, next_state;
    logic [7:0] b1, b2, b3;

    always_comb begin
        next_state = state;
        case (state)
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = in[3] ? BYTE2 : BYTE1;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) 
            state <= BYTE1;
        else 
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (reset) 
            {b1, b2, b3} <= 0;
        else begin
            case (next_state)
                BYTE2: b1 <= in;
                BYTE3: b2 <= in;
                DONE: b3 <= in;
            endcase
        end
    end

    assign done = (state == DONE);
    assign out_bytes = {b1, b2, b3};

endmodule