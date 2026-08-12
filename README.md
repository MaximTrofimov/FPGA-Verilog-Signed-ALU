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
-11111111 = -128 +64 +32 +16 +8 +4 +2 +1 (The MSB is read as -128 or -greatest number bit, the rest add when a 1 is in the placeholder)
-00110000 = +32 +16

## Photos

## Repo Structure
```
Images/
Module Files/
Constraint Files/
Testbench Files/       
```

## Credits



