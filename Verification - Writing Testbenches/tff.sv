module top_module; // or top_module() since there are no ports

    logic clk, reset, t, q;

    tff dut(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

    initial clk = 0; // Clock generation (simpler version)
    always #5 clk = ~clk;

    initial begin
        reset = 1; t = 0;      
        // Hold reset for more than 5 time units
        // If released too soon, the flip-flop can't capture the value -> q unknown
        #6 reset = 0; t = 1;  
    end

endmodule