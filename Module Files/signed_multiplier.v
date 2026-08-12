`timescale 1ns / 1ps

// Module: Uses multiplier.v to convert negative inputs to their magnitudes for proper multiplication,
// converts the output back to two's complement to account for negative cases
module signed_multiplier(

    // Inputs
    input [7:0] a,
    input [7:0] b,
    
    // Outputs
    output [15:0] product
);
    
    wire [7:0] a_xor;
    wire [7:0] b_xor;
    
    wire [7:0] a_final;
    wire [7:0] b_final;
    
    wire cout[3:0]; // Only added as a parameter of ra, should never store a value as addition overflow is impossible. 
    
    // If MSB is 1, a/b is negative. So this is done to XOR the number as a first step of conversion to its magnitude
    assign a_xor = a[7:0] ^ {8{a[7]}};
    assign b_xor = b[7:0] ^ {8{b[7]}};
   
    // Adds 1 if the original a/b was negative before the XOR to fit with two's complement structure. 
    ripple_adder ra0(.a(a_xor), .b(8'b0), .cin(a[7]), .sum(a_final), .cout(cout[0])); 
    ripple_adder ra1(.a(b_xor), .b(8'b0), .cin(b[7]), .sum(b_final), .cout(cout[1]));         
    
    // Multiplies the magnitudes of a and b according to two's complement structure   
    wire [15:0] intermediate_product; 
    multiplier m(.a(a_final), .b(b_final), .product(intermediate_product));
    
    // Product will only be negative if a is + and b is - or vv. Therefore this is the only case needed to convert to 2's complement
    wire product_convert;
    assign product_convert = a[7] ^ b[7]; // becomes 1 if conversion needed (product is negative)
    
    wire [15:0] product_xor;
    assign product_xor = intermediate_product[15:0] ^ {16{product_convert}};
    
    ripple_adder ra2(.a(product_xor[7:0]), .b(8'b0), .cin(product_convert), .sum(product[7:0]), .cout(cout[2])); 
    ripple_adder ra3(.a(product_xor[15:8]), .b(8'b0), .cin(cout[2]), .sum(product[15:8]), .cout(cout[3])); 

endmodule
