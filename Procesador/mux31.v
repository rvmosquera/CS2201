include "mux_lab5.v";

module mux32_31(inA, inB, inC, sel, outReg);

input inA;
input inB;
input inC;
input sel;
output outReg;

wire[31:0] inA;
wire[31:0] inB;
wire[31:0] inC;
wire[1:0] sel;
wire[31:0] out;
wire[31:0] outReg;

mux5 muxaddr1(inB, inC, out, sel[1]);
mux5 muxaddr2(inA, out, outReg, sel[0]);

endmodule

module test_mux31;

reg[31:0] inA;
reg[31:0] inB;
reg[31:0] inC;
reg[1:0] sel;
wire[31:0] outResult;

mux32_31 muxaddr(inA, inB, inC, sel, outResult);

initial
  begin
    inA = 32'hfafafafa;
    inB = 32'h0f0f0f0f;
    inC = 32'habcdefab;
    sel = 2'b01;
#10 sel = 2'b10;
#10 sel = 2'b00;
#10 $finish;
  end

initial
	$monitor($time, "Entrada 1= %h Entrada 2 = %h Entrada 3 = %h \nresultado = %h selector = %h", 
		inA, inB, inC, outResult, sel);

endmodule