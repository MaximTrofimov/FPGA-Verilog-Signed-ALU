`timescale 1ns / 1ps

// Module: adds two 1 bit numbers, outputs the sum bit and a carry-out bit
module half_adder(

    // Inputs
    input a,
    input b,
    
    // Outputs
    output sum,
    output cout
);
    assign sum = a ^ b;
    
    assign cout = a & b;
    
endmodule
