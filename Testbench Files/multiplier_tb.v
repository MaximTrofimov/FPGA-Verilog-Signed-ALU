`timescale 1ns / 1ps

module multiplier_tb();

    // Internal signals
    wire [15:0] product;
    
    // Storage elements
    reg [7:0] a = 0;
    reg [7:0] b = 0;
    
    multiplier uut(
        .a(a),
        .b(b),
        .product(product)
    );
    
    initial begin
        a = 8'd255;
        b = 8'd255;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd0;
        b = 8'd255;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd255;
        b = 8'd0;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd0;
        b = 8'd0;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd100;
        b = 8'd100;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd24;
        b = 8'd89;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd198;
        b = 8'd3;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);
        
        a = 8'd241;
        b = 8'd159;
        #10;
        $display("a=%d b=%d | product=%d", a, b, product);    
    end
    
endmodule
