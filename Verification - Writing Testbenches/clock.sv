module top_module( );

    logic clk; // Generate clock signal
    dut uut( .clk(clk) ); // Instantiate DUT (Device Under Test)
    initial clk = 1'b0;
    always #5 clk = ~clk;

endmodule