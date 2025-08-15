module top_module(
    input logic clk,
    input logic in,
    input logic reset,    // Synchronous reset
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {IDLE, DATA, STOP, WAIT} state_t;
    state_t state, next_state;
    logic [3:0] bit_counter;
    logic [7:0] shift_reg;

    always_comb begin
        next_state = state;
        case (state)
            IDLE: if (!in) next_state = DATA;
            DATA: if (bit_counter == 8) next_state = in ? STOP : WAIT;
            STOP: next_state = in ? IDLE : DATA;
            WAIT: next_state = in ? IDLE : WAIT;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (reset)
            bit_counter <= 4'd0;
        else if (state == DATA)
            bit_counter <= bit_counter + 1'd1;
        else
            bit_counter <= 4'd0;
    end

    always_ff @(posedge clk) begin
        if (reset)
            shift_reg <= 8'd0;
        else if (state == DATA && next_state == DATA)
            shift_reg <= {in, shift_reg[7:1]};
    end

    assign done = (state == STOP);
    assign out_byte = done ? shift_reg : 8'bx;

endmodule