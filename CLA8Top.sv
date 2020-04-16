module CLA8Top(ain, bin, cin, sum, cout);

timeunit 1ns/1ns;
input [7:0] ain, bin;
input cin;
output [7:0] sum;
output cout;

logic C; 

// instantiate CLA4 modules
CLA4Bit C1(ain[3:0], bin[3:0], cin, sum[3:0], C);
CLA4Bit C2(ain[7:4], bin[7:4], C, sum[7:4], cout);

// instantiate CLA4 modules
test#(8) TB(.*);

endmodule
