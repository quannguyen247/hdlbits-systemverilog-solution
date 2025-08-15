module top_module( );

    logic [1:0] in;
    logic out;
    andgate uut( .in(in), .out(out) );

    initial begin
        in = 2'b00;     // t = 0
        #10 in = 2'b01; // t = 10
        #10 in = 2'b10; // t = 20
        #10 in = 2'b11; // t = 30
    end
    
endmodule