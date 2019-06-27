//Laboratorio 1: Ejercicio 1 - Mux 4 a 1
module mux41(inA, inB, inC, inD, sel,outX);

input inA, inB, inC, inD;
input sel;
output outX;

wire[1:0] inA;
wire[1:0] inB;
wire[1:0] inC;
wire[1:0] inD;
wire[1:0] sel;
wire[1:0] outX;

assign outX[1] = ( ~sel[1] & ~sel[0] & inA[1] ) | ( ~sel[1] & sel[0] & inB[1] ) |
		 ( sel[1] & ~sel[0] & inC[1] ) | ( sel[1] & sel[0] & inD[1] );

assign outX[0] = ( ~sel[1] & ~sel[0] & inA[0] ) | ( ~sel[1] & sel[0] & inB[0] ) |
		 ( sel[1] & ~sel[0] & inC[0] ) | ( sel[1] & sel[0] & inD[0] );

endmodule

module test_mux41;

reg[1:0] inputA;
reg[1:0] inputB;
reg[1:0] inputC;
reg[1:0] inputD;
reg[1:0] sel;
wire[1:0] out;

mux41 mux(inputA, inputB, inputC, inputD, sel, out);

initial
 begin
   inputA = 2'b01;
   inputB = 2'b00;
   inputC = 2'b11;
   inputD = 2'b10;

   #10 begin sel = 2'b00; end 
   #10 begin sel = 2'b01; end 
   #10 begin sel = 2'b10; end 
   #10 begin sel = 2'b11; end 
 end

initial
   $monitor($time,"inA = %h inB = %h inC = %h inD = %h \n Selection = %h Out = %h", 
	inputA, inputB, inputC, inputD, sel, out);

endmodule