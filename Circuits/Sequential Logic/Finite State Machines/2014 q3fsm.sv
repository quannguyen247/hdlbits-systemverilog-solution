module top_module(
    input logic clk,
    input logic reset,   // Synchronous reset
    input logic s,
    input logic w,
    output logic z
);

    // There are many ways to do this assignments
    typedef enum logic {A, B} state_t;
    state_t state, next_state;
    logic [1:0] w_one_count, cycle_counter;

    always_comb begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = B;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (reset)
            cycle_counter <= 0;
        else if (state == B) begin 
            if (cycle_counter < 3)
                cycle_counter <= cycle_counter + 1'd1;
            else 
                cycle_counter <= 1;
        end else 
            cycle_counter <= 0;
    end

    always_ff @(posedge clk) begin
        if (reset)
            w_one_count <= 0;
        else if (state == B) begin
            if (cycle_counter == 3)
                w_one_count <= w; 
            else
                w_one_count <= w_one_count + w; 
        end else 
            w_one_count <= 0;
    end

    assign z = (w_one_count == 2'd2) && (cycle_counter == 2'd3);

endmodule