`timescale 1ns / 1ps

// Module: Uses two's complement to add/subtract two 8 bit numbers ranging from -128 to 127, outputs the sum and if sum overflowed
// No subtractor circuit exists so an adder circuit must be used as well
// Negative number rule: invert every bit and add one
// Example: -3 = -(00000011) = inverted 11111100 + 1 = 11111101
// 5 + (-3) = 000000101 + 11111101 = 100000010 (9 bits, since sum is 8 bit the final bit is sent to cout)
// Scale: -128 to 127 -> 
// -2^(n-1) to +2^(n-1)-1, where n = 8 bits
// (-128) 64 32 16 8 4 2 1
// 0 + 64 + 32 + 16 + 8 + 4 + 2 + 1 = 127
// -128 + 0 = -128
module adder_subtractor(

    // Inputs
    input [7:0] a, // number 1
    input [7:0] b, // number 2     
    
    // Outputs
    output [8:0] sum // result after operation
);

    // No overflow logic anymore as a 9-bit ripple adder was made to handle it
    // Set initial carry-in to zero (since never carrying in)
    wire cin;
    assign cin = 1'b0;
    
    wire cout; // Not necessary as a module output
    
    ripple_adder_9bit ra(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)); // Instantiates ripple adder for addition/subtraction 
    
endmodule
