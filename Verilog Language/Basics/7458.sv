module top_module( 
    input logic p1a, p1b, p1c, p1d, p1e, p1f,
    output logic p1y,
    input logic p2a, p2b, p2c, p2d,
    output logic p2y 
);

    assign p1y = (p1a & p1b & p1c) | (p1d & p1e & p1f);
    assign p2y = (p2a & p2b) | (p2c & p2d);
    
endmodule