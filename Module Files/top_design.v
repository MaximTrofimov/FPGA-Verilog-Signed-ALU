`timescale 1ns / 1ps

// Module: Top design combining the addition/subtraction, multiplication, and division modules and assigning I/O's to physical Basys 3 hardware 
module top_design(
    
    // Inputs
    input clk, // 100MHz on-board clock
    input [15:0] sw, // Switches for two 8-bit inputs
    input btnCalculate, // Calculate
    input btnAdd, // Add signed integers
    input btnMultiply, // Multiply
    input btnDivide, // Divide
    
    // Outputs
    // 1 sign led, 15 leds for value bits
    output reg [15:0] led, // Output 2's complement signed integer (bit by bit)
    output error_led, // External LED
    output [7:0] remainder_led // 8 External LEDs
); 
    
    // Switches for bit inputs of a and b
    wire [7:0] a;
    wire [7:0] b;
    assign a = sw[7:0];
    assign b = sw[15:8];
    
    // All three modules run continuously
    wire [8:0] sum;
    adder_subtractor add_sub(.a(a), .b(b), .sum(sum));
    
    wire [15:0] product;
    signed_multiplier mult(.a(a), .b(b), .product(product));
    
    wire [7:0] quotient; 
    wire [7:0] remainder;
    wire div_error;
    signed_divider div(.dividend(a), .divisor(b), .clk(clk), .reset(btnCalculate), .remainder(remainder), .quotient(quotient), .error_div(div_error));

    // LEDs only lit based on the button (operation) being pressed
    // LED 15 is dedicated to sign bit always
    always @(posedge clk) begin
        if(btnCalculate)begin
            if(btnAdd)begin
                led <= {sum[8], 7'b0, sum[7:0]};
            end else if(btnMultiply) begin
                led <= product;
            end else if(btnDivide) begin
                led <= {quotient[7], 8'b0, quotient[6:0]};
            end
        end 
    end
    
    // Ternary (conditional) operator
    assign error_led = btnDivide ? div_error : 1'b0; // if btnDivide = 1, set error led = div_error, otherwise, set error_led = 0
    assign remainder_led = btnDivide ? remainder : 8'b0; // if btnDivide = 1, set remainder_led = remainder, otherwise, set remainder_led = 8'b0

endmodule
