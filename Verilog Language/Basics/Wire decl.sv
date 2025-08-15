module top_module(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    logic w1, w2;         
    assign w1 = a & b;    
    assign w2 = c & d;    
    assign out = w1 | w2; 
    assign out_n = ~out;  

endmodule