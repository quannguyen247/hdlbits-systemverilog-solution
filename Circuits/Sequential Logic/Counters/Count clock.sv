module top_module(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    logic en_ss, en_mm, en_hh;
    assign en_ss = ena; 
    assign en_mm = en_ss && (ss == 8'h59); 
    assign en_hh = en_mm && (mm == 8'h59); 

    always_ff @(posedge clk) begin
        if (reset)
            {pm, hh, mm, ss} <= {1'b0, 8'h12, 8'h00, 8'h00};
        else begin
            // Seconds
            if (en_ss) begin
                if (ss == 8'h59)
                    ss <= 8'h00;
                else if (ss[3:0] == 4'h09)
                    ss <= {ss[7:4] + 1'b1, 4'h0};
                else
                    ss <= ss + 1'b1;
            end
            // Minutes
            if (en_mm) begin
                if (mm == 8'h59)
                    mm <= 8'h00;
                else if (mm[3:0] == 4'h09)
                    mm <= {mm[7:4] + 1'b1, 4'h0};
                else
                    mm <= mm + 1'b1;
            end
            // Hours and PM
            if (en_hh) begin
                if (hh == 8'h11 && pm) // 11:59:59 PM -> 12:00:00 AM
                    {pm, hh} <= {1'b0, 8'h12};
                else if (hh == 8'h11 && !pm) // 11:59:59 AM -> 12:00:00 PM
                    {pm, hh} <= {1'b1, 8'h12};
                else if (hh == 8'h12) // 12:59:59 AM/PM -> 01:00:00 AM/PM
                    hh <= 8'h01;
                else if (hh[3:0] == 4'h09) // 09:59:59 AM/PM -> 10:00:00 AM/PM
                    hh <= {hh[7:4] + 1'b1, 4'h0};
                else
                    hh <= hh + 1'b1;
            end
        end
    end

endmodule