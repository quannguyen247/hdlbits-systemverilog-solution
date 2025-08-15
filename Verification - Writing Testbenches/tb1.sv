module top_module( output logic A, output logic B );

    initial begin
        {A, B} = 2'b00;      // t = 0, initialize default values for logic
        #10  A = 1;          // t = 10  : A goes high
        #5   B = 1;          // t = 15  : B goes high
        #5   A = 0;          // t = 20  : A goes low
        #20  B = 0;          // t = 40  : B goes low
    end

endmodule