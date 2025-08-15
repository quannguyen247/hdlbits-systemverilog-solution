module top_module(
    input logic clk,
    input logic reset, // Synchronous reset
    input logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input logic ack
);

    typedef enum logic [3:0] {
        S_IDLE, S1, S11, S110, B0, B1, B2, B3, S_COUNT, S_WAIT
    } state_t;

    state_t state, next_state;
    logic [3:0] delay_reg;
    logic [15:0] cycle_counter; // Counts from 0 to (delay+1)*1000 - 1

    always_comb begin
        next_state = state;
        case (state)
            S_IDLE: next_state = data ? S1 : S_IDLE;
            S1: next_state = data ? S11 : S_IDLE;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? B0 : S_IDLE;
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = S_COUNT;
            S_COUNT: next_state = (cycle_counter == (delay_reg + 1) * 1000 - 1) ? S_WAIT : S_COUNT;
            S_WAIT: next_state = ack ? S_IDLE : S_WAIT;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (reset)
            cycle_counter <= 0;
        else if (next_state == S_COUNT)
            cycle_counter <= (state == S_COUNT) ? cycle_counter + 1'd1 : 1'd0;
        else
            cycle_counter <= 0;
    end

    always_ff @(posedge clk) begin
        if (reset)
            delay_reg <= 0;
        else case (state)
            B0: delay_reg[3] <= data;
            B1: delay_reg[2] <= data;
            B2: delay_reg[1] <= data;
            B3: delay_reg[0] <= data;
        endcase
    end

    assign counting = (state == S_COUNT);
    assign done = (state == S_WAIT);
    assign count = (state == S_COUNT) ? 4'(delay_reg - (cycle_counter / 1000)) : 4'd0;

endmodule