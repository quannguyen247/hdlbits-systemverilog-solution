module top_module(
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    // i: current cell index. dx,dy: neighbor direction. sum: number of live neighbors
    int i, dx, dy, sum;

    always_ff @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            for (i = 0; i < 256; i++) begin
                sum = 0; // reset live neighbor count for each cell
                // dy: up (-1), down (+1), or stay (0)
                // dx: left (-1), right (+1), or stay (0)
                for (dy = -1; dy <= 1; dy++)
                    for (dx = -1; dx <= 1; dx++)
                        if (dx || dy) // skip the cell itself
                            // (X + Y) % Y = toroidal
                            sum = sum + q[
                                (((i / 16 + dy) + 16) % 16) * 16 + // wrap row (toroidal)
                                (((i % 16 + dx) + 16) % 16)        // wrap column (toroidal)
                            ];
                // Next state: alive if exactly 3 neighbors, or alive and 2 neighbors
                q[i] <= (sum == 3) || (q[i] && sum == 2);
            end
        end
    end

endmodule