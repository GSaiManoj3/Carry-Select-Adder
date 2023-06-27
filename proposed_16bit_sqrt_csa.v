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
module rca2(a,b,cin,sum,carry_out);
//rca - ripple carry adder || a,b - 2bit inputs || cin - carry_in
//sum - final 2bit sum || carry_out - output carry
// 3 carry wires required
input [1:0] a,b;
input cin;
output [1:0] sum;
output carry_out;
wire  carrywires;
////data modeelling
    fa fa0(a[0],b[0],cin,sum[0],carrywires);
    fa fa1(a[1],b[1],carrywires,sum[1],carry_out);
endmodule


module rca3(a,b,cin,sum,carry_out);
//rca - ripple carry adder || a,b - 3bit inputs || cin - carry_in
//sum - final 3bit sum || carry_out - output carry
// 3 carry wires required
input [2:0] a,b;
input cin;
output [2:0] sum;
output carry_out;
wire [1:0] carrywires;
////data modeelling
    fa fa0(a[0],b[0],cin,sum[0],carrywires[0]);
    fa fa1(a[1],b[1],carrywires[0],sum[1],carrywires[1]);
    fa fa2(a[2],b[2],carrywires[1],sum[2],carry_out);
endmodule


module rca4(a,b,cin,sum,carry_out);
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



module rca5(a,b,cin,sum,carry_out);
//rca - ripple carry adder || a,b - 5bit inputs || cin - carry_in
//sum - final 5bit sum || carry_out - output carry
// 3 carry wires required
input [4:0] a,b;
input cin;
output [4:0] sum;
output carry_out;
wire [3:0] carrywires;
////data modeelling
    fa fa0(a[0],b[0],cin,sum[0],carrywires[0]);
    fa fa1(a[1],b[1],carrywires[0],sum[1],carrywires[1]);
    fa fa2(a[2],b[2],carrywires[1],sum[2],carrywires[2]);
    fa fa3(a[3],b[3],carrywires[2],sum[3],carrywires[3]);
    fa fa4(a[4],b[4],carrywires[3],sum[4],carry_out);
endmodule
/////////////////////////////////////////////////////////////
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
module common_bool(a,b,cin,s,cout);
//common_bool - common boolean final_logic
input a,b,cin;
output s,cout;
wire [3:0] final_logic;
    xor m1(final_logic[0],a,b);
    not m2(final_logic[1],final_logic[0]);
    and m3(final_logic[2],a,b);
    or  m4(final_logic[3],a,b);
    tcom1 m5(final_logic[0],final_logic[1],cin,s);
    tcom1 m6(final_logic[2],final_logic[3],cin,cout);
endmodule 
/////////////////////////////////////////////////////////////
module epo_csa2(a,b,cin,sum,c_out);
//epo_csa - each 2 bit piece of carry select adder
//a,b are 2 bit inputs || sum ,c_out arre respective outputs
input [1:0] a,b;
input cin;
output [1:0] sum;
output c_out;
wire [1:0] alternate_sum1,alternate_sum2;
wire alternate_carry1,alternate_carry2;
wire final_logic;
////data flow modelling
// so sum is calculated with both carry 0 and 1
     rca2 w1(a[1:0],b[1:0],1'b0,alternate_sum1,alternate_carry1);
     common_bool z1(a[0],b[0],cin,alternate_sum2[0],final_logic);
     common_bool z2(a[1],b[1],final_logic,alternate_sum2[1],alternate_carry2);
//so now a mux should give output sum and other one carry for same select
     assign sum = (cin) ? alternate_sum2 : alternate_sum1;
     tcom1 m2(alternate_carry1,alternate_carry2,cin,c_out);
     
endmodule

module epo_csa3(a,b,cin,sum,c_out);
//epo_csa - each 3 bit piece of carry select adder
//a,b are 3 bit inputs || sum ,c_out arre respective outputs
input [2:0] a,b;
input cin;
output [2:0] sum;
output c_out;
wire [2:0] alternate_sum1,alternate_sum2;
wire alternate_carry1,alternate_carry2;
wire [1:0] final_logic;
////data flow modelling
// so sum is calculated with both carry 0 and 1
     rca3 w3(a[2:0],b[2:0],1'b0,alternate_sum1,alternate_carry1);
     common_bool z1(a[0],b[0],cin,alternate_sum2[0],final_logic[0]);
     common_bool z2(a[1],b[1],final_logic[0],alternate_sum2[1],final_logic[1]);
     common_bool z3(a[2],b[2],final_logic[1],alternate_sum2[2],alternate_carry2);
//so now a mux should give output sum and other one carry for same select
     assign sum = (cin) ? alternate_sum2 : alternate_sum1;
     tcom1 m2(alternate_carry1,alternate_carry2,cin,c_out);
     
endmodule


module epo_csa4(a,b,cin,sum,c_out);
//epo_csa - each 4 bit piece of carry select adder
//a,b are 4 bit inputs || sum ,c_out arre respective outputs
input [3:0] a,b;
input cin;
output [3:0] sum;
output c_out;
wire [3:0] alternate_sum1,alternate_sum2;
wire alternate_carry1,alternate_carry2;
wire [2:0] final_logic;
////data flow modelling
// so sum is calculated with both carry 0 and 1
     rca4 w5(a[3:0],b[3:0],1'b0,alternate_sum1,alternate_carry1);
     common_bool z1(a[0],b[0],cin,alternate_sum2[0],final_logic[0]);
     common_bool z2(a[1],b[1],final_logic[0],alternate_sum2[1],final_logic[1]);
     common_bool z3(a[2],b[2],final_logic[1],alternate_sum2[2],final_logic[2]);
     common_bool z4(a[3],b[3],final_logic[2],alternate_sum2[3],alternate_carry2);
//so now a mux should give output sum and other one carry for same select
    assign sum = (cin) ? alternate_sum2 : alternate_sum1;
     tcom1 m2(alternate_carry1,alternate_carry2,cin,c_out);
     
endmodule


module epo_csa5(a,b,cin,sum,c_out);
//epo_csa - each 5 bit piece of carry select adder
//a,b are 5 bit inputs || sum ,c_out arre respective outputs
input [4:0] a,b;
input cin;
output [4:0] sum;
output c_out;
wire [4:0] alternate_sum1,alternate_sum2;
wire alternate_carry1,alternate_carry2;
wire [3:0] final_logic;
////data flow modelling
// so sum is calculated with both carry 0 and 1
     rca5 w7(a[4:0],b[4:0],1'b0,alternate_sum1,alternate_carry1);
     common_bool z1(a[0],b[0],cin,alternate_sum2[0],final_logic[0]);
     common_bool z2(a[1],b[1],final_logic[0],alternate_sum2[1],final_logic[1]);
     common_bool z3(a[2],b[2],final_logic[1],alternate_sum2[2],final_logic[2]);
     common_bool z4(a[3],b[3],final_logic[2],alternate_sum2[3],final_logic[3]);
     common_bool z5(a[4],b[4],final_logic[3],alternate_sum2[4],alternate_carry2);
//so now a mux should give output sum and other one carry for same select
     assign sum = (cin) ? alternate_sum2 : alternate_sum1;
     tcom1 m2(alternate_carry1,alternate_carry2,cin,c_out);
     
endmodule
/////////////////////FINAL MOODULE OR MAIN MODULE////////////////////////////

module csa(a,b,carry_in,sum,carry_out);

input [15 : 0] a,b;
input carry_in;
output [15 : 0] sum;
output carry_out;
///now wire is required for carry from each slice
wire [3:0] alternate_carry;
////data flow modelling
     epo_csa2 q0(a[1:0],b[1:0],carry_in,sum[1:0],alternate_carry[0]);
     epo_csa2 q1(a[3:2],b[3:2],alternate_carry[0],sum[3:2],alternate_carry[1]);
     epo_csa3 q2(a[6:4],b[6:4],alternate_carry[1],sum[6:4],alternate_carry[2]);
     epo_csa4 q3(a[10:7],b[10:7],alternate_carry[2],sum[10:7],alternate_carry[3]);
     epo_csa5 q4(a[15:11],b[15:11],alternate_carry[3],sum[15:11],carry_out);
endmodule


