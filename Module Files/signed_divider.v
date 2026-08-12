`timescale 1ns / 1ps

// Module: Uses two's complement to change negative inputs to their positive magnitude for division and changes the remainder and quotient back to negative if meant to be negative
module signed_divider(

    // Inputs
    input [7:0] dividend,
    input [7:0] divisor,
    input clk, // Needed as an input to div, even though this module is sequential
    input reset, // Needed as an input to div
    
    // Outputs
    output [7:0] remainder, // Remain as sequential as this module is purely sequential
    output [7:0] quotient,
    output error_div // returns 1 if the divisor is zero, otherwise 0
);
    wire [3:0] cout; // 4-bit buffer for the 4 ripple adders. Shoulder never be written to as no addition overflow possible

    wire [7:0] dividend_xor;
    wire [7:0] divisor_xor;
    
    // If MSB is 1, dividend/divisor is negative. So this is done to XOR the number as a first step of conversion to its magnitude
    assign dividend_xor = dividend[7:0] ^ {8{dividend[7]}};
    assign divisor_xor = divisor[7:0] ^ {8{divisor[7]}};
    
    // Add 1 to finish conversion to magnitude 2's complement
    wire [7:0] dividend_magnitude;
    wire [7:0] divisor_magnitude;
    
    ripple_adder ra0(.a(dividend_xor), .b(8'b0), .cin(dividend[7]), .sum(dividend_magnitude), .cout(cout[0]));
    ripple_adder ra1(.a(divisor_xor), .b(8'b0), .cin(divisor[7]), .sum(divisor_magnitude), .cout(cout[1]));
    
    // Store the positive 2's complement versions of remainder and quotient from the div instantiation
    wire [7:0] remainder_intermediate;
    wire [7:0] quotient_intermediate;

    divider div(
        .dividend(dividend_magnitude), // Both inputs are converted to 2's complement positives
        .divisor(divisor_magnitude),
        .clk(clk),
        .reset(reset),
        .remainder(remainder_intermediate), // Always 2's complement positive
        .quotient(quotient_intermediate) // Always 2's complement positive
    );
    
    wire remainder_sign;
    wire quotient_sign;
    
    wire [7:0] remainder_xor;
    wire [7:0] quotient_xor;
    
    // Return 1 if negative
    assign remainder_sign = dividend[7]; // remainder will be negative when the dividend is negative (in that case rem can never be positive as the original sign is always kept)
    assign quotient_sign = dividend[7] ^ divisor[7]; // Same as multiplication, quotient will be negative when one of the inputs is negative, otherwise positive. 
    
    assign remainder_xor = remainder_intermediate[7:0] ^ {8{remainder_sign}};
    assign quotient_xor = quotient_intermediate[7:0] ^ {8{quotient_sign}};
        
    // Final step of 2's complement: Adds 1 if the quotient/remainder was meant to be converted to negative
    ripple_adder ra2(.a(remainder_xor), .b(8'b0), .cin(remainder_sign), .sum(remainder), .cout(cout[2])); // Must feed 8 bits into .a/.b so .cin must be used for adding 1 bit
    ripple_adder ra3(.a(quotient_xor), .b(8'b0), .cin(quotient_sign), .sum(quotient), .cout(cout[3]));
    
    assign error_div = (divisor == 8'b0);

endmodule
