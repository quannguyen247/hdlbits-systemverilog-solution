module top_module(
    input logic clk,
    input logic [7:0] d,
    input logic [1:0] sel,
    output logic [7:0] q
);

    logic [7:0] w1, w2, w3;

    my_dff8 dff1(
        .clk(clk),
        .d(d),
        .q(w1)
    );

    my_dff8 dff2(
        .clk(clk),
        .d(w1),
        .q(w2)
    );

    my_dff8 dff3(
        .clk(clk),
        .d(w2),
        .q(w3)
    );

    assign q = (sel == 2'd0) ? d :
               (sel == 2'd1) ? w1 :
               (sel == 2'd2) ? w2 : w3;

endmodule