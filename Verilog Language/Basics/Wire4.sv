module top_module(
    input  logic a, b, c,
    output logic w, x, y, z
);

    assign w = a;
	assign x = b;
	assign y = b;
	assign z = c;
    // assign {w, x, y, z} = {a, b, b, c};
    
endmodule