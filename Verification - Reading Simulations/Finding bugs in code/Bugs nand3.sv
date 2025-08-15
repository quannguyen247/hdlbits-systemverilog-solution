module top_module( input logic a, input logic b, input logic c, output logic out );

    logic and_out;
    andgate inst1( and_out, a, b, c, 1'b1, 1'b1 );
    assign out = ~and_out;

endmodule