module tb_csa;
   
     reg [15:0] a;
     reg [15:0] b;
     reg carry_in;
     wire [15:0] sum;
     wire carry_out;

     csa dut(.a(a),
             .b(b),
             .carry_in(carry_in),
             .sum(sum),
             .carry_out(carry_out));

    initial begin 
        $dumpfile("p7_test_csa.vcd");
        $dumpvars(0);
    end

    initial begin 
    $monitor($time,"a=%b,b=%b,carry_in=%b,sum=%b,carry_out=%b\n",
                    a   ,b   ,carry_in   ,sum   ,carry_out);

            a=16'd0;
            b=16'd0;
            carry_in=1'd1;
            #100;
         
            a=16'd128;
            b=16'd127;
            carry_in=1'd0;
            #100;

             a=16'd128;
            b=16'd127;
            carry_in=1'd1;

             a=16'd128;
            b=16'd128;
            carry_in=1'd0;
            #100;

             a=16'd128;
            b=16'd128;
            carry_in=1'd1;
            #100;

            a=16'h7000;
            b=16'h7000;
            carry_in=1'd1;
            #100;

            a=16'h8000;
            b=16'h8001;
            carry_in=1'd1;
            #100;

            a=16'h8000;
            b=16'h8001;
            carry_in=1'd0;
            #100;
            

    end

endmodule