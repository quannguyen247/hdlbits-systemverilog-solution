module top_module(
    input logic clk, 
    input logic load, 
    input logic [9:0] data, 
    output logic tc
);

    logic [9:0] cycle_value;
    
    always_ff @(posedge clk) begin
        if (load)
            cycle_value <= data;
        else if (cycle_value > 0)
            cycle_value <= cycle_value - 1'b1;
    end
    
    assign tc = (cycle_value == 0);
            
endmodule