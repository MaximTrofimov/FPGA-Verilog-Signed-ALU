`timescale 1ns / 1ps

module signed_multiplier_tb();

    // Storage Elements
    reg signed [7:0] a = 0;
    reg signed [7:0] b = 0;
    
    // Internal Signals
    wire signed [15:0] product; 

    signed_multiplier uut(.a(a), .b(b), .product(product));
    initial begin
        a = -8'd5;
        b = 8'd10;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
        a = -8'd100;
        b = 8'd73;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
        a = 8'd100;
        b = -8'd128;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
        a = 8'd127;
        b = -8'd50;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
        a = 8'd127;
        b = 8'd127;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
        a = -8'd128;
        b = -8'd128;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
        a = 8'd0;
        b = 8'd0;
        #10;
        $display("a=%d b=%d product=%d", a, b, product);
    end 

endmodule
