module top_module(
    input logic clk,
    input logic areset,

    input logic predict_valid,
    input logic [6:0] predict_pc,
    output logic predict_taken,
    output logic [6:0] predict_history,

    input logic train_valid,
    input logic train_taken,
    input logic train_mispredicted,
    input logic [6:0] train_history,
    input logic [6:0] train_pc
);

    logic [1:0] PHT [127:0];
    logic [6:0] history;

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            history <= 0;
            PHT <= '{default: 1}; // 2'b01 for all element of arrays
        end else begin
            if (train_valid)
                PHT[train_history^train_pc] += train_taken ? (PHT[train_history^train_pc] < 3) : -(PHT[train_history^train_pc] > 0);
            if (train_valid && train_mispredicted)
                history <= {train_history[5:0], train_taken};
            else if (predict_valid)
                history <= {history[5:0], predict_taken};
        end
    end

    assign predict_history = history;
    assign predict_taken = PHT[history^predict_pc][1];

endmodule