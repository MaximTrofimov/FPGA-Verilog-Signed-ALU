## FPGA-Verilog-Signed-ALU
Verilog based Arithmetic Logic Unit (ALU) created in AMD Vivado for Basys3 Hardware. The ALU includes addition, subtraction, multiplication, and division with any two 8-bit 2's complement signed integer inputs. 

## Description
All four operations (+, -, x, ÷) were built from logic gates instead of using verilog's built in operations. The aim was to get a strong understanding of how combinational and sequential modules are built from first principles and combined to perform calculations. Input and output integer numbers are considered using two's complement, with the MSB being the sign bit.

- Addition is done by taking two inputs, a[7:0] and b[7:0], assigned by the state of the 16 on-board switches, and combining them using chained full adders in order to get a 9-bit wide sum.
- Subtraction follows the same architecture as addition and occurs when either input a[7:0] or b[7:0] are negative, resulting in a 9-bit wide difference.
- Multiplication is done following an array multiplier framework where full and half adders were used to perform the necessary bit additions, resulting in a 16-bit wide product.
- Division is done as a clocked process following a restoring division algorithm, which shifts and subtracts bits to provide a 8-bit quotient, 8-bit remainder, and an error flag bit (dividing by zero).  

## Operation
The left eight switches represent b, the right eight switches represent a (this is only relevant for division where b is the divisor and a is the dividend). The MSB of each 8-bit entry is the sign bit and inputs are read in 2's complement. Flip the switches to get the desired input integers, which range from -128 to 127. Select the operation using the three buttons (addition/subtraction, multiplication, division). Keep your selected button held and press the calculate button. The result will show up on the 16 on-board LEDs. The sign bit of the result is always set to be the 16th bit, and when on means the result is a negative number. For division an 8 bit remainder is present which is also read in 2's complement. Additionally, a 1-bit error LED is present and is lit when the user attempts to divide by zero. 

Two's Complement Guide: 
- 11111111 = -128 +64 +32 +16 +8 +4 +2 +1 (The MSB is read as -128 or -greatest number bit, the rest add when a 1 is in the placeholder)
- 00110000 = +32 +16

## Photos
<img width="5591" height="2371" alt="division_example" src="https://github.com/user-attachments/assets/f2a1fee5-2ec0-40c6-a3ae-b7d8dec091d8" />

- Division Example: divisor = 00001000 = +8, dividend = 11000111 = -57, quotient = 11111001 = -7, remainder = 11111111 = -1.

 
<img width="5402" height="2164" alt="error_example" src="https://github.com/user-attachments/assets/f0d1465b-a971-4ddd-8313-831f45c0dd4e" />

- Division Error Example: divisor = 00000000 = 0, dividend = 00000001 = 1, error_led = 1.

 
<img width="5551" height="2262" alt="addition_example" src="https://github.com/user-attachments/assets/7aea9586-964e-41af-bc13-e51d9e3294b4" />

- Addition/Subtraction Example: b = 00001100, a = 10010101, sum/difference = 110100001.

 
<img width="5459" height="2234" alt="multiplication_example" src="https://github.com/user-attachments/assets/c94da3d3-7e03-4a10-a900-4f65e4b22db8" />

- Multiplication Example: b = 10011011 = -101, a = 00001001 = 9, product = 1111110001110011 = -909.

 
<img width="2210" height="732" alt="top_design_unsimplified" src="https://github.com/user-attachments/assets/e5b93829-442c-4c64-a892-920759dbc8bb" />

- Unsimplified Top Design Schematic

 
<img width="1052" height="957" alt="adder_subtractor" src="https://github.com/user-attachments/assets/88df10ff-4da2-41dc-9098-01f19f8315e3" />

- Adder/Subtractor Schematic

 
<img width="2205" height="858" alt="signed_divider" src="https://github.com/user-attachments/assets/d16a9ad5-4a26-4b7c-a9d1-28186a352ad9" />

- Signed Divider Schematic

 
<img width="2208" height="747" alt="signed_multipler" src="https://github.com/user-attachments/assets/5f474091-764a-4b12-84cb-40fb7e33166d" />

- Signed Multiplier Schematic

 
<img width="2212" height="1071" alt="top_design" src="https://github.com/user-attachments/assets/38ff0466-6d1b-4426-98db-f1bd586753e4" />

- Simplified Top Design Schematic

 

## Repo Structure
```
Images/
Module Files/
Constraint Files/
Testbench Files/       
```

## Credits
- Shawn Hymel FPGA Tutorial Series [https://www.youtube.com/watch?v=lLg1AgA2Xoo&list=PLEBQazB0HUyT1WmMONxRZn9NmQ_9CIKhb]
- 4-bit Array Multiplier Tutorial and Example [https://vlsiverify.com/verilog/verilog-codes/array-multiplier/]
- Restoring Division Algorithm Explanation [https://www.youtube.com/watch?v=PzV6gYpVLuc&list=LL&index=2&t=472s]
- Restoring Division Algorithm Verilog Tutorial [https://www.youtube.com/watch?v=KjYszNGHdhI&list=LL&index=1]
  
