`timescale 1ns / 1ps

//Module: Multiplies two 8-bit integers and stores the product in product[15:0]
module multiplier(

    // Inputs
    input [7:0] a,
    input [7:0] b,
    
    // Outputs
    output[15:0] product
);
    wire p[7:0][7:0]; // A 2D array storing the partial products 
    // Used to fill a 2D array with partial products of each index of a and b
    genvar i, j;
    generate
        for(i = 0; i < 8; i = i + 1) begin
                for(j = 0; j < 8; j = j + 1) begin
                    and(p[i][j], a[i], b[j]);
                end
        end 
    endgenerate
    
    // Holds the carry from half-adder addition of each index of a and b
    // cout[index][position at index]
    // intermediate_sum[index][position at index]
    wire cout[15:0][7:0];
    wire intermediate_sum[15:0][7:0];
    
    // index zero of product
    assign product[0] = p[0][0]; // no carry out
    
    // index one of product
    half_adder ha0(.a(p[1][0]), .b(p[0][1]), .sum(product[1]), .cout(cout[1][0])); // 1 carry out to index 2

    // index two of product
    half_adder ha1(.a(p[2][0]), .b(p[1][1]), .sum(intermediate_sum[2][0]), .cout(cout[2][0])); // 3 carry out to index 3 
    half_adder ha2(.a(p[0][2]), .b(cout[1][0]), .sum(intermediate_sum[2][1]), .cout(cout[2][1]));
    half_adder ha3(.a(intermediate_sum[2][0]), .b(intermediate_sum[2][1]), .sum(product[2]), .cout(cout[2][2]));

    // index three of product
    full_adder fa0(.a(cout[2][0]), .b(cout[2][1]), .cin(cout[2][2]), .sum(intermediate_sum[3][0]), .cout(cout[3][0])); // 4 carry out to index 4 
    half_adder ha4(.a(p[3][0]), .b(p[2][1]), .sum(intermediate_sum[3][1]), .cout(cout[3][1]));
    half_adder ha5(.a(p[1][2]), .b(p[0][3]), .sum(intermediate_sum[3][2]), .cout(cout[3][2]));
    full_adder fa1(.a(intermediate_sum[3][0]), .b(intermediate_sum[3][1]), .cin(intermediate_sum[3][2]), .sum(product[3]), .cout(cout[3][3]));

    // index four of product
    half_adder ha6(.a(cout[3][0]), .b(cout[3][1]), .sum(intermediate_sum[4][0]), .cout(cout[4][0])); // 7 carry out to index 5 
    half_adder ha7(.a(cout[3][2]), .b(cout[3][3]), .sum(intermediate_sum[4][1]), .cout(cout[4][1]));
    full_adder fa2(.a(p[4][0]), .b(p[3][1]), .cin(p[2][2]), .sum(intermediate_sum[4][2]), .cout(cout[4][2]));
    half_adder ha8(.a(p[1][3]), .b(p[0][4]), .sum(intermediate_sum[4][3]), .cout(cout[4][3]));
    half_adder ha9(.a(intermediate_sum[4][0]), .b(intermediate_sum[4][1]), .sum(intermediate_sum[4][4]), .cout(cout[4][4]));
    half_adder ha10(.a(intermediate_sum[4][2]), .b(intermediate_sum[4][3]), .sum(intermediate_sum[4][5]), .cout(cout[4][5]));
    half_adder ha11(.a(intermediate_sum[4][4]), .b(intermediate_sum[4][5]), .sum(product[4]), .cout(cout[4][6]));
    
    // index five of product
    full_adder fa3(.a(cout[4][0]), .b(cout[4][1]), .cin(cout[4][2]), .sum(intermediate_sum[5][0]), .cout(cout[5][0])); // 6 carry out to index 6
    full_adder fa4(.a(cout[4][3]), .b(cout[4][4]), .cin(cout[4][5]), .sum(intermediate_sum[5][1]), .cout(cout[5][1]));
    full_adder fa5(.a(cout[4][6]), .b(p[5][0]), .cin(p[4][1]), .sum(intermediate_sum[5][2]), .cout(cout[5][2]));
    full_adder fa6(.a(p[3][2]), .b(p[2][3]), .cin(p[1][4]), .sum(intermediate_sum[5][3]), .cout(cout[5][3]));
    full_adder fa7(.a(p[0][5]), .b(intermediate_sum[5][0]), .cin(intermediate_sum[5][1]), .sum(intermediate_sum[5][4]), .cout(cout[5][4]));
    full_adder fa8(.a(intermediate_sum[5][2]), .b(intermediate_sum[5][3]), .cin(intermediate_sum[5][4]), .sum(product[5]), .cout(cout[5][5]));

    // index six of product
    full_adder fa9(.a(cout[5][0]), .b(cout[5][1]), .cin(cout[5][2]), .sum(intermediate_sum[6][0]), .cout(cout[6][0])); // 6 carry out to index 7
    full_adder fa10(.a(cout[5][3]), .b(cout[5][4]), .cin(cout[5][5]), .sum(intermediate_sum[6][1]), .cout(cout[6][1]));
    full_adder fa11(.a(p[6][0]), .b(p[5][1]), .cin(p[4][2]), .sum(intermediate_sum[6][2]), .cout(cout[6][2]));
    full_adder fa12(.a(p[3][3]), .b(p[2][4]), .cin(p[1][5]), .sum(intermediate_sum[6][3]), .cout(cout[6][3]));
    full_adder fa13(.a(p[0][6]), .b(intermediate_sum[6][0]), .cin(intermediate_sum[6][1]), .sum(intermediate_sum[6][4]), .cout(cout[6][4]));
    full_adder fa14(.a(intermediate_sum[6][2]), .b(intermediate_sum[6][3]), .cin(intermediate_sum[6][4]), .sum(product[6]), .cout(cout[6][5]));

    // index seven of product
    full_adder fa15(.a(cout[6][0]), .b(cout[6][1]), .cin(cout[6][2]), .sum(intermediate_sum[7][0]), .cout(cout[7][0])); // 7 carry out to index 8
    full_adder fa16(.a(cout[6][3]), .b(cout[6][4]), .cin(cout[6][5]), .sum(intermediate_sum[7][1]), .cout(cout[7][1]));
    full_adder fa17(.a(p[7][0]), .b(p[6][1]), .cin(p[5][2]), .sum(intermediate_sum[7][2]), .cout(cout[7][2]));
    full_adder fa18(.a(p[4][3]), .b(p[3][4]), .cin(p[2][5]), .sum(intermediate_sum[7][3]), .cout(cout[7][3]));
    full_adder fa19(.a(p[1][6]), .b(p[0][7]), .cin(intermediate_sum[7][0]), .sum(intermediate_sum[7][4]), .cout(cout[7][4]));
    full_adder fa20(.a(intermediate_sum[7][1]), .b(intermediate_sum[7][2]), .cin(intermediate_sum[7][3]), .sum(intermediate_sum[7][5]), .cout(cout[7][5]));
    half_adder ha12(.a(intermediate_sum[7][4]), .b(intermediate_sum[7][5]), .sum(product[7]), .cout(cout[7][6]));

    // index eight of product
    full_adder fa21(.a(cout[7][0]), .b(cout[7][1]), .cin(cout[7][2]), .sum(intermediate_sum[8][0]), .cout(cout[8][0])); // 7 carry out to index 9
    full_adder fa22(.a(cout[7][3]), .b(cout[7][4]), .cin(cout[7][5]), .sum(intermediate_sum[8][1]), .cout(cout[8][1]));
    full_adder fa23(.a(cout[7][6]), .b(p[7][1]), .cin(p[6][2]), .sum(intermediate_sum[8][2]), .cout(cout[8][2]));
    full_adder fa24(.a(p[5][3]), .b(p[4][4]), .cin(p[3][5]), .sum(intermediate_sum[8][3]), .cout(cout[8][3]));
    full_adder fa25(.a(p[2][6]), .b(p[1][7]), .cin(intermediate_sum[8][0]), .sum(intermediate_sum[8][4]), .cout(cout[8][4]));
    full_adder fa26(.a(intermediate_sum[8][1]), .b(intermediate_sum[8][2]), .cin(intermediate_sum[8][3]), .sum(intermediate_sum[8][5]), .cout(cout[8][5]));
    half_adder ha13(.a(intermediate_sum[8][4]), .b(intermediate_sum[8][5]), .sum(product[8]), .cout(cout[8][6]));

    // index nine of product
    full_adder fa27(.a(cout[8][0]), .b(cout[8][1]), .cin(cout[8][2]), .sum(intermediate_sum[9][0]), .cout(cout[9][0])); // 6 carry out to index 10
    full_adder fa28(.a(cout[8][3]), .b(cout[8][4]), .cin(cout[8][5]), .sum(intermediate_sum[9][1]), .cout(cout[9][1]));
    full_adder fa29(.a(cout[8][6]), .b(p[7][2]), .cin(p[6][3]), .sum(intermediate_sum[9][2]), .cout(cout[9][2]));
    full_adder fa30(.a(p[5][4]), .b(p[4][5]), .cin(p[3][6]), .sum(intermediate_sum[9][3]), .cout(cout[9][3]));
    full_adder fa31(.a(p[2][7]), .b(intermediate_sum[9][0]), .cin(intermediate_sum[9][1]), .sum(intermediate_sum[9][4]), .cout(cout[9][4]));
    full_adder fa32(.a(intermediate_sum[9][2]), .b(intermediate_sum[9][3]), .cin(intermediate_sum[9][4]), .sum(product[9]), .cout(cout[9][5]));
 
    // index ten of product
    full_adder fa33(.a(cout[9][0]), .b(cout[9][1]), .cin(cout[9][2]), .sum(intermediate_sum[10][0]), .cout(cout[10][0])); // 5 carry out to index 11
    full_adder fa34(.a(cout[9][3]), .b(cout[9][4]), .cin(cout[9][5]), .sum(intermediate_sum[10][1]), .cout(cout[10][1]));
    full_adder fa35(.a(p[7][3]), .b(p[6][4]), .cin(p[5][5]), .sum(intermediate_sum[10][2]), .cout(cout[10][2]));
    full_adder fa36(.a(p[4][6]), .b(p[3][7]), .cin(intermediate_sum[10][0]), .sum(intermediate_sum[10][3]), .cout(cout[10][3]));
    full_adder fa37(.a(intermediate_sum[10][1]), .b(intermediate_sum[10][2]), .cin(intermediate_sum[10][3]), .sum(product[10]), .cout(cout[10][4]));

    // index eleven of product
    full_adder fa38(.a(cout[10][0]), .b(cout[10][1]), .cin(cout[10][2]), .sum(intermediate_sum[11][0]), .cout(cout[11][0])); // 4 carry out to index 12
    full_adder fa39(.a(cout[10][3]), .b(cout[10][4]), .cin(p[7][4]), .sum(intermediate_sum[11][1]), .cout(cout[11][1]));
    full_adder fa40(.a(p[6][5]), .b(p[5][6]), .cin(p[4][7]), .sum(intermediate_sum[11][2]), .cout(cout[11][2]));
    full_adder fa41(.a(intermediate_sum[11][0]), .b(intermediate_sum[11][1]), .cin(intermediate_sum[11][2]), .sum(product[11]), .cout(cout[11][3]));
 
    // index twelve of product
    full_adder fa42(.a(cout[11][0]), .b(cout[11][1]), .cin(cout[11][2]), .sum(intermediate_sum[12][0]), .cout(cout[12][0])); // 3 carry out to index 13
    full_adder fa43(.a(cout[11][3]), .b(p[7][5]), .cin(p[6][6]), .sum(intermediate_sum[12][1]), .cout(cout[12][1]));
    full_adder fa44(.a(p[5][7]), .b(intermediate_sum[12][0]), .cin(intermediate_sum[12][1]), .sum(product[12]), .cout(cout[12][2]));
   
    // index thirteen of product
    full_adder fa45(.a(cout[12][0]), .b(cout[12][1]), .cin(cout[12][2]), .sum(intermediate_sum[13][0]), .cout(cout[13][0])); // 2 carry out to index 14
    full_adder fa46(.a(p[7][6]), .b(p[6][7]), .cin(intermediate_sum[13][0]), .sum(product[13]), .cout(cout[13][1]));

    // index fourteen of product
    full_adder fa47(.a(cout[13][0]), .b(cout[13][1]), .cin(p[7][7]), .sum(product[14]), .cout(cout[14][0])); // 1 carry out to index 15

    // index fifteen of product
    assign product [15] = cout[14][0];
    
endmodule
