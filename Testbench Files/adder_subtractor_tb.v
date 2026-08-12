`timescale 1ns / 1ps

module adder_subtractor_tb();

    // Storage Elements
    reg signed [7:0] a = 0;
    reg signed [7:0] b = 0;
    
    // Internal Signals
    wire signed [8:0] sum; // these can remain as wire as they are being driven by the module and not internally inside the module under a clock
    wire cout;

    adder_subtractor uut(.a(a), .b(b), .sum(sum), .cout(cout));
    initial begin
        a = -8'd5;
        b = 8'd10;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
        a = -8'd100;
        b = 8'd73;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
        a = 8'd100;
        b = -8'd128;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
        a = 8'd127;
        b = -8'd50;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
        a = 8'd127;
        b = 8'd127;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
        a = -8'd128;
        b = -8'd128;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
        a = 8'd0;
        b = 8'd0;
        #10;
        $display("a=%d b=%d sum=%d cout=%b", a, b, sum, cout);
    end 
endmodule
