module top_module(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
); 

    assign s = a + b;
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

    /* The method below is not ideal for this problem, provided for reference only.
    wire [8:0] sum = a + b;     
    wire [7:0] low = a[6:0] + b[6:0]; 
    wire carry6 = low[7];
    wire carry7 = sum[8];
    assign overflow = carry6 ^ carry7;
    assign s = sum[7:0]; */

endmodule