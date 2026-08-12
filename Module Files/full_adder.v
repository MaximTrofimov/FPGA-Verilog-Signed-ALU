`timescale 1ns / 1ps

// Module: Adds three 1-bit inputs (a, b, cin) and outputs a 1-bit sum and a 1-bit carry-out (cout)
module full_adder(

    // Inputs
    input a,
    input b,
    input cin,
    
    // Outputs
    output sum,
    output cout

);
    
    wire xor_gate_1;
    assign xor_gate_1 = a ^ b;
    
    wire xor_gate_2;
    assign xor_gate_2 = xor_gate_1 ^ cin;
    assign sum = xor_gate_2; 
    
    wire and_gate_1;
    assign and_gate_1 = xor_gate_1 & cin;
    
    wire and_gate_2;
    assign and_gate_2 = a & b;
    
    wire or_gate_1;
    assign or_gate_1 = and_gate_1 | and_gate_2;
    assign cout = or_gate_1;
    
endmodule
