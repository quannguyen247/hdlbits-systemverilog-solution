module top_module(
    input logic clk,
    input logic areset,

    input logic predict_valid,
    input logic predict_taken,
    output logic [31:0] predict_history,

    input logic train_mispredicted,
    input logic train_taken,
    input logic [31:0] train_history
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            predict_history <= 0;
        else begin
            if (train_mispredicted)
                predict_history <= {train_history[30:0], train_taken};
            else if (predict_valid)
                predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule