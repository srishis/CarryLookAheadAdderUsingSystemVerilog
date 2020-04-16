
module CLA4Bit(ain, bin, cin, sum, cout);

timeunit 1ns/1ns;
//parameter nBITS = 4;
input [3:0] ain, bin;
input cin;
output [3:0] sum;
output cout;

// internal variables/wires
logic [3:0] G, P;
logic [4:0] C;
logic [9:0] w;

// generate and propagate logic
assign #2 G = ain & bin;
assign #2 P = ain | bin;

assign C[0] = cin;

// carry out logic
// CO1 = G0 + CI0.P0 
assign #2 w[0] = P[0] & C[0];
assign #2 C[1] = G[0] | w[0];

// CO2 = G1 + G0.P1 + CI0.P1.P0 
assign  #2 w[1] = P[1] & G[0];
assign  #2 w[2] = P[1] & P[0] & C[0];
assign  #2 C[2] = G[1] | w[1] | w[2];

// CO3 = G2 +G1.P2 + G0.P1.P2 + CI0.P2.P1.P0 
assign  #2 w[3] = P[2] & G[1];
assign  #2 w[4] = P[2] & P[1] & G[0];
assign  #2 w[5] = P[2] & P[1] & P[0] & C[0];
assign  #2 C[3] = G[2] | w[3] | w[4] | w[5];

// CO4 = G3 + G2.P3 + G1.P2.P3 + G0.P1.P2.P3 + CI0.P0.P1.P2.P3
assign  #2 w[6] = P[3] & G[2];
assign  #2 w[7] = P[3] & P[2] & G[1];
assign  #2 w[8] = P[3] & P[2] & P[1] & G[0];
assign  #2 w[9] = P[3] & P[2] & P[1] & P[0] & C[0];
assign  #2 C[4] = G[3] | w[6] | w[7] | w[8] | w[9];

// carry output
assign cout = C[4];

// sum output 
assign #3 sum = ain ^ bin ^ C[3:0];


endmodule

module CLA4Top(ain, bin, cin, sum, cout);

timeunit 1ns/1ns;
input [3:0] ain, bin;
input cin;
output [3:0] sum;
output cout;

// instantiate CLA4 modules
CLA4Bit C1(.*);

// instantiate CLA4 modules
test#(4) TB(.*);

endmodule
