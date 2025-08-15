module top_module(
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,       // Make sound
    output logic motor         // Vibrate
);

    assign ringer = ring & ~vibrate_mode;
    assign motor = ring & vibrate_mode;

endmodule