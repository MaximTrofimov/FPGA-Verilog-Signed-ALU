`timescale 1ns / 1ps // #unit/precision (smallest incriment simulator can round to) 

// wire when continuous unclocked assignment, reg when assigned in an always/initial block clocked/unclocked
// Define testbench
module full_adder_tb();

    // Internal signals
    wire sum;
    wire cout;
    
    // Storage elements
    // no need for clk since full_adder.v is fully combinational
    // reg since being changed manually
    reg a = 0;
    reg b = 0;
    reg cin = 0; 
    
    // Creates an instance of full_adder and connects its ports to signals in testbench
    full_adder uut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    integer i;
    
    // Exhaustive enumeration (each combination is tested)
    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i; // Concatenation: binary counting from all 0 to all 1, tests all possible inputs. 
            #10; // 10 * 1ns = 10ns
            $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout); // %b = binary
        end
        $finish; // End simulation
    end
endmodule


