module ha(a,b,s,c);
//ha - half adder || a,b - inputs || s - sum || c - carry
input a,b;
output s,c;
///data modelling
    xor s1(s,a,b);
    and c1(c,a,b);
endmodule
/////////////////////////////////////////////////////////////
module fa(a,b,c,s,c_out);
//fa - full adder || a,b,c - inputs || s - sum || c_out - final-carry
input a,b,c;
output s,c_out;
wire sum_wire,carry_wire,carry2_wire;
///data modelling of full adder using half adder
    ha ha1(a,b,sum_wire,carry_wire);
    ha ha2(sum_wire,c,s,carry2_wire);
    or or1(c_out,carry_wire,carry2_wire);
endmodule
/////////////////////////////////////////////////////////////
module rca(a,b,cin,sum,carry_out);
//rca - ripple carry adder || a,b - 4bit inputs || cin - carry_in
//sum - final 4bit sum || carry_out - output carry
// 3 carry wires required
input [3:0] a,b;
input cin;
output [3:0] sum;
output carry_out;
wire [2:0] carrywires;
////data modeelling
    fa fa0(a[0],b[0],cin,sum[0],carrywires[0]);
    fa fa1(a[1],b[1],carrywires[0],sum[1],carrywires[1]);
    fa fa2(a[2],b[2],carrywires[1],sum[2],carrywires[2]);
    fa fa3(a[3],b[3],carrywires[2],sum[3],carry_out);
endmodule
/////////////////////////////////////////////////////////////
module tcom4(a,b,s,mux_ans);
//tcom - two cross one mux || a,b - 4 bit iputs || s - select || mux_ans
parameter bits = 4;
input [bits-1 : 0] a,b;
input s;
output [bits-1 : 0]mux_ans;
////data flow modelling
     assign mux_ans = (s)?b:a;
endmodule
module tcom1(a,b,s,mux_ans);
//tcom - two cross one mux || a,b - 1 bit iputs || s - select || mux_ans
parameter bits = 1;
input [bits-1 : 0] a,b;
input s;
output [bits-1 : 0]mux_ans;
////data flow modelling
     assign mux_ans = (s)?b:a;
endmodule
//reminder here a b indicates sum when carry is 0 and 1 respectively
/////////////////////////////////////////////////////////////
module epo_csa(a,b,cin,sum,c_out);
//epo_csa - each 4 bit piece of carry select adder
//a,b are 4 bit inputs || sum ,c_out arre respective outputs
input [3:0] a,b;
input cin;
output [3:0] sum;
output c_out;
wire [3:0] alternate_sum1,alternate_sum2;
wire alternate_carry1,alternate_carry2;
////data flow modelling
// so sum is calculated with both carry 0 and 1
     rca rca1(a[3:0],b[3:0],1'b0,alternate_sum1,alternate_carry1);
     rca rca2(a[3:0],b[3:0],1'b1,alternate_sum2,alternate_carry2);
//so now a mux should give output sum and other one carry for same select
     tcom4 tcom1(alternate_sum1,alternate_sum2,cin,sum);
     tcom1 tcom2(alternate_carry1,alternate_carry2,cin,c_out);
     
endmodule

/////////////////////FINAL MOODULE OR MAIN MODULE////////////////////////////

module csa(a,b,carry_in,sum,carry_out);

input [15 : 0] a,b;
input carry_in;
output [15 : 0] sum;
output carry_out;
///now wire is required for carry from each slice
wire [2:0] alternate_carry;
////data flow modelling
     epo_csa q0(a[3:0],b[3:0],carry_in,sum[3:0],alternate_carry[0]);
     epo_csa q1(a[7:4],b[7:4],alternate_carry[0],sum[7:4],alternate_carry[1]);
     epo_csa q2(a[11:8],b[11:8],alternate_carry[1],sum[11:8],alternate_carry[2]);
     epo_csa q3(a[15:12],b[15:12],alternate_carry[2],sum[15:12],carry_out);
endmodule


