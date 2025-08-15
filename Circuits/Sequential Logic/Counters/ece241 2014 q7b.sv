module top_module(
    input logic clk,
    input logic reset,
    output logic OneHertz,
    output logic [2:0] c_enable
);

    logic [3:0] Q0, Q1, Q2;

    assign c_enable = {
        (Q0 == 4'd9) && (Q1 == 4'd9), // c_enable[2]
        (Q0 == 4'd9),                 // c_enable[1]
        1'b1                          // c_enable[0]
    };

    bcdcount counter0( clk, reset, c_enable[0], Q0 );
    bcdcount counter1( clk, reset, c_enable[1], Q1 );
    bcdcount counter2( clk, reset, c_enable[2], Q2 );

    assign OneHertz = (Q0 == 4'd9) && (Q1 == 4'd9) && (Q2 == 4'd9);

endmodule