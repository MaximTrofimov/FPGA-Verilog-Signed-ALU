`timescale 1ns / 1ps

// General review of the whole process from the restoring division algorith video and why it works:
/*
Division is repeated subtraction: "How many times does the divisor fit in the dividend?"
Example: 13/4 in binary = 1101 div 0100
Starting from n = 3, does 0100 fit into 1 (leftmost bit of the dividend)? No, Q[3] = 0
n = 2, does 0100 fit into 11? No, Q[2] = 0
n = 1, does 0100 fit into 110? Yes, Q[1] = 1 -> R = 10
for n = 0, value is remainder shifted left by 1 with remaining bit of the dividend at [0], 1.
n = 0, does 0100 fit into 101? Yes, Q[0] = 1
R = 1
Q = 0011

Same as in the code, Q shifts left each cycle and the result is kept in the remainder (originally the divisor) once a positive number is outputted
*/

// Module: Divides the dividend by the divisor, outputs the quotient and the remainder.
// Process is clocked and repeats until n (# bits) = 0 
module divider(

    // Inputs
    input [7:0] dividend,
    input [7:0] divisor,
    input clk,
    input reset, // active-low
    
    // Outputs
    output reg [7:0] remainder,
    output reg [7:0] quotient
);    

    // Internal registers
    reg [8:0] A; // Remainder
    reg [8:0] M; // Divisor
    reg [7:0] Q; // Dividend
    reg [3:0] n; // counts down from 8 to 0
    reg [16:0] concatenation_buffer; // buffer used to concatenate A and Q (17 bits)
    reg init_complete; // has initialization occured
 
    reg [8:0] newA; // holds the A = A - M subtraction result. MSB is checked to see if result is +/-
 
    always @(posedge clk) begin
        if (!reset) begin
            // reset state
            init_complete <= 0; // initialization has not occured yet
        end
        else begin
            if (!init_complete) begin // has not been initialized
                // Initialization, first cycle after reset is set to high
                Q <= dividend; // original input number
                M <= {1'b0, divisor}; // Concatenate to 9 bits with the MSB being 0, making it an always positive 2's complement number                
                A <= 9'b0; // A (remainder) will take in 8 bit values, a 9th bit is needed as a signal to show if went negative as a 9-bit magnitude value will not be reached
                n <= 4'd8; // used to count from 8 to 0
                init_complete <= 1; // initialization complete
            end
            else begin
                if (n != 0) begin // start at 8, end at 0
                    concatenation_buffer = {A, Q} << 1; // concatenates A and Q and shifts by 1, last bit of Q = ?
                    
                    // Gets the difference between the remainder and the divisor
                    // newA = A_shifted - M  
                    // Since both are 9-bit wide with MSBs being reserved for a sign bit, 2's complement subtraction can be done
                    newA = concatenation_buffer[16:8] + (~M + 1'b1); // two's complement of M (flip each bit and add 1, MSB = 1 making it negative)
                    Q = concatenation_buffer[7:0]; // first 8 bits in the buffer belong to the dividend

                    // A starts as being all zero's with the first bit of the dividend being shifted in. 
                    // If the divisor is greater in magnitue once it gets flipped and added to the dividend's first bit the sum is negative, so the quotient's first bit gets set to zero.
                    // Once the difference is positive (remainder >= divisor), the difference is used as the new remainder, quotient's bit is set to 1 (the divisor fit into the number), process continue.
                    
                    // Q[0] is the bit that is unknown due to left shift by 1 bit
                    // Checks if the divisor fits into bits of the dividend by seeing if the result is positive/negative
                    if (newA[8] == 0) begin
                        // Positive result, successful fit
                        // if A[n] = 0, Q[0] = 1
                        Q[0] = 1'b1;
                        A = newA; // Difference becomes the new remainder
                    end
                    else begin
                        // Negative result, fit unsuccessful
                        // if A[n] = 1, Q[0] = 0
                        Q[0] = 1'b0;
                        A = concatenation_buffer[16:8]; // restore A
                    end

                    n <= n - 1;
                end
            end
            
            // Continues repeating until n = 0: (shift left) SLAQ, A = A - M, Q[0] = ? 
            if (n == 0 && init_complete == 1) begin // checks for init_complete just incase 
                quotient <= Q;
                remainder <= A[7:0];
            end
        end
    end
   
endmodule
