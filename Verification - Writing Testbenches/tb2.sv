module top_module( );

    logic clk, in, out;
    logic [2:0] s;
    q7 uut( .clk(clk), .in(in), .s(s), .out(out) );

    initial begin // Generate clock
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin // Generate stimulus
        in = 0; s = 3'd2;  // t = 0
        #10 s = 3'd6;
        #10 {in, s} = {1'b1, 3'd2};
        #10 {in, s} = {1'b0, 3'd7};
        #10 {in, s} = {1'b1, 3'd0};
        #30 in = 1'b0;
    end

endmodule