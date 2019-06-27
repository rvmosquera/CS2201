module complete26_32(inA, outB);

input inA;
output outB;

wire[25:0] inA;
wire[31:0] outB;

assign outB = inA;

endmodule

module test_complete32;

reg[25:0] entradaA;
wire[31:0] salida;

complete26_32 test(entradaA, salida);

initial
  begin
    entradaA = 26'h2acdef8;
#10 entradaA = 26'h9cfdff8; 
  end

initial
	$monitor($time, "Entrada 1= %h resultado = %h", 
		entradaA, salida);

endmodule