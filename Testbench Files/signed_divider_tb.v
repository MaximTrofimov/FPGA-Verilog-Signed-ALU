`timescale 1ns / 1ps

module signed_divider_tb();

    // Internal Signals
    wire signed [7:0] remainder;
    wire signed [7:0] quotient;
    wire error_div;
    
    // Storage Elements
    reg [7:0] dividend = 0;
    reg [7:0] divisor = 0;
    reg clk = 0; 
    reg reset = 0;
    
    signed_divider uut(
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .reset(reset),
        .remainder(remainder),
        .quotient(quotient),
        .error_div(error_div)
    );
    
    // Generates a clock with a 10ns period
    always #5 clk = ~clk;
    
    initial begin
        reset = 0; // reset state to start up
        dividend = 8'd11;
        divisor = 8'd3;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        reset = 0; // reset state to start up
        dividend = -8'd120;
        divisor = 8'd22;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        reset = 0; // reset state to start up
        dividend = 8'd78;
        divisor = -8'd35;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        reset = 0; // reset state to start up
        dividend = 8'd1;
        divisor = 8'd0;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        reset = 0; // reset state to start up
        dividend = 8'd0;
        divisor = 8'd1;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        reset = 0; // reset state to start up
        dividend = -8'd27;
        divisor = 8'd4;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        reset = 0; // reset state to start up
        dividend = -8'd78;
        divisor = -8'd4;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d e=%b", quotient, remainder, error_div);
        
        $finish;
    end
    
endmodule
