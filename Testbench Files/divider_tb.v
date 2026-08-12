`timescale 1ns / 1ps

module divider_tb();

    // Internal signals
    wire [7:0] remainder;
    wire [7:0] quotient;
    
    // Storage elements
    reg [7:0] dividend = 0;
    reg [7:0] divisor = 0;
    reg clk = 0;
    reg reset = 0;
    
    divider uut(
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .reset(reset),
        .remainder(remainder),
        .quotient(quotient)
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
        $display("q=%d r=%d", quotient, remainder);
        
        reset = 0; // reset state to start up
        dividend = 8'd120;
        divisor = 8'd200;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d", quotient, remainder);
        
        reset = 0; // reset state to start up
        dividend = 8'd230;
        divisor = 8'd35;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d", quotient, remainder);
        
        reset = 0; // reset state to start up
        dividend = 8'd1;
        divisor = 8'd0;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d", quotient, remainder);
        
        reset = 0; // reset state to start up
        dividend = 8'd0;
        divisor = 8'd1;
        #10;
        reset = 1; // non-reset state
        #100;
        $display("q=%d r=%d", quotient, remainder);
        
        $finish;
    end
endmodule
