module top_module(
    input logic clk,
    input logic in,
    input logic reset,    // Synchronous reset
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {IDLE, DATA, PARITY, STOP, WAIT} state_t;
    state_t state, next_state;
    logic [3:0] bit_counter;
    logic odd_parity;

    parity p_check( clk, ~(state == DATA), in, odd_parity );

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (~in)
                    next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 8) begin
                    if (in == ~odd_parity)
                        next_state = PARITY;
                    else
                        next_state = WAIT;
                end
            end
            PARITY: begin
                if (in)
                    next_state = STOP;
                else
                    next_state = WAIT;
            end
            STOP: begin
                if (~in)
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            WAIT: begin
                if (in)
                    next_state = IDLE;
            end
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
            out_byte <= 0;
        else if (state == DATA && bit_counter < 8)
            out_byte[bit_counter] <= in;
    end

    assign done = (state == STOP);

endmodule