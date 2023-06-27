# Carry-Select-Adder
## This project shows the implementation of 16 Bit Carry Select Adder in Verilog

Carry select adder is faster compared to most of the adders because it will generate sum before getting the carry by generating sum for both the cases carry 0 and carry 1 and by using multiplexer with carry input as select switch to the multiplexer so the sum is generated faster by using connecting multiplexers instead of using a ripple carry adder completely waiting for previous carry.............

### BLOCK DIAGRAM OF CONVENTIONAL CARRY SELECT ADDER :
![Screenshot (149)](https://github.com/GSaiManoj3/Carry-Select-Adder/assets/115135766/412822bd-e98f-433b-90b9-5b7053605407)

### MODIFIED CARRY SELECT ADDER :
This is a slight modification to conventional CSA by replacing a ripple carry adder of carry 1 with a bcd to excess-1 convertor

### SQRT CARRY SELECT ADDER :
This is modification done to epo_csa (each piece of carry select adder ) module by dividing it to irregular bits

### PROPOSED 16-BIT SQRT CARRY SELECT ADDER BLOCK DIAGRAM :
![Screenshot (150)](https://github.com/GSaiManoj3/Carry-Select-Adder/assets/115135766/1e236f01-bc5a-46f8-83c4-be0d6c3f025b)

## REFERENCE LINK FOR COMPLETE THEORY PART :
https://www.akgec.ac.in/wp-content/uploads/2019/06/AKG_Int_Journal_Tech_Vol_6_no_1_9.pdf
