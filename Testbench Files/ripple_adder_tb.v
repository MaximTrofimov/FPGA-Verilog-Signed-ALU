`timescale 1ns / 1ps

// Define testbench
module ripple_adder_tb();

    // Internal signals
    wire [7:0] sum;
    wire cout;
    
    // Storage elements
    reg [7:0] a = 0;
    reg [7:0] b = 0;
    reg cin = 0; 
    
    ripple_adder uut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    initial begin
        a = 8'd255;
        b = 8'd255;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd255;
        b = 8'd0;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd0;
        b = 8'd255;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd255;
        b = 8'd255;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd255;
        b = 8'd0;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd0;
        b = 8'd255;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd0;
        b = 8'd0;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd0;
        b = 8'd0;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd123;
        b = 8'd200;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd51;
        b = 8'd23;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd90;
        b = 8'd170;
        cin = 1'd0;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd123;
        b = 8'd200;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd51;
        b = 8'd23;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
        
        a = 8'd90;
        b = 8'd170;
        cin = 1'd1;
        #10;
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
      
        $finish;
    end 
endmodule
