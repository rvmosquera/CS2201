module mux5bits(inA, inB, out, select);

input inA;
input inB;
input select;
output out;

wire[4:0] inA, inB;
//reg[4:0] out;
wire[4:0] out;

//always @(inA or inB or select)
  assign out = (select==1)?inA:inB;

endmodule
//Testbench for mux5
module test_mux5bits;

reg[4:0] entradaA;
reg[4:0] entradaB;
wire[4:0] salida;
reg sel;

mux5bits mux5test(entradaA, entradaB, salida, sel);

initial
  begin
    entradaA = 5'hfa;
    entradaB = 5'h0f;
    sel = 1;
#10 entradaA = 5'h00;
#10 sel = 0;
#10 $finish;
  end

initial
	$monitor($time, "Entrada 1= %h Entrada 2 = %h resultado = %h selector = %h", 
		entradaA, entradaB, salida, sel);

endmodule